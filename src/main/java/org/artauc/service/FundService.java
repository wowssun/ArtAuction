package org.artauc.service;

import java.util.List;
import java.util.Map;

import org.artauc.domain.Criteria;
import org.artauc.domain.FCriteria;
import org.artauc.domain.FundPayVO;
import org.artauc.domain.FundVO;


public interface FundService {

	public boolean register(FundVO fvo); //등록

	public FundVO view(int fno); //상세조회
	
	public List<FundVO> list(FCriteria cri); //최신순전체목록
	
	public List<FundVO> myfundList(String mid, FCriteria cri); //나의펀딩목록(게시글)
	
	public List<FundPayVO> mypayList(String mid, Criteria cri); //나의펀딩내역(=결제내역)

	public int totalCount(FCriteria cri); //전체목록 수
	
	public int myFundCount(String mid, FCriteria cri); //나의 게시글 수
	
	public int myPayCount(String mid, Criteria cri);

	public boolean modify(FundVO fvo); //수정

	public boolean remove(int fno); //삭제
	
	public boolean payRegister(String mid, int fno, int amount); //결제등록
	
	public boolean partcpntCntUpdate(int fno); //결제 성공 시 참가자 수 업데이트
	


}
