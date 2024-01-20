package org.artauc.controller;





import org.artauc.service.PayService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/auction/*")
@AllArgsConstructor
public class PayController {
	private PayService payService;
	
	@PreAuthorize("hasRole('USER') or hasRole('ARTIST')" )
	@RequestMapping(value = "pay", method = { RequestMethod.POST })
	public ResponseEntity<String> pay(@RequestParam(value="ano") int ano, 
											@RequestParam(value="price") int price){
		
		return payService.insert(ano, price) 
				   ? new ResponseEntity<>("success", HttpStatus.OK)
				   : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
