package org.artauc.controller;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;

import org.artauc.domain.Criteria;
import org.artauc.domain.FCriteria;
import org.artauc.domain.FPageDTO;
import org.artauc.domain.FundPayVO;
import org.artauc.domain.FundVO;
import org.artauc.domain.PageDTO;
import org.artauc.service.ArtService;
import org.artauc.service.FundService;
import org.artauc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/fund/*")
public class FundController {
	
	@Setter(onMethod_ = @Autowired )
	private FundService fundService;
	
	@Setter(onMethod_ = @Autowired )
	private ArtService artService;
	
	@Setter(onMethod_ = @Autowired )
	private UserService userService;

	@PreAuthorize("hasRole('ARTIST')")
	@GetMapping("register")
	public void register() {
		log.info("FundController GET fund register......");
	}

	@PreAuthorize("hasRole('ARTIST')")
	@PostMapping("register")
	public String register(FundVO fvo, RedirectAttributes rttr) {
		log.info("FundController fund register......");

		if (fundService.register(fvo)) {
			log.info(fvo.getFno());
			rttr.addFlashAttribute("result", "fundsuccess");
		}else {
			// 펀딩 등록에 실패한 경우
			rttr.addFlashAttribute("result", "funderror");
			return "redirect:/fund/register";
		}
		return "redirect:/fund/list";
	}// 펀딩등록
	
	
	//@RequestMapping(value = "list", method = RequestMethod.GET)
	@GetMapping("list")
	public void list(Model model, FCriteria cri) {
	    log.info("FundController fund list......" + cri);

	    log.info(cri.getSort());
	    int totalCount = fundService.totalCount(cri);
	    
	    model.addAttribute("list", fundService.list(cri));
	    model.addAttribute("fpageDTO", new FPageDTO(cri, totalCount));
	}

	
	
	    @PreAuthorize("hasRole('ARTIST')")
		@GetMapping("myfundlist")
		public void myfundlist(@RequestParam("mid") String mid, Model model, FCriteria cri) {
			
			log.info("FundController fund My Funding......" + mid + cri);
			log.info("My Fund Mid : " +mid);
			log.info("My Fund Cri : " +cri);
			
			model.addAttribute("mid", mid);
			model.addAttribute("myfundlist", fundService.myfundList(mid, cri));
			int totalCount = fundService.myFundCount(mid, cri);
			log.info("myCnt"+totalCount);
			model.addAttribute("fpageDTO", new FPageDTO(cri, totalCount));
		}// 나의펀딩목록(작가가 쓴 펀딩게시글)
		
		
		
	    @PreAuthorize("isAuthenticated()")
		@GetMapping("mypaylist")
		public void mypaylist(@RequestParam("mid") String mid, Model model, Criteria cri) {
			
			log.info("FundController fund My Pay......" + mid + cri);
			
//			model.addAttribute("mid", mid);
			model.addAttribute("mypaylist", fundService.mypayList(mid, cri));
			int totalCount = fundService.myPayCount(mid, cri);
			log.info(totalCount);
			log.info(fundService.mypayList(mid, cri));
			model.addAttribute("pageDTO", new PageDTO(cri, totalCount));
		}
	
	// 펀딩 상세조회, 수정
	@GetMapping({ "view", "modify" })
	public void view(int fno, Model model, @ModelAttribute("cri") FCriteria cri) {

		log.info("FundController fund view or modify......");
		
		FundVO fvo = fundService.view(fno);
        
         //날짜를 "yyyy-MM-dd" 형식의 문자열로 변환
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String endDateStr = sdf.format(fvo.getEndDate());
        String startDateStr = sdf.format(fvo.getStartDate());
		
        model.addAttribute("endDate", endDateStr);
        model.addAttribute("startDate", startDateStr);
        model.addAttribute("artlist", artService.myartListF(fvo.getMid()));
        model.addAttribute("careerlist", userService.careerView(fvo.getMid()));
		model.addAttribute("fvo", fvo);
	}
	

	@PreAuthorize("hasRole('ADMIN') or hasRole('ARTIST')")
	@PostMapping("modify")
	public String modify(FundVO fvo, RedirectAttributes rttr, @ModelAttribute("cri") FCriteria cri) {
		log.info("FundController fund modify......");
		
		if (fundService.modify(fvo)) {
			rttr.addFlashAttribute("result", "modifyfund");
		} else {
			// 작품 수정에 실패한 경우
			rttr.addFlashAttribute("result", "modifyfunderror");
			return "redirect:/fund/modify";
		}
		
		log.info(fvo.getFno());
		rttr.addAttribute("fno", fvo.getFno());
		rttr.addAttribute("sort", cri.getSort());
//		rttr.addAttribute("type", cri.getType());
//		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());

		return "redirect:/fund/view";
	}// 펀딩수정
	

	@PreAuthorize("hasRole('ADMIN') or hasRole('ARTIST')")
	@PostMapping("remove")
	public String remove(int fno, RedirectAttributes rttr, @ModelAttribute("cri") FCriteria cri) {
		log.info("FundController fund remove......");

		if (fundService.remove(fno)) {
			rttr.addFlashAttribute("result", "funddelete");
		}else {
			rttr.addFlashAttribute("result", "funddeletererror");
			return "redirect:/fund/modify";
		}
		
		rttr.addAttribute("sort", cri.getSort());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());

		return "redirect:/fund/list";
	}
	
	
	//결제
	@PreAuthorize("isAuthenticated()")
	@RequestMapping(value = "fundingpay", method = { RequestMethod.POST })
	public ResponseEntity<String> paytest(@RequestParam("mid") String mid,
	        @RequestParam("fno") int fno, @RequestParam("amount") int amount) {
	    log.info("FundController POST fund paytest......");

	    if (fundService.payRegister(mid, fno, amount)) {
	    	
	        fundService.partcpntCntUpdate(fno);
	        
	    }else {
	    	return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	    return new ResponseEntity<>("success", HttpStatus.OK);

	}


	
//	@GetMapping("paytest") //테스트용
//	public void paytest() {
//	    log.info("FundController GET fund paytest......");
//	   
//	}

	

}
