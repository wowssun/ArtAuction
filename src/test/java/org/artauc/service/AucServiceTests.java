package org.artauc.service;


import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class AucServiceTests {
	@Setter(onMethod_ = @Autowired)
	private AucService aucService;
	
	@Test
	public void testselectAll() {
		log.info(aucService.select(1));
	}
	
	public void testartSelect() {
		log.info(aucService.selectart("abc"));
	}
	
	public void testSelect() {
		log.info(aucService.select(1));
	}

}
