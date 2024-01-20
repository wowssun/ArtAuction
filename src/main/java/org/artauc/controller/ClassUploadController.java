package org.artauc.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.artauc.domain.ArtVO;
import org.artauc.domain.AttachFileDTO;
import org.artauc.domain.ClassVO;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
@AllArgsConstructor
public class ClassUploadController {

	@GetMapping("/upload/cFormAction")
	public void formAction() {
		log.info("formaction...........!");
	}

	// 이미지 파일 여부 확인
	public boolean isImage(File file) {

		try {
			String contentType = Files.probeContentType(file.toPath());

			System.out.println(contentType);
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}

		return false;
	}

	// 썸네일 이미지 파일 전송
	@GetMapping("/cDisplay")
	public ResponseEntity<byte[]> display(String filename) {
		File file = new File("c:\\upload\\" + filename);
		ResponseEntity<byte[]> result = null;

		HttpHeaders header = new HttpHeaders();
		try {
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//파일삭제
		@PostMapping("/cDeleteFile")
		@PreAuthorize("isAuthenticated()")
		public ResponseEntity<String> deleteFile(String filename, String type){
			log.info("delete file : " + filename);
			
			try {
				File file = new File("c:\\upload\\" + URLDecoder.decode(filename, "UTF-8"));
				file.delete();
				
				
				if(type.equals("image")) {
					String originFile = file.getAbsolutePath().replace("s_" , "");
					log.info(originFile);
					file = new File(originFile);
					file.delete();
					
				}
				
			} catch (UnsupportedEncodingException e) {
	            e.printStackTrace();
	         }   
			
			return new ResponseEntity<>("deleted", HttpStatus.OK);
		}
	

	// 업로드 결과 목록 반환
	// 업로드
	@GetMapping("/upload/cAjaxAction")
	public void uploadAjax() {
		log.info("upload ajax");
	}

	// 파일 업로드 //업로드 결과 목록 반환
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/upload/cAjaxAction") // 넘어갈때
	public ResponseEntity<ClassVO> uploadAjaxAction(MultipartFile classimg) { //db와 같아야함
		log.info("file upload ajaxAction..............");
		String upPath = "c:\\upload";
		File upFolder = new File(upPath); // upPath 경로 안에 만들것이라 들어가야함

		// 생성된 폴더가 존재하지 않는 경우 폴더 생성
		if (!upFolder.exists()) {
			upFolder.mkdirs();
		}

		if (classimg != null && !classimg.isEmpty()) {
			// 확인용
			log.info("name: " + classimg.getOriginalFilename());
			log.info("size: " + classimg.getSize());
			log.info("------------------------------------");
		}

		// UUID를 이용하여 파일명("UUID 값_ 파일명") 중복 방지 처리
		UUID uuid = UUID.randomUUID();
		String upFileNm = uuid + "_" + classimg.getOriginalFilename();
		File saveFile = new File(upFolder, upFileNm);

		ClassVO cvo = new ClassVO();
		cvo.setClassimg(upFileNm);
		log.info("setclassimgName : " + upFileNm);
		
		try {
			classimg.transferTo(saveFile); // 파일 업로드 처리

			// 섬네일 이미지 만들기
			FileOutputStream fos = new FileOutputStream(new File(upFolder, "s_" + upFileNm));
			Thumbnailator.createThumbnail(classimg.getInputStream(), fos, 100, 100); // 가로, 세로

			fos.close();
			log.info("업로드 컨트롤러 끝나써?");
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<>(cvo, HttpStatus.OK);
	}

}
