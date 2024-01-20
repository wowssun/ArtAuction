package org.artauc.service;

import org.artauc.domain.Criteria;
import org.artauc.domain.RequestVO;
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
public class AdminServiceTest {
	
	@Setter(onMethod_ = @Autowired)
	private AdminService as;
	
	
	
	public void listTest( ) {
		Criteria cri = new Criteria();
	
		cri = new Criteria(3,1);
		
		as.list(cri).forEach(mvo -> log.info(mvo));
		log.info("---------------------------");
		
		log.info("total count : " + as.mtotalCount(cri));
		
	}
	
	
	public void lockListTest() {
		Criteria cri = new Criteria();
		
		cri = new Criteria(3,1);
		
		as.lockList(cri).forEach(mvo -> log.info(mvo));
		log.info("---------------------------");
		
		log.info("total count : " + as.mtotalCount(cri));
		
	}
	
	
	public void lockModifyTest() {
		
		log.info(as.lockModify("jkl"));
		
		
		
	}
	
	
	// 미완
	public void artListTest() {
		Criteria cri = new Criteria();
		cri = new Criteria(3,1);
		
		as.artList(cri).forEach(avo -> log.info(avo));
		log.info("---------------------------");
		
		log.info("total count : " + as.atotalCount(cri));
		
	}
	
	
	public void requeListTest() {
		Criteria cri = new Criteria();
		
		log.info("---------------------------");
		as.requeList(cri).forEach(rvo -> log.info(rvo));
		log.info("---------------------------");
		
		cri = new Criteria(3,1);
		
		as.requeList(cri).forEach(rvo -> log.info(rvo));
		log.info("---------------------------");
		
		log.info("total count : " + as.rtotalCount(cri));
		
	}
	
	// 보류 작가 상세정보랑 같을듯?
	public void requeselectTest() {
		
	}
	
	@Test
	public void stateModify() {
		
		RequestVO rvo = new RequestVO();
		rvo.setMid("AAA");
		rvo.setState("거절");
		
		log.info(as.stateModify(rvo));
		
	}
	
	// 미완
	public void okNoListTest() {
		Criteria cri = new Criteria();
		
		
		cri = new Criteria(3,1);
		
		as.okNoList(cri).forEach(rvo -> log.info(rvo));
		log.info("---------------------------");
		
		log.info("total count : " + as.rtotalCount(cri));
		
	}
	
	
	
	public void removeTest() {
		log.info("delete count : " + as.remove("abc"));
	}

}
