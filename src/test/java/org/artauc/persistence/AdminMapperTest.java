package org.artauc.persistence;


import org.artauc.domain.Criteria;
import org.artauc.mapper.AdminMapper;
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
public class AdminMapperTest {

	@Setter(onMethod_ = @Autowired )
	private AdminMapper adminMapper;
	
	@Test	
	public void searchTest() {
		Criteria cri = new Criteria();
		
		cri.setType("M");      
		cri.setKeyword("abc");
		
		adminMapper.selectAll(cri).forEach(mvo -> log.info(mvo));
		log.info("-----test-------------");
		adminMapper.okNoSelectAll(cri).forEach(rvo -> log.info(rvo));
		
		log.info("total count : " + adminMapper.mtotalCount(cri));
		
		cri.setType("N");		 
		cri.setKeyword("가나다");
		adminMapper.selectAll(cri).forEach(mvo -> log.info(mvo));
		
		log.info("total count : " + adminMapper.mtotalCount(cri));
		
	}
	
	
	public void selectAllTest( ) {
		Criteria cri = new Criteria();
	
		
		cri = new Criteria(3,1);
		
		adminMapper.selectAll(cri).forEach(mvo -> log.info(mvo));
		log.info("---------------------------");
		
		log.info("total count : " + adminMapper.mtotalCount(cri));
		
	}
	
	// 완
	public void lockSelectAllTest() {
		Criteria cri = new Criteria();
		
		cri = new Criteria(3,1);
		
		adminMapper.lockSelectAll(cri).forEach(mvo -> log.info(mvo));
		log.info("---------------------------");
		
		log.info("total count : " + adminMapper.mtotalCount(cri));
		
	}
	
	// 완
	public void lockUpdateTest() {
		log.info(adminMapper.lockUpdate("ghi"));
		
		
		
	}
	
	
	// 미완
	public void artSelcectAllTest() {
		Criteria cri = new Criteria();
		
		cri = new Criteria(3,1);
		
		adminMapper.artSelectAll(cri).forEach(avo -> log.info(avo));
		log.info("---------------------------");
		
		log.info("total count : " + adminMapper.atotalCount(cri));
		
	}
	
	// 완
	public void requeSelectAllTest() {
		Criteria cri = new Criteria();
		
		log.info("---------------------------");
		adminMapper.requeSelectAll(cri).forEach(rvo -> log.info(rvo));
		log.info("---------------------------");
		
		cri = new Criteria(3,1);
		
		adminMapper.requeSelectAll(cri).forEach(rvo -> log.info(rvo));
		log.info("---------------------------");
		
		log.info("total count : " + adminMapper.rtotalCount(cri));
		
	}
	
	// 작가 상세정보랑 같을듯? 일단 보류
	public void requeselectTest() {
		
	}
	
	// 완
	public void requeUpdateTest() {
		log.info(adminMapper.requeUpdate("ghi"));
		
	}
	
	// 완
	public void okNoselecAllTest() {
		Criteria cri = new Criteria();
		
		
		cri = new Criteria(3,1);
		
		adminMapper.okNoSelectAll(cri).forEach(rvo -> log.info(rvo));
		log.info("---------------------------");
		
		log.info("total count : " + adminMapper.oknototalCount(cri));
		
	}
	
	
	// 완
	public void deleteTest() {
		log.info("delete count : " + adminMapper.delete("AAA"));
	}
}
