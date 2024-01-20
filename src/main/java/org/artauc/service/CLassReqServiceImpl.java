package org.artauc.service;

import java.util.List;

import org.artauc.domain.ClassReqVO;
import org.artauc.mapper.ClassMapper;
import org.artauc.mapper.ClassReqMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class CLassReqServiceImpl implements ClassReqService {
	
	@Setter(onMethod_ = @Autowired)
	private ClassReqMapper crMapper;
	@Setter(onMethod_ = @Autowired)
	private ClassMapper cMapper;
	
	@Override
	public List<ClassReqVO> reqList(int cno) {
		log.info("reqList............");
		return crMapper.selectReq(cno);
	}

	@Override
	public List<ClassReqVO> reqMyList(String mid) {
		log.info("reqMyList............");
		return crMapper.selectMyReq(mid);
	}

	@Override
	public boolean reqRegi(ClassReqVO reqvo) {
		log.info("reqRegi................");

		cMapper.updateReqCnt(1, reqvo.getCno()); //신청자 수 cntUpdate +1
		return crMapper.insertReq(reqvo) == 1;
	}

	@Override
	public boolean reqCancle(int reqno) {
		log.info("CancleReq............");
		
		//클래스 인원수 삭제
		ClassReqVO crvo = crMapper.select(reqno);
		cMapper.updateReqCnt(-1, crvo.getCno()); //신청자 수 cntUpdate-1
		
		return crMapper.deleteReq(reqno) == 1;
	}


	
	
	
	
	
	
	
	
	
	
	
	
	
}
