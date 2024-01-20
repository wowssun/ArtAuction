package org.artauc.service;

import java.util.List;

import org.artauc.domain.FreeVO;
import org.artauc.domain.FreeAttachVO;
import org.apache.ibatis.annotations.Param;
import org.artauc.domain.Criteria;

public interface FreeService {

	// service단은 사용자쪽에 더 가까워서 메서드 이름을 이렇게 변경해준다.
	
		
		// bno로 하나 가져오기
		public FreeVO view(int frno);
		
		// insert  여기서 boolean으로 true,false로 해도 되고 
		public boolean register(FreeVO fvo);
		
		// 시퀀스 하나 미리 저장해놓고 ,insert  여기서 boolean으로 true,false로 해도 되고 
		public int insertSelectKey(FreeVO fvo);
		
		// delete
		public boolean remove(int frno);
		
		// update
		public boolean modify(FreeVO fvo);
		
		// 첨부파일 전체 가져오기
		public List<FreeAttachVO> attachList(int frno);
		
		// 게시물 조회수 증가
		public boolean updateHit(int frno); // 게시물 조회수 증가
		
		// 댓글 수 업데이트
		// public boolean replyCntmodify(int amount, int bno);
		
		
		// 내 게시물 목록
		public List<FreeVO> selectAllmy(String mid,Criteria cri); // 내 전체 게시물 목록
		
		// 전체 게시물 수
		public int totalCount(Criteria cri);
		
		// 내 게시물 수
		public int mycount(String mid,Criteria cri);
		
		// 전체 목록 페이징
		public List<FreeVO> list(Criteria cri);
}
