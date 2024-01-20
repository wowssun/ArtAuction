package org.artauc.service;

import java.util.List;

import org.artauc.domain.ReviewVO;
import org.artauc.mapper.ReviewMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReviewServiceImpl implements ReviewService {
	
	@Setter(onMethod_ = @Autowired)
	private ReviewMapper rMapper;
	
	//클래스 리뷰 목록
	@Override
	public List<ReviewVO> reviewClassList(int cno) {
		log.info("reviewList...........");
		return rMapper.selectAll(cno);
	}
	
	//내 리뷰 목록
	@Override
	public List<ReviewVO> reviewMyList(String mid) {
		log.info("reviewMyList..........");
		return rMapper.selectMyAll(mid);
	}
	
	//리뷰 상세보기
	@Override
	public ReviewVO view(int rno) {
		log.info("view........");
		return rMapper.select(rno);
	}
	
	//리뷰 등록
	@Override
	public boolean rvRegi(ReviewVO rvo) {
		log.info("reviewRegi........." + rvo);
		boolean result = rMapper.insert(rvo) == 1;
		return result;
	}
	
	//리뷰 수정
	@Override
	public boolean rvModify(ReviewVO rvo) {
		log.info("reviewModi........." + rvo);
		boolean result = rMapper.update(rvo) == 1;
		return result;
	}
	
	//리뷰 삭제
	@Override
	public boolean rvRemove(int rno) {
		log.info("remove........");
		return rMapper.delete(rno) == 1;
		
	}

	


}
