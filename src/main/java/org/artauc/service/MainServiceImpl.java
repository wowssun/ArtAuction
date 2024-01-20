package org.artauc.service;

import org.artauc.domain.MemberVO;
import org.artauc.mapper.MainMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service     												// 서비스단은 서비스 어노테이션
@Log4j
public class MainServiceImpl implements MainService {
	
	@Setter(onMethod_ = @Autowired)
	private MainMapper mainMapper;

	@Override
	@Transactional 
	public boolean register(MemberVO mvo) {
		log.info("register...");
		
		if(mainMapper.insert(mvo)) {  // 회원가입시 
			mainMapper.authInsert(mvo.getMid());  //성공하면 권한도 insert
			return true;
		}
			
		return false;	
		
	}


	@Override
	public boolean idCheck(String mid) {
		
		log.info("idCheck...");
		
		return mainMapper.idCheck(mid)==1;
	}

	@Override
	public String midSearch(String name, String phone) {
		
		log.info("midSearch...");
		
		return mainMapper.midSearch(name, phone);
	}

	@Override
	public boolean pwSearch(String mid, String name, String phone) {
		
		log.info("pwSearch...");
		
		return mainMapper.pwSearch(mid, name, phone)==1;
	}

	@Override
	public boolean pwModify(MemberVO mvo) {
		
		log.info("pwModify...");
		
		return mainMapper.pwUpdate(mvo)==1;
	}
	
	
	
}
