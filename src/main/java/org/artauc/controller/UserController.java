package org.artauc.controller;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.artauc.domain.ArtistVO;
import org.artauc.domain.CareerVO;
import org.artauc.domain.MemberVO;
import org.artauc.domain.RequestVO;
import org.artauc.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
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
@RequestMapping("/user/*")
@Log4j
public class UserController {
	
	@Setter(onMethod_ = @Autowired )
	private UserService us;
	
	
	// 마이페이지 userMypage.jsp
	@GetMapping("mypage")
	@PreAuthorize("hasAnyRole('ROLE_ARTIST','ROLE_ADMIN','ROLE_USER')")
     public void mypage(String mid){ 
		
	}
	
	// 내 정보 보기 , 수정  myInfo.jsp myInfoModify.jsp
	
	@GetMapping({"myinfo" , "modify"})
	public void myinfo (String mid ,Model model) {
		
		// 여기서 로그인한 아이디가 들어가야함.
		// 일단 레이아웃만 테스트하고 나중에 변경하기
		// 그럼 security로 아이디를 넣어서 처리?
		
		log.info("myinfo..");
		
		model.addAttribute("mvo", us.view(mid));
		
		// 수정화면으로 보낼때 이메일이랑 번호 selected로 만들어놓기 위해서
		// 잘라서 가져가기
		String fullEmail = us.view(mid).getEmail();
		String[] emailParts = fullEmail.split("@");
		String email1 = emailParts[0]; // 이메일 아이디부분
		String email2 = emailParts[1]; // 이메일 도메인부분

		model.addAttribute("email1", email1);
		model.addAttribute("email2", email2);
		
		String fullNum = us.view(mid).getPhone();
		String[] numParts = fullNum.split("-");
		String phone1 = numParts[0];
		String phone2 = numParts[1];
		String phone3 = numParts[2];
		
		model.addAttribute("phone1", phone1);
		model.addAttribute("phone2", phone2);
		model.addAttribute("phone3", phone3);

	}
	
	 @PostMapping("modify") 
	 @PreAuthorize("hasRole('ROLE_ADMIN') or principal.username == #mvo.mid")
     public String modify(MemberVO mvo, RedirectAttributes rttr,Model model) {
		 log.info("modify..");
		 
		 log.info("mvo" + mvo);
		 
		 if(us.modify(mvo)) {
			 
			 model.addAttribute("mid", mvo.getMid());
			 rttr.addFlashAttribute("result", "modify success");
		 }
		 
		 
		// return null;
		 return "redirect:/user/mypage" ;
	 }
	 
	 // 회원 탈퇴
	 @PostMapping("remove")
	 @PreAuthorize("hasRole('ROLE_ADMIN') or principal.username == #mid")
	 public String remove(String mid, RedirectAttributes rttr,HttpServletRequest request, HttpServletResponse response) {
		 
		 log.info("remove...회원탈퇴" + mid);
		 
		 if(us.remove(mid)) {
			 
			// 로그아웃 수행
			//인스턴스를 생성
		        SecurityContextLogoutHandler logoutHandler = new SecurityContextLogoutHandler();
		     // 사용자의 HTTP 세션을 무효화(invalidate)하도록 설정
		        logoutHandler.setInvalidateHttpSession(true);
		      // 실제 로그아웃을 수행
		        logoutHandler.logout(request, response, SecurityContextHolder.getContext().getAuthentication());
		        
		        rttr.addFlashAttribute("result", "remove success");
		 }
		 
		 return "redirect:/artauction/main" ;
	 }
	 
	 // 작가 신청 artistReq.jsp
	 
	 @GetMapping("request")
	 public void request () {
		 log.info("request....");
	 }
	 
	 
	 @PostMapping("request") 
	 @PreAuthorize("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
	 public String request (ArtistVO avo, RedirectAttributes rttr,Model model) {
		 log.info("request..post.");
		 
		 if(us.register(avo)) {  // 작가 정보 등록하고
			 
			 model.addAttribute("mid", avo.getMid());
			 rttr.addFlashAttribute("result", "request success");
		 }
		 
		 return "redirect:/user/mypage" ;
	 }
	 
	 // 작가 신청 조회 하기 rqcheck.jsp
	 
	 @GetMapping("rqcheck")
	 public void rqcheck () {
		 
	 }
	 
	 @PostMapping(value ="rqcheck" , produces = "application/text; charset=utf8") 
	 @ResponseBody
	 @PreAuthorize("hasAnyRole('ROLE_ARTIST','ROLE_ADMIN','ROLE_USER')")
	 public  String rqcheck  (String mid) {
		 
		  log.info("rqcheck....");
		  
		 List<RequestVO> results = us.artSearch(mid);
		 
		 String state = "";
		 
		 if (results != null && !results.isEmpty()) {
		     RequestVO first = results.get(0);
		      state = first.getState();
		      
		      System.out.println(state);
		 }
		 
		 // 신청이 거절일때 또 신청하면 아이디가 겹친다.
		 // 그럼 아이디에 대한 상태가 2개이상 넘어올 수 있다.
		 // 그래서 신청날짜를 기준으로 최신순 정렬한뒤 첫번째 값만 가져오기
		 								  
		
		
		 return state;
	 }
	 
	// - get /user/mypage  public void mypage  (String mid)  // 마이페이지 view // 작가 마이페이지 view artistrMypage.jsp
	 
	 // 작가 정보 보기 , 수정  artistInfo.jsp artistInfoModify.jsp
	 
	 @GetMapping({"artview" , "artmodify"})
	 public void artview  (String mid ,Model model) {
		 
		 log.info("artview..");
			
			model.addAttribute("avo", us.artView(mid));
			 model.addAttribute("career", us.careerView(mid));
	 }
	 
	 // 작가 정보 수정
	 
	 @PostMapping("artmodify") 
	 //@PreAuthorize("hasAnyRole('ROLE_ARTIST','ROLE_ADMIN')")
	 public String artmodify  (ArtistVO avo, RedirectAttributes rttr,Model model) {
		 
		 log.info("artmodify..");
		 
		 log.info("avo" + avo);
		 
		 if(us.artModify(avo)) {
			 
			 model.addAttribute("mid", avo.getMid());
			 rttr.addFlashAttribute("result", "artmodify success");
		 }
		 
		 
		// return null;
		 return "redirect:/user/mypage" ;
	 }
	
	// 작가 사진만 가져오기
		@GetMapping(value = "getPhoto")
		public ResponseEntity<ArtistVO> getArtImg(String mid) {
			log.info("user getPhoto.........");

			return new ResponseEntity<>(us.artView(mid), HttpStatus.OK);
		}

		// 작가 신청 정보 가져오기 rqview.jsp
		 
		 @GetMapping("rqview")
		 @PreAuthorize("hasAnyRole('ROLE_ARTIST','ROLE_ADMIN')")
		 public void rqview (String mid ,Model model) {
			 
			 log.info("rqview..");
			 
			 model.addAttribute("avo", us.artView(mid));
			 model.addAttribute("career", us.careerView(mid));
		
		 }
		 
		// 작가 이력만 가져오기
			@GetMapping(value = "getCareer")
			public ResponseEntity<List<CareerVO>> getCareer(String mid) {
				log.info("user getCareer.........");

				return new ResponseEntity<>(us.careerView(mid), HttpStatus.OK);
			}
	
}
