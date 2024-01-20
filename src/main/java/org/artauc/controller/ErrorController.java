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
@Log4j
public class ErrorController {
	
		 
		 @GetMapping("/accessDenied")
			public String denied(Model model) {
				
				log.info("-------------accessDenied----------------");
				
				// model에 담아서 jsp 페이지로 보내기
				model.addAttribute("msg", "접근 불가 - 권한 부족");
				
				return "/error/accessDenied";
			}
		 
		
	
}
