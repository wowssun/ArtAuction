package org.artauc.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.artauc.domain.ArtVO;
import org.artauc.domain.Criteria;
import org.artauc.domain.PageDTO;
import org.artauc.service.ArtService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/art/*")
@AllArgsConstructor
public class ArtController {

	private ArtService artService;

	// 작품등록
	@PreAuthorize("hasRole('ARTIST')")
	@GetMapping("register")
	public void register() {
	}

	@PreAuthorize("hasRole('ARTIST')")
	@PostMapping("register")
	public String register(ArtVO avo, RedirectAttributes rttr) {
		log.info("ArtController register " + avo);

		if (artService.register(avo)) {
			
			rttr.addFlashAttribute("result", "artsuccess");
		
		}else {
			// 작품 등록에 실패한 경우
			rttr.addFlashAttribute("result", "arterror");
			return "redirect:/art/register";
		}
		return "redirect:/art/list";
	}

	// 작품전체목록
	@GetMapping("list")
	public void list(Model model, Criteria cri) {
		log.info("ArtController list......" + cri);

		model.addAttribute("list", artService.listAll(cri));
		int totalCount = artService.totalCount(cri);
		log.info(totalCount);
		model.addAttribute("pageDTO", new PageDTO(cri, totalCount));
	}

	
	@GetMapping("myartlist")
	@PreAuthorize("hasRole('ARTIST')")
	public void myartlist(@RequestParam("mid") String mid, Model model, Criteria cri) {

		log.info("ArtController My Art......");
		log.info("My Art Mid : " +mid);
		log.info("My Art Cri : " +cri);
		model.addAttribute("mid", mid);
		model.addAttribute("myartlist", artService.myartList(mid, cri));
		int totalCount = artService.myArtCount(mid, cri);
		log.info("My Art Cnt : " +totalCount);
		model.addAttribute("pageDTO", new PageDTO(cri, totalCount));
	}// 나의작품목록
	

	// 작품 사진만 가져오기
	@GetMapping("getArtImg")
	public ResponseEntity<ArtVO> getArtImg(int ano) {
		log.info("ArtController getArtImg.........");

		return new ResponseEntity<>(artService.view(ano), HttpStatus.OK);
	}

	// 작품 상세조회, 수정
	@GetMapping({ "view", "modify" })
	public void view(int ano, Model model, @ModelAttribute("cri") Criteria cri) {

		log.info("ArtController View or Modify " + ano);

		model.addAttribute("avo", artService.view(ano));

	}

	// 작품수정
	@PostMapping("modify")
	@PreAuthorize("hasRole('ADMIN') or hasRole('ARTIST')")
	public String modify(ArtVO avo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info("ArtController modify......");
		log.info(avo.getAno());
		
		if (artService.modify(avo)) {
			// 작품 수정에 성공한 경우
			rttr.addFlashAttribute("result", "modifysuccess");

		} else {
			// 작품 수정에 실패한 경우
			rttr.addFlashAttribute("result", "modifyerror");
			return "redirect:/art/modify";
		}
		
		rttr.addAttribute("ano", avo.getAno());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());

		return "redirect:/art/view";
	}

	
	// 첨부파일 삭제
	public void deleteFile(ArtVO art) {
		log.info("delete file........");

		if (art == null || art.getArtImg() == null) {
			return;
		}

		try {
			Path file = Paths.get(
					"c:\\upload\\"
							+ art.getArtImg());

			Files.deleteIfExists(file); // 사진 원본 지우기

			if (Files.probeContentType(file).startsWith("image")) {
				Path thumbnail = Paths.get(
						"c:\\upload\\"
								+ "/s_" + art.getArtImg());
				Files.deleteIfExists(thumbnail); // 사진 썸네일 지우기

			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 작품삭제
	@PostMapping("remove")
	@PreAuthorize("hasRole('ADMIN') or hasRole('ARTIST')")
	public String remove(String mid, int ano, RedirectAttributes rttr
			, @ModelAttribute("cri") Criteria cri) {

		log.info("ArtController remove " + ano);

		ArtVO art = artService.view(ano);

		if (artService.remove(ano)) {
			deleteFile(art); // 작품 삭제할 때 폴더에 저장된 사진도 지우기
			
			rttr.addFlashAttribute("result", "artdelete");
			
		}else {
			// 작품 삭제에 실패한 경우
			rttr.addFlashAttribute("result", "artdeleteerror");
			return "redirect:/art/modify";
		}

		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());

		return "redirect:/art/list";
	}

}