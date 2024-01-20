package org.artauc.service;

import org.artauc.domain.AucVO;
import org.artauc.domain.ClassAttachVO;
import org.artauc.domain.ClassReqVO;
import org.artauc.domain.ClassVO;
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
public class ClassServiceTest {

	@Setter(onMethod_ = @Autowired)
	private ClassService cService;
	@Setter(onMethod_ = @Autowired)
	private ClassReqService crService;
	
//	@Test
	public void testlist() {
		log.info("----------------");
		cService.list().forEach(cvo -> log.info(cvo));
		log.info("----------------");
	}
	
//	@Test
	public void testmylist() {
		log.info("----------------");
		cService.myList("aaa").forEach(cvo -> log.info(cvo));
		log.info("----------------");
	}
	
//	@Test
	public void testview() {
		log.info("----------------");
		log.info(cService.view(96));
		log.info("----------------");
	}
	
//	@Test
	public void testregi() {
		ClassVO cvo = new ClassVO();
		cvo.setMid("bbb");
		cvo.setClassname("웅애애애애애ㅐ앵");
		cvo.setClassdate("2023/10/22");
		cvo.setClassinfo("이건 서!비스 테스트용");
		cvo.setClasstime("16:20");
		cvo.setPeoplenum(4);
		cvo.setRunningtime(20);
		cService.register(cvo);
		
		log.info("생성된 게시물 번호: " + cvo.getCno());
	}
	
//	@Test
	public void testremove() {
		log.info("Delete result: " + cService.remove(82));
	}
	
//	@Test
	public void testmodi() {
		ClassVO cvo = cService.view(44);
		cvo.setMid("abc");
		cvo.setClassname("테스트");
		cvo.setClassdate("2023/10/22");
		cvo.setClassinfo("이건 수정임 서비스 테스트용");
		cvo.setClasstime("16:41");
		cvo.setPeoplenum(4);
		cvo.setRunningtime(80);
		cvo.setClassimg("default.png");
		cService.modify(cvo);
		
		log.info("수정된 게시물 : " + cvo);
	}
	
//	@Test
	public void testreq() {
		ClassReqVO crvo = new ClassReqVO();
		ClassVO cvo = new ClassVO();
		
		crvo.setCno(47);
		crvo.setMid("def");
		cvo.setReqcnt(cvo.getReqcnt() + 1);
		
		crService.reqRegi(crvo);
		log.info(cvo.getReqcnt());
		log.info(crvo);
	}
	
//	@Test
	public void testreqlist() {
		log.info("----------------");
		crService.reqList(57).forEach(rvo -> log.info(rvo));
//		{
////			log.info("cvo뜸");
//			rvo.getMvo().forEach(mvo -> log.info(mvo));
//        });
		log.info("----------------");
	}
	
//	@Test
	public void testmyreqlist() {
		log.info("----------------");
		crService.reqMyList("aaa").forEach(rvo -> log.info(rvo));
//		{
//			log.info("cvo뜸");
//        	rvo.getCvo().forEach(Z -> log.info(reqvo));
//        });
		log.info("----------------");
	}
	
//	@Test
	public void testreqdelete() {
		ClassVO cvo = new ClassVO();
		cvo.setReqcnt(cvo.getReqcnt() + (-1));
		log.info("delete result:" +  crService.reqCancle(182));
	}
	
	
	@Test
	public void testreqme() {
		log.info(cService.reqMyId(15, "def"));
	}
	
	
	
	
	
	
	
	
	
	
}