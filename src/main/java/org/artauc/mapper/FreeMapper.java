package org.artauc.mapper;

import java.util.List;

import org.artauc.domain.FreeVO;
import org.artauc.domain.Criteria;
import org.apache.ibatis.annotations.Param;

public interface FreeMapper {

	
	public List<FreeVO> selectAllPaging(Criteria cri); // 전체 목록 페이징
	public FreeVO select(int frno); // bno로 상세조회
	public boolean insert(FreeVO fvo); // insert
	public boolean delete(int frno); // delete
	public boolean update(FreeVO fvo); // update
	public int totalCount(Criteria cri);// 전체 게시물 수
	public int mycount(@Param("mid")String mid,@Param("cri")Criteria cri); // 내 게시물 수
	public int updateHit(int frno); // 게시물 조회수 증가
	public List<FreeVO> selectAllmy(@Param("mid")String mid,@Param("cri")Criteria cri); // 내 전체 게시물 목록
	// 내 게시글 목록으로 가져올 것 totalCount 해야함.
	
	// 시퀀스 하나 미리 저장해놓고 1부터 생성하게 ,insert  여기서 boolean으로 true,false로 해도 되고 
	public int insertSelectKey(FreeVO fvo);
	
	// 댓글 수 업데이트
	public int updateReplyCnt(@Param("amount") int amount, @Param("frno") int frno);
}
