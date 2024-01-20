package org.artauc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.artauc.domain.ArtVO;
import org.artauc.domain.Criteria;
import org.artauc.domain.FCriteria;
import org.artauc.domain.FundPayVO;
import org.artauc.domain.FundVO;
;

public interface FundMapper {

	public int insert(FundVO fvo); //등록

	public FundVO select(int fno); //상세조회
	
	public List<FundVO> selectAllPaging(FCriteria cri); //전체목록
	
	public List<FundVO> selectMyFund(@Param("mid")String mid, @Param("cri") FCriteria cri); //나의펀딩목록(게시글)
	
	public List<FundPayVO> selectMyPay(@Param("mid")String mid, @Param("cri") Criteria cri); //나의펀딩내역(=결제내역)
	
	public int totalCount(FCriteria cri); //전체 게시글 수
	
	public int myFundCount(@Param("mid") String mid, @Param("cri") FCriteria cri); //나의 게시글 수
	
	public int myPayCount(@Param("mid") String mid, @Param("cri") Criteria cri); //나의 결제

	public int update(FundVO avo); //수정

	public int delete(int fno); //삭제
	
	public int insertPay(@Param("mid") String mid, @Param("fno") int fno, @Param("amount") int amount); //결제등록

	public int partcpntCntUpdate(int fno); //결제 성공 시 참가자 수 업데이트

}
