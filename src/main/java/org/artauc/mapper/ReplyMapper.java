package org.artauc.mapper;

import java.util.List;

import org.artauc.domain.Criteria;
import org.artauc.domain.ReplyVO;
import org.apache.ibatis.annotations.Param;

public interface ReplyMapper {
	
	public List<ReplyVO> reSelectAllPaging(@Param("frno") int frno,@Param("cri") Criteria cri); // 전체 목록 페이징
	public int reInsert(ReplyVO rvo);// insert
	public ReplyVO reSelect(int rpno); // rno로 하나 가져오기
	public int reDelete(int rpno) ;// delete
	public int reUpdate(ReplyVO rvo); // update
	public int reDeleteAll(int frno); // 댓글 전체 삭제
	
	// 댓글 수
	public int selectReply(int frno);
	
	// 내 댓글 수
	public int totalmy(@Param("mid")String mid, @Param("cri") Criteria cri);
	
	// 내 댓글 전체 목록
	public List<ReplyVO> reSelectAllmy(@Param("mid")String mid, @Param("cri") Criteria cri); 

}
