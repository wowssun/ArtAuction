package org.artauc.service;

import org.artauc.domain.MemberVO;

public interface MainService {
	
	public boolean register(MemberVO mvo); //회원가입 insert
	public boolean idCheck(String mid); // 아이디 중복체크 select 
	public String midSearch(String name, String phone); //아이디찾기 select
	public boolean pwSearch(String mid, String name, String phone); //비밀번호찾기 select
	public boolean pwModify(MemberVO mvo); //비밀번호변경 update

}
