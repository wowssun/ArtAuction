package org.artauc.persistence;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;

import org.artauc.domain.MemberVO;
import org.artauc.mapper.MainMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class MainMapperTest {

	@Setter(onMethod_ = @Autowired )
	private MainMapper mainMapper;	
	
	
	public void selectTest() {
		log.info("---------------------------");
		MemberVO mvo = mainMapper.select("abc");
		log.info(mvo);
		log.info(mvo.getAuth().getMid());
		
		
		log.info("---------------------------");
		 mvo = mainMapper.select("admin");
		log.info(mvo);
		log.info(mvo.getAuth().getAuth());
		
	}
	
	
	public void insertTest() {
		MemberVO mvo = new MemberVO();				
		//mid, name, pw, phone, email, join_date 
		mvo.setMid("new id");					
		mvo.setName("new name");				
		mvo.setPw("new pw");
		mvo.setPhone("new phone");
		mvo.setEmail("new email");
		mvo.setJoinDate(new Date());
		 
		mainMapper.insert(mvo);					
		 
		 log.info(mvo);		
		
	}
	
	public void authInsertTest() {
		
	}
	
	
	public void idCheckTest() {
		log.info("---------------------------");
		log.info(mainMapper.idCheck("abc"));									// 하나 가져오는건 매개변수 사용
		log.info("---------------------------");
		
	}
	
	@Test
	public void midSearchTest() {
		log.info("---------------------------");
			mainMapper.midSearch("라마바","010-1111-1111");									// 하나 가져오는건 매개변수 사용
		log.info("---------------------------");
		
	}
	
	
	public void pwSearchTest() {
		log.info("---------------------------");
			mainMapper.pwSearch("abc","가나다","010-0000-0000");									// 하나 가져오는건 매개변수 사용
		log.info("---------------------------");
		
	}
	
	
	public void pwUpdateTest() {
		MemberVO mvo = new MemberVO();					
		 
		 mvo.setPw("pw change");
		 mvo.setMid("new id");
		
		 log.info("update count : " +mainMapper.pwUpdate(mvo));  
		 														
		
	}
	
}
