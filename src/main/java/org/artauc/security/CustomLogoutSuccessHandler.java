package org.artauc.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLogoutSuccessHandler implements LogoutSuccessHandler {

	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication)
			throws IOException, ServletException {

		log.info("로그아웃 성공");
		/*
		 * RedirectAttributes attributes = new RedirectAttributesModelMap();
		 * attributes.addFlashAttribute("result", "logout success");
		 */

        
        
        response.sendRedirect("/artauction/main?result=logoutsuccess");
        
        
}
}