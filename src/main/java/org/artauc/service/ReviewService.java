package org.artauc.service;

import java.util.List;

import org.artauc.domain.ReviewVO;



public interface ReviewService {
	
	public List<ReviewVO> reviewClassList(int cno);
	public List<ReviewVO> reviewMyList(String mid);
	public ReviewVO view(int rno);
	public boolean rvRegi(ReviewVO rvo);
	public boolean rvModify(ReviewVO rvo); //리뷰 수정 
	public boolean rvRemove(int rno);
	

}
