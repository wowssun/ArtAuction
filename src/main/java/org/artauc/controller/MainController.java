package org.artauc.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.artauc.domain.MemberVO;
import org.artauc.service.ArtService;
import org.artauc.service.AucService;
import org.artauc.service.MainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/artauction/*")
@Log4j
public class MainController {
	
	@Setter(onMethod_ = @Autowired )
	private MainService ms;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwEncoder;
	
	@Setter(onMethod_ = @Autowired )
	private AucService as;
	
	@Setter(onMethod_ = @Autowired )
	private ArtService artService;
	

	// 메인
	
	@GetMapping("main")
	public void main (Model model) {
		model.addAttribute("list", as.selectAll());
		model.addAttribute("artlist", artService.list());
		log.info("main.jsp");
		
	}
	
	// 로그인 userLogin.jsp
	
		@GetMapping("userLogin")
		public String customLogin(String error, String logout, Model model) {
			
			log.info("------------userLogin---------------");
			log.info("error : " + error);
			log.info("logout : " + logout);
			
			if(error !=null){
				model.addAttribute("error","로그인 에러 - 계정을 확인해주세요");
				
			}
			
			if(logout !=null) {
				model.addAttribute("logout", "로그아웃이 완료되었습니다.");
			}
			
			return "/artauction/userLogin";
		}
		
		
		  // 로그아웃
		 
		 @PostMapping("userLogout") 
		 public void customLogout () {
			 log.info("logout....");
		 
		   }
		
		 // 회원가입 userJoin.jsp
		
		 @GetMapping("userJoin")  
		 public void join() {
			 
		 }
		 
		 @PostMapping("userJoin") 
		 public String join(MemberVO mvo, RedirectAttributes rttr) {
			 log.info("join....");
			 
			mvo.setPw(pwEncoder.encode(mvo.getPw()));   // 비밀번호 encode하기
			 
			 if(ms.register(mvo)) { 	
					
					rttr.addFlashAttribute("result", "join success");    // 그럼 result 이름으로 보내진다. 
				}
			  
			 return "redirect:/artauction/main" ;  // 메인페이지로이동
			 
			// jsp 파일로 보내면 안되고 mapping 된 list로 보내야 한다. 리턴하고 다시 가는 곳이 같으면  void 사용
		   // 그렇지 않을때는 String 으로 
		 }
		 
		 @GetMapping("accessDenied")
			public String denied(Model model) {
				
				log.info("-------------accessDenied----------------");
				
				// model에 담아서 jsp 페이지로 보내기
				model.addAttribute("msg", "접근 불가 - 권한 부족");
				
				return "/artauction/accessDenied";
			}
		 
		 // 아이디 중복체크
		 
		 @PostMapping(value ="idcheck" , produces = "text/plain") 
		 @ResponseBody
		 public String idcheck(String mid) {
			 log.info("idcheck....");
			 	 
			 if (ms.idCheck(mid)) {
			        // 중복된 경우
			        return "no";
			    } else {
			        // 중복되지 않은 경우
			        return "ok";
			    }
			 
		 }
		 
		 // 아이디 찾기 idSearch.jsp
		 
		 @GetMapping("idSearch") 
		  public void idsearch() {
			 log.info("idSearch.....");	
		 }
		 
		 @PostMapping(value = "idSearch" ,produces = "text/plain") 
		 @ResponseBody
		 public String idsearch(String name,  String phone) {
			 
			String mid =  ms.midSearch(name, phone);  // return mid
			 
			 log.info("idSearch.....");	
			 
			 return mid;
		 }
		 
		 // 비밀번호 찾기 pwSearch.jsp
		 
		 @GetMapping("pwSearch") 
		 public void pwsearch () {
			 log.info("pwsearch.....");	
		 }
		 
		 @PostMapping(value ="pwSearch" ,produces = "text/plain") 
		 @ResponseBody
		  public String pwsearch (String mid, String name, String phone, Model model) {
			 log.info("pwsearch.....");	
			
			if(ms.pwSearch(mid, name, phone)){
				
				model.addAttribute("mid", mid);
				return "ok";
			}
			 return "no";
		 }
		 
		 // 비밀번호 변경 pwChange.jsp
		 
		 @GetMapping("pwChange")  // 흠... 여기 가지고 오는게 있나? 그냥 그 정보만 맞다면 아이디만 가져오자.
		 public void pwChange(MemberVO mvo,Model model) {
			 log.info("pwChange.....");	
			 
			 // pwSearch에서 mvo 넘어온거 다시 담아서 보내줘야 함.
			 // 그리고 거기서 mvo에서 mid를 다시 post로 보낼때 필요하다.
		 }
		 
		 @PostMapping(value = "pwChange") 
		 public String pwChange(MemberVO mvo,RedirectAttributes rttr,HttpServletRequest request, HttpServletResponse response) {
			 
			 log.info("pwChange......");
			 mvo.setPw(pwEncoder.encode(mvo.getPw()));   // 비밀번호 encode하기
			
			 if(ms.pwModify(mvo)) { 
				// 로그아웃 수행
					//인스턴스를 생성
				        SecurityContextLogoutHandler logoutHandler = new SecurityContextLogoutHandler();
				     // 사용자의 HTTP 세션을 무효화(invalidate)하도록 설정
				        logoutHandler.setInvalidateHttpSession(true);
				      // 실제 로그아웃을 수행
				        logoutHandler.logout(request, response, SecurityContextHolder.getContext().getAuthentication());
				 
					rttr.addFlashAttribute("result", "change success");    // 여긴 result에 success를 보낸다.
				}
			
			 return "redirect:/artauction/userLogin" ; 
		 }
	 	
	
}
