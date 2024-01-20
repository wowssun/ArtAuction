package org.artauc.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;

import java.util.Date;




import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.artauc.domain.ArtistVO;


import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	
				// 현재 시점의 '연/월/일' 폴더 경로 문자열을 생성하여 반환
				public String getFolder() {
					Date date = new Date();     // Date 객체 생성 (현재 시점)
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");    // SimpleDateFormat으로 날짜 패턴지정
					
					String now = dateFormat.format(date);				// 지정한 패턴으로 변경
					
							
					return now.replace("-", File.separator);     // - 를 찾아서 '연\월\일' 폴더 경로로 반환
				}
	
				
				// 이미지 파일 여부 확인
				public boolean isImage(File file) {
					
					try {
						String contentType = Files.probeContentType(file.toPath());  // 이 파일의 컨텐트 타입을 받아온다.
																					 // 확장자로 판단하는것이 x		
						
						return contentType.startsWith("image");
					} catch (IOException e) {
						e.printStackTrace();
					}      
					
					return false;
				} // isImage end
				
				// 썸네일 이미지 파일 전송
				@GetMapping("/display")   // display 앞에 upload 경로가 하나 더 있어서 /display
				public ResponseEntity<byte[]>display(String fileName){
					
					File file =  new File("c:\\upload\\" + fileName);
					 ResponseEntity<byte[]> result = null;
					 
					 try {
						 // import org.springframework.http.HttpHeaders;   header import할때 이걸로 들어감.
						 HttpHeaders header = new HttpHeaders();
						 header.add("Content-Type", Files.probeContentType(file.toPath()));
					 
					 result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),header, HttpStatus.OK);
				
					 }catch(IOException e){
						 e.printStackTrace();
					 }
					 	return result;	
				}// 썸네일 이미지 파일 전송 end
				
				
				
				// 파일 삭제
				@PostMapping("/deleteFile")
				// @PreAuthorize("isAuthenticated()")
				public ResponseEntity<String> deleteFile(String fileName, String type){
					// 파일 이름이랑, 이미지면 썸네일도 지워야 하기 때문에 type도 받아오기.
					// 파일 이름 decode
					log.info("delete file : " + fileName);
					
					try {
						File file =  new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
						
						file.delete();			// s_붙은 썸네일 이미지 삭제 -> 화면에 처리된건 지금 썸네일이니까 파일 이름 가져오면 s_붙어있음.
						
						if(type.equals("image")) {
							
							String originaFile = file.getAbsolutePath().replace("s_", "");   // 절대경로? 를 가져와서 s_를 찾고 변경
							
							log.info(originaFile);
							file = new File(originaFile);
							
							file.delete();    // 원본 이미지 파일 삭제
						
						}
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
					}
					
					
					return new ResponseEntity<String>("deleted", HttpStatus.OK);
				}
				
				// 파일 삭제 end
				
							
				// 폼에서 받아와서 처리하는건 이거고 배열로 받기 . 이제 폼을 전송하는건 post로 처리
				@PostMapping("/upload/ajaxAction")
				public ResponseEntity<ArtistVO>ajaxAction(MultipartFile photo) {	// 여기 받는 이름이랑 formtag에  input name이랑 같게한다.
						
					log.info("ajaxAction upload.....");
					String upPath = "c:\\upload\\";        // 파일 저장 경로
					 File upFolder = new File(upPath);
					// 연\월\일 폴더 생성
					//File upFolder = new File(upPath,getFolder()); 
					
					/* 생성된 폴더가 존재하지 않는 경우 폴더 만들기
					if(!upFolder.exists()) { // 파일 존재하는지 여부 boolean
						upFolder.mkdirs(); // 폴더 생성
					}*/
					
					 // 파일 정보 확인하기
						log.info("name : " + photo.getOriginalFilename());
						log.info("size : " + photo.getSize());
						log.info("----------------");						
						
						// UUID를 이용하여 파일명 중복 방지 처리
						
						// UUID uuid = UUID.randomUUID();   
					   // fa41bf22-993f-440a-8494-8192e5fd15a0 이런식으로 생성된다.
						
					// 'UUID'값 _ 파일명
					 String upFileNm = photo.getOriginalFilename();
						
					
						// saveFile.exists();  // 파일 존재하는지 여부 boolean
					   //  saveFile.mkdirs(); // 폴더 생성
					
						// 이제는 사진 하나만 저장하면 되니까 vo에 이름만 저장하기.
						ArtistVO arvo = new ArtistVO();
						arvo.setPhoto(photo.getOriginalFilename());
								
						 File saveFile = new File(upPath ,upFileNm);  // 위에 선언해놓은 경로로 파일 save	
						//File saveFile = new File(upFolder , upFileNm);  // 위에 선언해놓은 경로로 파일 save
						// 이렇게 하면 연\월\일 폴더로 경로가 만들어지고 마지막에 파일이 들어간다.
							
						
						try {
							photo.transferTo(saveFile);   // 파일 업로드 처리
							
							 // 이미지 파일의 경우 썸네일 이미지 만들기
							//  파일명이 's_'로 시작하도록 처리   -> 이미지 파일이면
							if(isImage(saveFile)) { 

								FileOutputStream fos = new FileOutputStream(
										new File(upFolder, "s_" + upFileNm));
								
								// 썸네일 생성, 사진의 파일 크기도 줄어든다.
								Thumbnailator.createThumbnail(
										photo.getInputStream(),fos,100,100);
								fos.close();
							}
						}catch(IllegalStateException e) {
							e.printStackTrace();
						}catch(IOException e) {
							e.printStackTrace();
						}
						
					return new ResponseEntity<>(arvo,HttpStatus.OK);
					
				}  //end
	
		 
	
		
}	