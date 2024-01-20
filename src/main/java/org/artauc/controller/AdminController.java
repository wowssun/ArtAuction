package org.artauc.controller;




import org.artauc.domain.Criteria;
import org.artauc.domain.RequestVO;
import org.artauc.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.artauc.domain.PageDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/admin/*")
@Log4j
public class AdminController {
	
	@Setter(onMethod_ = @Autowired )
	private AdminService as;
	
	// 관리자 메뉴 adminPage.jsp
	
	@GetMapping("adminPage")
	@Secured("ROLE_ADMIN")
	public void mypage  (String mid,Criteria cri,Model model) {
		log.info("adminPage");
		
		model.addAttribute("ucount",as.mtotalCount(cri));
		
		model.addAttribute("acount",as.atotalCount(cri));
		
		model.addAttribute("lcount",as.locktotalCount(cri));
		
		model.addAttribute("rcount",as.rtotalCount(cri));
		
	}
	
	// 회원목록 userList.jsp
	
	@GetMapping("userList")
	@Secured("ROLE_ADMIN")
	public void userlist (Model model, Criteria cri) {
		log.info("userList..." + cri);
		
		model.addAttribute("list", as.list(cri));
		
		model.addAttribute("pageDTO", new PageDTO(cri,as.mtotalCount(cri)));
		
		model.addAttribute("count",as.mtotalCount(cri));
	}
	
	// 잠금회원목록 userLockList.jsp
	
	@GetMapping("userLockList")
	@Secured("ROLE_ADMIN")
	public void locklist(Model model, Criteria cri) {
		log.info("userLockList.." + cri);
		
		model.addAttribute("list", as.lockList(cri));
		
		model.addAttribute("pageDTO", new PageDTO(cri,as.locktotalCount(cri)));
		
		model.addAttribute("count",as.locktotalCount(cri));
		
	}
	
	// 잠금해제하기
	
	@PostMapping(value ="unlock", produces = "text/plain")
	@ResponseBody
	@Secured("ROLE_ADMIN")
	public String unlock(String mid) {
		log.info("unlock" + mid);
		
		String result;
		
		if(as.lockModify(mid)) {
			result = "true";
		}else {
			result = "false";
		}
		 		
		return result;
	}
	
	// 작가회원목록 artistList.jsp
	
	@GetMapping("artistList")
	@Secured("ROLE_ADMIN")
	public void artuserlist(Model model, Criteria cri) {
		log.info("artistList");
		
		model.addAttribute("list", as.artList(cri));
		
		model.addAttribute("pageDTO", new PageDTO(cri,as.atotalCount(cri)));
		
		model.addAttribute("count",as.atotalCount(cri));
	}
	
	// 작가신청목록 artistReqList.jsp
	
	@GetMapping("rqList")
	@Secured("ROLE_ADMIN")
	public void rqlist (Model model, Criteria cri) {
		log.info("rqList.." + cri);
		
		model.addAttribute("list", as.requeList(cri));
		
		model.addAttribute("pageDTO", new PageDTO(cri,as.rtotalCount(cri)));
		
		model.addAttribute("count",as.rtotalCount(cri));
		
	}
	
	// artistReqView.jsp
	//- get /admin/rqview     public void rqview (String mid ,Model model, @ModelAttribute("cri") Criteria cri)   // 작가 신청상세조회 view select
	
	// 작가 신청 승인 거절
	/*  
	POST(작가 승인 / 거절 )	
	/admin/rqview
	/admin/approval   작가 승인
	/admin/refuse  작가 거절   */
	
	
	@PostMapping(value ="state" , produces = "text/plain")
	@ResponseBody
	@Secured("ROLE_ADMIN")
	 public String state (RequestVO rvo, RedirectAttributes rttr,@ModelAttribute("cri") Criteria cri) {
		log.info("unlock" + rvo);
		
		String result;
		
		if(as.stateModify(rvo)) {
			result = "true";
		}else {
			result = "false";
		}
		 		
		return result;
	}
	
	
	// 작가 승인 / 거절 목록 checkList.jsp
	
	@GetMapping("checkList")
	@Secured("ROLE_ADMIN")
	public ModelAndView checklist   (Model model, Criteria cri) {
		log.info("checkList.." + cri);
		
		model.addAttribute("list", as.okNoList(cri));
		
		model.addAttribute("pageDTO", new PageDTO(cri,as.oknototalCount(cri)));
		
		model.addAttribute("count",as.oknototalCount(cri));
		
		 ModelAndView list = new ModelAndView("/admin/checkList");
	      
	      list.addObject("pageDTO",new PageDTO(cri,as.oknototalCount(cri)));
	      list.addObject("count", as.oknototalCount(cri));
	      list.addObject("list", as.okNoList(cri)); 
	      
	      return list;
		
		
	}
	
	// 작가 승인 목록 checkList.jsp
	
		@GetMapping("okList")
		@Secured("ROLE_ADMIN")
		public ModelAndView okList   (Model model, Criteria cri) {
			log.info("okList.." + cri);
			
			model.addAttribute("list", as.okList(cri));
			
			model.addAttribute("pageDTO", new PageDTO(cri,as.oktotalCount(cri)));
			
			model.addAttribute("count",as.oktotalCount(cri));
		      
		      ModelAndView list = new ModelAndView("/admin/checkList");
		      
		      list.addObject("pageDTO",new PageDTO(cri,as.oktotalCount(cri)));
		      list.addObject("count", as.oktotalCount(cri));
		      list.addObject("list", as.okList(cri)); 
		      
		      return list;
			
		}
		
		// 작가 거절 목록 checkList.jsp
		
		@GetMapping("noList")
		@Secured("ROLE_ADMIN")
		public ModelAndView noList   (Model model, Criteria cri) {
			log.info("noList.." + cri);
			
			model.addAttribute("list", as.noList(cri));
			
			model.addAttribute("pageDTO", new PageDTO(cri,as.nototalCount(cri)));
			
			model.addAttribute("count",as.nototalCount(cri));
			
			ModelAndView list = new ModelAndView("/admin/checkList");
		      
			list.addObject("pageDTO",new PageDTO(cri,as.nototalCount(cri)));
			list.addObject("count", as.nototalCount(cri));
			list.addObject("list", as.noList(cri)); 
		      
		      return list;
			
		}
	
	// 회원 삭제
		 @PostMapping("remove")
		 @Secured("ROLE_ADMIN")
		 public String remove(String mid, RedirectAttributes rttr) {
			 
			 log.info("remove...회원삭제" + mid);
			 
			 if(as.remove(mid)) {
			        
				 rttr.addFlashAttribute("result", "remove success");   // 회원 삭제하면 목록으로 돌아가서 삭제되었습니다. 알림창 처리하기
			 }
			 
			 return "redirect:/admin/userList" ;
		 }


	
	
	
	
}
