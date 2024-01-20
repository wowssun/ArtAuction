package org.artauc.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.artauc.domain.ArtVO;
import org.artauc.domain.ClassAttachVO;
import org.artauc.domain.ClassReqVO;
import org.artauc.domain.ClassVO;
import org.artauc.service.ClassReqService;
import org.artauc.service.ClassService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/class/*")
public class ClassController {

	@Setter(onMethod_ = @Autowired)
	private ClassService cService;

	@Setter(onMethod_ = @Autowired)
	private ClassReqService crService;

	// 클래스 전체 목록
	@GetMapping("classList")
	public void list(Model model) {// model은 값을 불러올때 사용
		log.info("classlist.......");
		model.addAttribute("list", cService.list());
//		cService.reqMyId(0, null);

	}

	// 내 클래스 목록
	@GetMapping("myClassList")
	public void myList(Model model, String mid) {
		log.info("classlist.......");
		model.addAttribute("list", cService.myList(mid));
	}

	// 클래스 상세보기
	@GetMapping("classInfo")
	public void view(Model model, int cno) {
		log.info("view..........");//
		log.info(cService.view(cno));
		
		model.addAttribute("view", cService.view(cno));
	}
	
	//아이디 신청 확인
	@GetMapping(value="reqChk/{cno}/{mid}")
	public ResponseEntity<String> reqMyId(@PathVariable("cno") int cno, 
										  @PathVariable("mid") String mid){
		log.info("아이디 확인.............");
		log.info(mid);
		return cService.reqMyId(cno, mid) //success들어가면 return값이 String이 되어야함
				? new ResponseEntity<>("1", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// 클래스 등록
	@GetMapping("classRegi")
//	@PreAuthorize("isAuthenticated()") // 추후 작가로 수정
	@PreAuthorize("hasRole('ARTIST')")
	public void register() {
		log.info("register....");
	}

	@PostMapping("classRegi") // 리다이렉트 후에 문구 불러오거나 할때
//	@PreAuthorize("isAuthenticated()")
	@PreAuthorize("hasRole('ARTIST')")
	public String register(ClassVO cvo, RedirectAttributes rttr) {
		log.info("register.........." + cvo);
		if (cService.register(cvo)) {
			rttr.addFlashAttribute("result", cvo.getCno());
		}
		return "redirect:/class/classList";

	}

	// 첨부파일 삭제
	public void deleteFiles(ClassVO cvo) {
		log.info("deletetFiles....");
		if (cvo == null || cvo.getClassimg() == null) {
			return;
		}
		try {
			Path file = Paths.get("c:\\upload\\" + cvo.getClassimg());

			Files.deleteIfExists(file); // delete original img

			if (Files.probeContentType(file).startsWith("image")) {
				Path thumbnail = Paths.get("c:\\upload\\s_" + cvo.getClassimg());
				Files.deleteIfExists(thumbnail); // delete thumbnail img
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 클래스 삭제
	@PostMapping("classRem")
	@PreAuthorize("hasRole('ADMIN') or hasRole('ARTIST')")
	public String remove(String mid, int cno, RedirectAttributes rttr) {
		log.info("remove...." + cno);

		ClassVO cvo = cService.view(cno);

		if (cService.remove(cno)) {
			deleteFiles(cvo);
			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/class/classList";

	}

	// 클래스 수정
	@GetMapping("classMod")
	public void modify(Model model, int cno) {
		log.info("modify.........controller");
		model.addAttribute("view", cService.view(cno));
	}

	@PostMapping("classMod")
//	@PreAuthorize("principal.username == #cvo.mid")
	public String modify(ClassVO cvo, RedirectAttributes rttr) {
		log.info("update.........");
		log.info("수정 컨트롤러 넘어와써?" + cvo);
		if (cService.modify(cvo)) {
			rttr.addFlashAttribute("result", "success");
		}

		return "redirect:/class/classInfo?cno=" + cvo.getCno();

	}

	// 신청 등록
	@PostMapping("classReq")
	@PreAuthorize("isAuthenticated()")
	public String reqRegist(ClassReqVO reqvo, RedirectAttributes rttr) {
		log.info("classRequest........");
		log.info("신청 컨트롤러 번호" + reqvo.getCno() + "|");
		if (crService.reqRegi(reqvo)) {
			rttr.addFlashAttribute("result", reqvo.getReqno());

		}
		return "redirect:/class/classInfo?cno=" + reqvo.getCno();

	}

	// 신청자 목록
	@GetMapping("classReqList")
	@PreAuthorize("hasRole('ADMIN') or hasRole('ARTIST')")
	public void reqList(Model model, int cno) { // cno가 붙어야하나?, 마이페이지 신청 목록도 만드나?
		log.info("Requestlist.........");
		model.addAttribute("reqList", crService.reqList(cno));

	}

	// 내 신청 목록
	@GetMapping("classMyReq") // 이건가
//	@PreAuthorize("principal.username == #<sec:authentication property='principal.mvo.mid'/>")
	public void reqMyList(Model model, String mid) {
		log.info("myRequestList..........");
		model.addAttribute("myReqList", crService.reqMyList(mid));

	}

	// 신청 취소 (내 클래스 신청)
	@GetMapping("classReqRem")
//	@PreAuthorize("isAuthenticated()")
//	@PreAuthorize("principal.username == #<sec:authentication property='principal.mvo.mid'/>") //?
	public String reqCancle(ClassReqVO reqvo, RedirectAttributes rttr) {
		// log.info("requestRemove...........");
		// log.info( "신청 컨트롤러 번호"+ reqvo.getReqno() +"|");
		if (crService.reqCancle(reqvo.getReqno())) {
			rttr.addFlashAttribute("result", "success");
		}
//		return "redirect:/class/classReqList?mid=" + reqvo.getMid() + "&cno=" + reqvo.getCno();
		return "redirect:/class/classMyReq?mid=" + reqvo.getMid();
	}

	// 사진만 가져오기
	@GetMapping(value = "getArtImg")
	public ResponseEntity<ClassVO> getClassImg(int cno) {
		log.info("classImg controller.........");

		return new ResponseEntity<>(cService.view(cno), HttpStatus.OK);
	}

	// 클래스 신청자 수

	// 클래스 내 신청 확인

//	// 업로드 목록
//	@GetMapping("attachList")
//	public ResponseEntity<List<ClassAttachVO>> attachList(int cno) {
//		log.info("getattachList.....");
//		return new ResponseEntity<List<ClassAttachVO>>(cService.attachList(cno), HttpStatus.OK);
//	}

}
