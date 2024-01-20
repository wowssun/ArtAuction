package org.artauc.service;

import java.util.List;

import org.artauc.domain.ArtistVO;
import org.artauc.domain.CareerVO;
import org.artauc.domain.MemberVO;
import org.artauc.domain.RequestVO;
import org.artauc.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service     												// 서비스단은 서비스 어노테이션
@Log4j
public class UserServiceImpl implements UserService {
	
	@Setter(onMethod_ = @Autowired)
	private UserMapper userMapper;

	@Override
	public MemberVO view(String mid) {
		
		log.info("view...");
		
		return userMapper.select(mid);
	}

	@Override
	public boolean modify(MemberVO mvo) {
		
		log.info("modify...");
		
		return userMapper.update(mvo)==1;
	}

	@Override
	public boolean remove(String mid) {
		
		log.info("remove...");
		
		return userMapper.delete(mid)==1;
	}

	@Override
	@Transactional 
	public boolean register(ArtistVO avo) {
		
		log.info("register..." + avo);
		
		boolean result = false;
		
		if(userMapper.insert(avo)) {
			userMapper.reqInsert(avo.getMid());
			 result =  true;		
	}				
	
	 if(avo.getCareerlist() != null && avo.getCareerlist().size() > 0) { 			// 만약avo의 getCareerlist가 있다면 
	  avo.getCareerlist().forEach( cvo -> { 				// for문 돌면서 Careerlist에 mid를 꺼내서 
	  cvo.setMid(avo.getMid()); userMapper.careerInsert(cvo);
	  });
	  
	 } 	//이건 그냥 경력에 들어가면 되는거고
			
		return result;
	
	}

	@Override
	public List<RequestVO> artSearch(String mid) {
		
		log.info("artSearch...");
		
		return userMapper.artSearch(mid);
	}

	@Override
	public ArtistVO artView(String mid) {
		
		log.info("artView...");
		
		return userMapper.artSelect(mid);
	}

	@Override
	@Transactional 
	public boolean artModify(ArtistVO avo) {
		
		log.info("artModify...");
		
		userMapper.careerDelete(avo.getMid());  // 먼저 작가 경력 모두 삭제하고
		
		boolean result = userMapper.artUpdate(avo)==1;
					
	
	 if(avo.getCareerlist() != null && avo.getCareerlist().size() > 0) { 			// 만약avo의 getCareerlist가 있다면 
	  avo.getCareerlist().forEach( cvo -> { 				// for문 돌면서 Careerlist에 mid를 꺼내서 
	  cvo.setMid(avo.getMid()); userMapper.careerInsert(cvo);
	  });
	  
	 } 	//이건 그냥 경력에 들어가면 되는거고
			
		return result;
			
	}

	@Override
	public List<CareerVO> careerView(String mid) {
		log.info("careerView...");
		
		return userMapper.careerSelect(mid);
	}

	
	

	
	



}
