package org.artauc.controller;

import org.artauc.domain.Criteria;
import org.artauc.domain.PageDTO;
import org.artauc.service.BidService;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/auction/*")
@AllArgsConstructor
public class BidController {
	private BidService bidService;
	
	@PreAuthorize("hasRole('USER') or hasRole('ARTIST')")
	@GetMapping("bidlist")
	public void mybidlist(Model model, Criteria cri, String mid) {
		log.info("list......" + cri);
		model.addAttribute("bidlist", bidService.bidlist(cri, mid));
		int totalCount = bidService.bidCount(cri, mid);
		model.addAttribute("pageDTO", new PageDTO(cri, totalCount));
	}
}
