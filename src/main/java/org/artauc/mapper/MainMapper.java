package org.artauc.mapper;

import org.apache.ibatis.annotations.Param;
import org.artauc.domain.MemberVO;

public interface MainMapper {
	
	public boolean insert(MemberVO mvo) ;//회원가입 insert
	public boolean authInsert(String mid) ;//회원가입 권한 insert
	public int idCheck(String mid); // 아이디 중복체크  얘는 카운트로 있다 없다?
	public String midSearch(@Param("name")String name,@Param("phone") String phone); //아이디찾기 select
	public int pwSearch(@Param("mid")String mid,@Param("name") String name,@Param("phone") String phone); //비밀번호찾기 select
	public int pwUpdate(MemberVO mvo) ;//비밀번호변경 update
	
	// 파라미터 두개이상 보내면 param 붙여서 보내야함.
	// 파람은 myBatis에서만 사용 service에서는 사용하지 않는다.
	
	// mapper와 type 맞춰서   로그인
	public MemberVO select(String mid);

}
