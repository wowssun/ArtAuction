package org.artauc.service;

import java.util.List;

import org.artauc.domain.ArtistVO;
import org.artauc.domain.CareerVO;
import org.artauc.domain.MemberVO;
import org.artauc.domain.RequestVO;

public interface UserService {

	
	public MemberVO view(String mid); //내 정보 보기 select MemberVO
	public boolean modify(MemberVO mvo); // 내 정보 수정 update
	public boolean remove(String mid) ;// 회원 탈퇴 delete
	public boolean register(ArtistVO avo); //작가신청 작가정보 insert
	public List<RequestVO> artSearch(String mid); // 작가 신청 정보 조회 select
	public ArtistVO artView(String mid); //작가 정보 보기 select
	public boolean artModify(ArtistVO avo); // 작가 정보 수정 update

	public List<CareerVO> careerView(String mid); // 작가 경력 정보

	
	
	//public boolean careerRegister(CareerVO cvo);  // 작가 경력 insert
}
