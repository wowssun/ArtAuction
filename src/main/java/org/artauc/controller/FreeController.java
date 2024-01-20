package org.artauc.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
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
import org.artauc.domain.FreeAttachVO;
import org.artauc.domain.FreeVO;
import org.apache.ibatis.annotations.Param;
import org.artauc.domain.Criteria;
import org.artauc.domain.PageDTO;
import org.artauc.service.FreeService;
import org.artauc.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/free/*")
public class FreeController {
	
	@Setter(onMethod_ =@Autowired )
	private FreeService fs;
	
	@Setter(onMethod_ =@Autowired )
	private ReplyService rs;
	
	
	
	// 첨부 파일 삭제  
	public void deleteFiles(List<FreeAttachVO>attachList) {
	log.info("delete files.....");
		
		if(attachList == null || attachList.size() == 0) {
			return;
		}
		
		attachList.forEach(favo -> {
			Path file = Paths.get("c:\\upload\\" + favo.getUpFolder() + "\\" +
												   favo.getUuid() + "_" +
												   favo.getFileName());
			try {
				Files.deleteIfExists(file);
				
				if(Files.probeContentType(file).startsWith("image")) {
					Path thumbnail = Paths.get("c:\\upload\\" + 
											   favo.getUpFolder() + "\\s_" +
											   favo.getUuid() + "_" +
											   favo.getFileName());
					Files.deleteIfExists(thumbnail);
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		});
		
	}
	
	
	@PostMapping("modify")
	@PreAuthorize("principal.username == #fvo.mid")
	public String modify(FreeVO fvo, RedirectAttributes rttr,@ModelAttribute("cri") Criteria cri) {		// 파라미터로 bno를 받아야함.		
		log.info("modify......");
		
		if(fs.modify(fvo)) {
			rttr.addFlashAttribute("result", "modify success");    // 여긴 result에 success를 보낸다.
		}
		
	//	int pageNum = cri.getPageNum(); 이렇게 받아서 보내지 말고 밑의 방법처럼 보냄.
	//	int amount = cri.getAmount();	rttr에 담아서 ~~
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("type", cri.getType());
		
		return "redirect:/free/list";
	}
	
	
	@PostMapping("remove")
	@PreAuthorize("principal.username == #mid")
	public String remove(String mid, int frno, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {		// 파라미터로 bno를 받아야함.		
		
		log.info("remove......");
		
		// 미리 리스트를 받아놓고
		List<FreeAttachVO>attachList =  fs.attachList(frno);		
		
		if(fs.remove(frno)) {  // 지우기에 성공하면
			
			// 첨부파일 삭제
			deleteFiles(attachList);
			
			rttr.addFlashAttribute("result", "remove success");    // 그럼 result 이름으로 보내진다. 
		}
			
		//int pageNum = cri.getPageNum();
		//int amount = cri.getAmount();
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("type", cri.getType());
		
		return "redirect:/free/list" ;
	}
	
	
	// 하나 조회하기, view 처럼 번호 하나를 받아서 수정도 같아서 이렇게 함께 매핑해놓음
	@GetMapping({"view" , "modify"})
	public void view(int frno, String mid ,Model model, @ModelAttribute("cri") Criteria cri) {		// 파라미터로 frno를 받아야함.
																			    // pageNum이랑 amount를 가지고 있는 cri를 view로 보내야하기 때문에
		// 현재 로그인한 아이디가 없거나									//  여기도 model에 담아서 frno란 이름으로 받는다.	
		// 작성자와 현재 로그인한 아이디와 일치하지 않는다면
		// 조회수를 올린다.
		
		// 현재 인증 객체를 가져옵니다.
		Authentication ac = SecurityContextHolder.getContext().getAuthentication();
		
		String id = ac.getName();
		if(id == null || !id.equals(mid)) {
			fs.updateHit(frno);
		}
		
		log.info("작성자는? " + mid);
		log.info("아이디는? " + ac.getName());
		log.info("view...... or modify");										// @ModelAttribute 를 사용해서 보낸다.
		model.addAttribute("fvo", fs.view(frno));
	    
	}
		
	
	// 전체 목록 가져오기 + 페이징
	@GetMapping("list")
	public void list(Model model, Criteria cri) {
		
		log.info("list......" + cri);
		model.addAttribute("list", fs.list(cri));
		
		
		
		model.addAttribute("pageDTO", new PageDTO(cri,fs.totalCount(cri)));
		
		// pageDTO 객체를 생성해서 cri로 전달한다.
		// model로 넘긴다.
	}
	
	
	
	// jsp 화면이 보이도록 getMapping(주소를 입력해서 들어오는것) 따로 이렇게 처리해야함.
	// void니까 jsp 파일 찾아서 /board/list로
	@GetMapping("register")
	@PreAuthorize("isAuthenticated()")   // 로그인이 되어있냐 안되어있냐 여부
	public void register() {
		log.info("register.....");  // 이건 확인용
		
	}
	
	
	@PostMapping("register")
	@PreAuthorize("isAuthenticated()")
	public String register(FreeVO fvo, RedirectAttributes rttr) {   // 스프링에서 돌려보내기 할때는 이걸쓴다.
		log.info("register....");									// 확인용
		
		if(fs.register(fvo)) {
			
			rttr.addFlashAttribute("result", "register success");    // 그럼 result 이름으로 보내진다. bno가
		}
	
		return "redirect:/free/list";
		
		// jsp 파일로 보내면 안되고 mapping 된 list로 보내야 한다. 리턴하고 다시 가는 곳이 같으면  void 사용
		// 그렇지 않을때는 String 으로 
	}
	
	@GetMapping(value = "attachList")
	public ResponseEntity <List<FreeAttachVO>> attachList (int frno){
	 log.info("attachList : " + frno);
	return new ResponseEntity<>(fs.attachList(frno), HttpStatus.OK);
	}
	
	// 내 게시글 목록 가져오기 + 페이징
	@GetMapping("mylist")
	public void mylist(String mid, Model model, Criteria cri) {
		
		log.info("mylist......" + mid + cri);
		model.addAttribute("mylist", fs.selectAllmy(mid,cri));  
			
		model.addAttribute("pageDTO", new PageDTO(cri,fs.mycount(mid,cri)));
		
		// pageDTO 객체를 생성해서 cri로 전달한다.
		// model로 넘긴다.
	}
	
	// 내 댓글 목록 가져오기 + 페이징
		@GetMapping("remylist")
		public void remylist(String mid, Model model, Criteria cri) {
			
			log.info("remylist......" + mid + cri);
			model.addAttribute("mylist", rs.mylist(mid,cri));  
				
			model.addAttribute("pageDTO", new PageDTO(cri,rs.totalmy(mid,cri)));
			
			// pageDTO 객체를 생성해서 cri로 전달한다.
			// model로 넘긴다.
		}
	
}

