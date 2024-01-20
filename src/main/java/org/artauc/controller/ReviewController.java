package org.artauc.controller;



import java.util.List;

import org.artauc.domain.ReviewVO;
import org.artauc.service.ReviewService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/review/*") // 이 경로의 파일을 전부 얘가 받게됨, .do
@AllArgsConstructor
public class ReviewController {
	
	private ReviewService rvService;
	
	//리뷰 목록
	@GetMapping(value="/{cno}") 
	//ajax라서 respose?
	public ResponseEntity<List<ReviewVO>> list(@PathVariable int cno) {
		log.info("reviewList......");
		return new ResponseEntity<List<ReviewVO>>(rvService.reviewClassList(cno), HttpStatus.OK);
		
	}
	
	//리뷰
	@GetMapping("myReview")
	@PreAuthorize("isAuthenticated()")
	public void mylist(Model model, String mid) {
		log.info("review mylist..........");
		model.addAttribute("mylist", rvService.reviewMyList(mid));
	}
	
	//리뷰 상세보기
	@GetMapping("reviewInfo")
	public void view(Model model, int rno) {
		log.info("reviewinfo...........");
		model.addAttribute("view", rvService.view(rno));
	}
	
	@GetMapping("reviewRegi")
	public void rvRegi() {
		log.info("review regi..........");
	}
	
	@PostMapping("reviewRegi")
	public String rvRegi(ReviewVO rvo, RedirectAttributes rttr) {
		log.info("rvRegi......." + rvo);
		if(rvService.rvRegi(rvo)) {
			rttr.addFlashAttribute("result", rvo.getRno());
		}
		return "redirect:/class/classInfo?cno=";
		
	}
	
	@GetMapping("reviewMod") //    Model = 값 가져올때
	public void rvUpdate(Model model, int rno) {
		log.info("reviewmodi.......");
		model.addAttribute("view", rvService.view(rno));
	}
	
	@PostMapping("reviewMod")
	public String rvUpdate(ReviewVO rvo, RedirectAttributes rttr) {
		log.info("rvModi......." + rvo);
		if(rvService.rvModify(rvo)) {
			rttr.addFlashAttribute("result","success");
		}
		return "redirect:/class/classInfo?cno=";
		
	}
	
	@PostMapping("reviewRem") //리뷰 삭제          하고 문구
	public String rvRemove(int rno, RedirectAttributes rttr) {
		log.info("remove....");
		if(rvService.rvRemove(rno)) {
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/class/classInfo?cno=";
		
	}
}
