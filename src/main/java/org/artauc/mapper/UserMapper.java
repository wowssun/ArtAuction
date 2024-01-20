package org.artauc.mapper;

import java.util.List;

import org.artauc.domain.ArtistVO;
import org.artauc.domain.CareerVO;
import org.artauc.domain.MemberVO;
import org.artauc.domain.RequestVO;

public interface UserMapper {
	
	public MemberVO select(String mid);  //내 정보 보기 select MemberVO
	public int update(MemberVO mvo);// 내 정보 수정 update
	public int delete(String mid); // 회원 탈퇴 delete
	public boolean insert(ArtistVO avo); //작가신청 작가정보 insert
	public boolean reqInsert(String mid); //작가신청 작가신청 insert
	public List<RequestVO> artSearch(String mid); // 작가 신청 정보 조회 select
	public ArtistVO artSelect(String mid); //작가 정보 보기 select
	public int artUpdate(ArtistVO avo); // 작가 정보 수정 update
	
	public boolean careerInsert(CareerVO cvo);  // 작가 경력 insert
	public int careerDelete(String mid);    	//	작가 경력 delete
	
	public List<CareerVO> careerSelect(String mid); // 작가 경력 정보
	
	// return 타입이 int인건 true면 1, false면 0
	// mapper에서 resultType, resultMap을 확인하고 
	// 여기서 반환타입이랑 맞아야 한다. resultType에 VO도 가능한데
	// 나는 여기서 VO랑 컬럼명이 다르기때문에 resultMap으로 처리함.

}
