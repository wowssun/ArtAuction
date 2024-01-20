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
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class ArtUploadController {
	
	//이미지인지 확인
	public boolean isImage(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());

			
			return contentType.startsWith("image"); //image
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
	
	//이미지 view
	@GetMapping("/artdisplay")
	public ResponseEntity<byte[]> display(String fileName){
		
		File file = new File("c:\\upload\\" + fileName);
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	


	@PostMapping("/artdeleteFile")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> deleteFile(String fileName, String type){
		log.info("delete file : " + fileName);
		
		try {
			File file = new File("c:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			
			
			if(type.equals("image")) {
				String originFile = file.getAbsolutePath().replace("s_", "");
				log.info(originFile);
				file = new File(originFile);
				file.delete();
				
			}
			
		} catch (UnsupportedEncodingException e) {
            e.printStackTrace();
         }   
		
		return new ResponseEntity<>("deleted", HttpStatus.OK);
	}




	@PreAuthorize("isAuthenticated()")
	@PostMapping("/artupload/ajaxAction")
	   public ResponseEntity<ArtVO> uploadAjax(MultipartFile artImg) {
	      log.info("---------------------upload ajax");
	      String upPath = "c:\\upload\\";
	      File upFolder = new File(upPath);


	      if (artImg != null && !artImg.isEmpty()) {
	         log.info("name : " + artImg.getOriginalFilename());
	         log.info("size : " + artImg.getSize());
	         log.info("----------------------------");}

	         
	
				UUID uuid = UUID.randomUUID();
				String upFileNm = uuid + "_" + artImg.getOriginalFilename();
				File saveFile = new File(upFolder, upFileNm);
				

				ArtVO avo = new ArtVO();
				avo.setArtImg(upFileNm);
				log.info("setArtImgName : " + upFileNm);
				
	         try {

	        	 artImg.transferTo(saveFile); 
	  
	            if(isImage(saveFile)) {
	            
	             FileOutputStream fos = new FileOutputStream(new File(upFolder, "s_" + upFileNm));
	             Thumbnailator.createThumbnail(artImg.getInputStream(), fos, 100, 100);
	             
	             fos.close();
	             
	            }
	         } catch (IllegalStateException e) {
	            e.printStackTrace();
	         } catch (IOException e) {
	            e.printStackTrace();
	         }   
	        
	      return new ResponseEntity<>(avo, HttpStatus.OK);

	   }
	
	
	@GetMapping("/artupload/ajaxAction")
	public void uploadAjax() {
		log.info("upload ajax");
	}
	
	
	@PostMapping("/artupload/formAction")
	public void uploadAction(MultipartFile artImg) {
		log.info("upload action");
		String upPath = "c:\\upload\\"
				+ "";
	
			log.info("name : " + artImg.getOriginalFilename());
			log.info("size : " + artImg.getSize());
			log.info("----------------------------");
			
			File saveFile = new File(upPath, artImg.getOriginalFilename());
			
			try {
				artImg.transferTo(saveFile);	
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}	
		}
	
	
	@GetMapping("/artupload/formAction")
	public void uploadForm() {
		log.info("upload form");
	}
}





