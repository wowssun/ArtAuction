package org.artauc.persistence;


import java.util.Map;

import org.artauc.domain.ClassReqVO;
import org.artauc.domain.ClassVO;
import org.artauc.domain.MemberVO;
import org.artauc.mapper.ClassMapper;
import org.artauc.mapper.ClassReqMapper;
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
public class ClassMapperTest {
	@Setter(onMethod_ = @Autowired)
	private ClassMapper cmapper;
	@Setter(onMethod_ = @Autowired)
	private ClassReqMapper crmapper;
	
//	@Test
	public void testSelectAll() {
		log.info("--------------------");
		cmapper.selectAll().forEach(cvo -> log.info(cvo));
		log.info("--------------------");
	}
	
//	@Test
	public void testselectmyall() {
	log.info("--------------------");
	cmapper.selectMyAll("bbb").forEach(cvo -> log.info(cvo));
	log.info("--------------------");
	}
	
//	@Test
	public void testselect() {
		log.info("--------------------");
		cmapper.select(71);
		log.info(cmapper.select(71));
	}
	
//	@Test //cno가 출력이 안되는데 상관없으련가?
	public void testinsert() {
		ClassVO cvo = new ClassVO();
		
		cvo.setMid("aaa");
		cvo.setClassname("gdgd");
		cvo.setClassinfo("i'm not a");
		cvo.setClassdate("2023/10/21");
		cvo.setClasstime("16:30");
		cvo.setPeoplenum(5);
		cvo.setRunningtime(80);
		cmapper.insert(cvo);
		
		log.info("------------");
		log.info(cvo);
	}
	
//	@Test
	public void testdelete() {
		log.info("delete: " + cmapper.delete(77));
	}
	
//	@Test
	public void testupdate() {
		ClassVO cvo = new ClassVO();
		cvo.setCno(44);
		cvo.setClassname("안녕하냐");
		cvo.setClassinfo("i'm aaa?");
		cvo.setClassdate("2023/10/21");
		cvo.setClasstime("22:30");
		cvo.setPeoplenum(5);
		cvo.setRunningtime(80);
		cvo.setClassimg("default.png");
		
		log.info("update count: " + cmapper.update(cvo));
	}
	
//	@Test
	public void testinsertreq() {
		ClassReqVO reqvo = new ClassReqVO();
		reqvo.setCno(41);
		reqvo.setMid("aaa");
		
	    crmapper.insertReq(reqvo);
	    log.info(reqvo);
	}
	
//	@Test
	public void testselectreq() {
		log.info("-------클래스 신청자------");
		crmapper.selectReq(21).forEach(rvo -> {
		    log.info(rvo);
//		    rvo.getMvoList().forEach(mvo -> log.info(mvo));
		    
		});
		log.info("--------------------");
	}
	
//	@Test
	public void testselectmyreq() {
		log.info("-----내 클래스 목록-----");
		crmapper.selectMyReq("def").forEach(rvo -> {
		    log.info(rvo);
//	        rvo.getCvoList().forEach(cvo -> log.info(cvo));
		    
		});
		log.info("--------------------");
	}
	
//	@Test
	public void testdeletreq() {
		log.info("delete: " + crmapper.deleteReq(6));
		
	}
	
//	@Test
	public void testattachList() {
		
	}
	
	@Test
	public void testselectreqme() {
	    log.info(cmapper.selectReqMe(15, "def"));
	}
	
	
	
}
