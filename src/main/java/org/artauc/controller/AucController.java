package org.artauc.controller;

import org.artauc.domain.ArtVO;
import org.artauc.domain.AucCriteria;
import org.artauc.domain.AucPageDTO;
import org.artauc.domain.AucVO;
import org.artauc.service.AucService;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/auction/*")
@AllArgsConstructor
public class AucController {
	private AucService aucService;

	@GetMapping("auclist")
	public void list(Model model, AucCriteria cri) {
		log.info("list......" + cri);
		model.addAttribute("list", aucService.selectAllPaging(cri));
		int totalCount = aucService.totalCount(cri);
		model.addAttribute("pageDTO", new AucPageDTO(cri, totalCount));
	}

	@PreAuthorize("hasRole('USER') or hasRole('ARTIST')")
	@GetMapping("myauclist")
	public void mylist(Model model, AucCriteria cri, @RequestParam(value = "mid") String mid) {
		log.info("list......" + cri);
		log.info(mid);
		model.addAttribute("auclist", aucService.mylist(cri, mid));
		int totalCount = aucService.myAucCount(cri, mid);
		model.addAttribute("pageDTO", new AucPageDTO(cri, totalCount));
	}
	
	@GetMapping("sbidlist")
	public void sbidlist(Model model, AucCriteria cri, String buyer) {
		log.info("list......" + cri);
		model.addAttribute("sbidlist", aucService.sbidlist(cri, buyer));
		int totalCount = aucService.sbidCount(cri, buyer);
		model.addAttribute("pageDTO", new AucPageDTO(cri, totalCount));
	}
	
	@PreAuthorize("hasRole('ARTIST')")
	@GetMapping("register")
	public void register(Model model, RedirectAttributes rttr, String mid) {
		log.info(aucService.selectart(mid));
		model.addAttribute("artList", aucService.selectart(mid));
	}

	@GetMapping(value = "{artName}/{mid}")
	public ResponseEntity<ArtVO> view(@PathVariable("artName") String artName, @PathVariable("mid") String mid) {
		log.info(aucService.selectArtdetail(artName, mid));

		return new ResponseEntity<ArtVO>(aucService.selectArtdetail(artName, mid), HttpStatus.OK);
	}
	
	@PreAuthorize("hasRole('ARTIST')")
	@PostMapping("register")
	public String register(AucVO avo, RedirectAttributes rttr) {
		if (aucService.insertSelectKey(avo)) {
			rttr.addFlashAttribute("result", avo.getAno());
		}
		return "redirect:/auction/auclist";
	}
	
	@PreAuthorize("hasRole('ADMIN') or hasRole('ARTIST')")
	@PostMapping("remove")
	public String remove(int ano, RedirectAttributes rttr, @ModelAttribute("cri") AucCriteria cri) {
		if (aucService.delete(ano)) {
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/auction/auclist";
	}

	@PreAuthorize("hasRole('ADMIN') or hasRole('ARTIST')")
	@PostMapping("modify")
	public String modify(AucVO avo, RedirectAttributes rttr, @ModelAttribute("cri") AucCriteria cri) {
		log.info(avo);
		if (aucService.update(avo)) {
			rttr.addFlashAttribute("result", "success");
		}
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		return "redirect:/auction/auclist";
	}

	@GetMapping({ "view", "modify" })
	public void view(int ano, Model model, @ModelAttribute("cri") AucCriteria cri) {
		log.info(ano);
		model.addAttribute("avo", aucService.select(ano));
	}
	
	@PreAuthorize("hasRole('USER') or hasRole('ARTIST')")
	@GetMapping("sbidview")
	public void sbidview(int ano, Model model, @ModelAttribute("cri") AucCriteria cri) {
		log.info(ano);
		model.addAttribute("avo", aucService.select(ano));
	}

	@PreAuthorize("hasRole('USER') or hasRole('ARTIST')")
	@RequestMapping(value = "/updateBid", method = { RequestMethod.POST })
	public ResponseEntity<String> updateBid(@RequestParam(value="ano") int ano, 
											@RequestParam(value="buyer") String buyer,
											@RequestParam(value="priceC") int priceC){
		System.out.println(ano);
		System.out.println(buyer);
		System.out.println(priceC);		
		
		return aucService.updateBid(ano, buyer, priceC) 
				   ? new ResponseEntity<>("success", HttpStatus.OK)
				   : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
