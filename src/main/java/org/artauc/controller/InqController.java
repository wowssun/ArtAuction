package org.artauc.controller;

import org.artauc.domain.Criteria;
import org.artauc.domain.InqVO;
import org.artauc.domain.PageDTO;
import org.artauc.service.InqService;
import org.springframework.security.access.prepost.PreAuthorize;
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
@RequestMapping("/inquiry/*")
@AllArgsConstructor
public class InqController {
	private InqService inqService;

	@PreAuthorize("hasRole('ADMIN')")
	@GetMapping("inqlist")
	public void list(Model model, Criteria cri) {
		log.info("list......" + cri);
		model.addAttribute("list", inqService.selectAllPaging(cri));
		int totalCount = inqService.totalCount(cri);
		model.addAttribute("pageDTO", new PageDTO(cri, totalCount));
	}

	@PreAuthorize("hasRole('USER') or hasRole('ARTIST')")
	@GetMapping("mylist")
	public void mylist(Model model, Criteria cri, @RequestParam(value = "mid") String mid) {
		log.info("list......" + cri);
		model.addAttribute("mylist", inqService.mylist(cri, mid));
		int totalCount = inqService.myCount(cri, mid);
		model.addAttribute("pageDTO", new PageDTO(cri, totalCount));
	}

	@PreAuthorize("hasRole('ADMIN')")
	@GetMapping("answerlist")
	public void answerlist(Model model, Criteria cri) {
		log.info("list......" + cri);
		model.addAttribute("answerlist", inqService.answerlist(cri));
		int totalCount = inqService.ansCount(cri);
		model.addAttribute("pageDTO", new PageDTO(cri, totalCount));
	}

	@PreAuthorize("hasRole('USER') or hasRole('ARTIST')")
	@GetMapping("register")
	public void register() {
	}

	@PreAuthorize("hasRole('USER') or hasRole('ARTIST')")
	@PostMapping("register")
	public String register(InqVO ivo, RedirectAttributes rttr) {
		if (inqService.insertSelectKey(ivo)) {
			rttr.addFlashAttribute("result", ivo.getRno());
		}
		return "redirect:/inquiry/mylist?mid="+ivo.getMid();
	}

	@GetMapping({ "view", "modify" })
	public void view(int rno, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info(rno);
		model.addAttribute("ivo", inqService.select(rno));
	}

	@PreAuthorize("hasRole('USER') or hasRole('ARTIST')" )
	@PostMapping("modify")
	public String modify(InqVO ivo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info(ivo);
		if (inqService.update(ivo)) {
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/inquiry/mylist?mid="+ivo.getMid();
	}
	
	@PreAuthorize("hasRole('ADMIN')" )
	@PostMapping("modifyAdmin")
	public String modifyAdmin(InqVO ivo, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		log.info(ivo);
		if (inqService.updateAdmin(ivo)) {
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/inquiry/answerlist";
	}

	@PreAuthorize("hasRole('USER') or hasRole('ARTIST') or hasRole('ADMIN')" )
	@PostMapping("remove")
	public String remove(int rno, RedirectAttributes rttr, @ModelAttribute("cri") Criteria cri) {
		if (inqService.delete(rno)) {
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/inquiry/inqlist";
	}

}
