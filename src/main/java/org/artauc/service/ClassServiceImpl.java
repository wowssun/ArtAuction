package org.artauc.service;

import java.util.List;

import org.artauc.domain.ClassAttachVO;
import org.artauc.domain.ClassReqVO;
import org.artauc.domain.ClassVO;
import org.artauc.mapper.ClassAttachMapper;
import org.artauc.mapper.ClassMapper;
import org.artauc.mapper.ClassReqMapper;
import org.artauc.mapper.ReviewMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ClassServiceImpl implements ClassService {

	@Setter(onMethod_ = @Autowired)
	private ReviewMapper rMapper;
	@Setter(onMethod_ = @Autowired)
	private ClassMapper cMapper;
	@Setter(onMethod_ = @Autowired)
	private ClassReqMapper crMapper;

	//클래스 전체 목록
	@Override
	public List<ClassVO> list() {
		log.info("classlist..........");
		return cMapper.selectAll();
	}
	
	//내 클래스 목록
	@Override
	public List<ClassVO> myList(String mid) {
		log.info("myclasslist...............");
		return cMapper.selectMyAll(mid);
	}
	
	//클래스 상세보기
	@Override
	public ClassVO view(int cno) {
		log.info("view........");
		return cMapper.select(cno);
	}
	
	//클래스 등록
	@Override
	@Transactional
	public boolean register(ClassVO cvo) {
		log.info("register......" + cvo);
		return cMapper.insert(cvo) == 1;
	}
	
	//클래스 삭제
	@Override
	public boolean remove(int cno) {
		log.info("remove...........");
		return cMapper.delete(cno) == 1;
	}
	
	//클래스 수정
	@Override
	@Transactional
	public boolean modify(ClassVO cvo) {
		log.info("modify..........." + cvo);
		return cMapper.update(cvo) == 1;
	}

	//본인 신청 여부 확인
	@Override
	public boolean reqMyId(int cno, String mid) {
		log.info(cMapper.selectReqMe(cno, mid));
		return cMapper.selectReqMe(cno, mid) == 1;
		
	}
	

	


}
