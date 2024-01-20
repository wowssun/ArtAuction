package org.artauc.service;

import java.util.List;

import org.artauc.domain.Criteria;
import org.artauc.domain.ReplyPageDTO;
import org.artauc.domain.ReplyVO;

public interface ReplyService {
	
	
	// 전체 목록 페이징
	//public List<ReplyVO> list(int bno, Criteria cri);
	public ReplyPageDTO list(int frno, Criteria cri);

	// 내 목록 페이징
	public List<ReplyVO> mylist(String mid, Criteria cri);
	
	// rno로 하나 조회하기
	public ReplyVO view(int rpno);
	
	// insert  댓글 등록
	public boolean add(ReplyVO rvo);
	
	// 일단 여기는 boolean으로 해놓고 insertSelectKey 사용했는데
	// 다시 해봐야함.
	
	// delete
	public boolean remove(int rpno);
	
	// update
	public boolean modify(ReplyVO rvo);
	
	// 내 댓글 수
	public int totalmy(String mid,Criteria cri);
	
	
}
