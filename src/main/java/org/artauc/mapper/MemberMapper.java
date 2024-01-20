package org.artauc.mapper;



import org.artauc.domain.MemberVO;

public interface MemberMapper {

	// mapper와 type 맞춰서
	public MemberVO select(String mid);
}
