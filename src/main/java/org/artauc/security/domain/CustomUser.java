package org.artauc.security.domain;

import java.util.Collection;
import java.util.Collections;


import org.artauc.domain.MemberVO;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import lombok.Getter;

@Getter
public class CustomUser extends User {
	
	private MemberVO mvo;
	
	// 멤버vo로 받은걸 super로 보낸다.
	// 싱글톤 컬렉션 - singletonXXX() 단 한개의 객체만 저장 가능한 컬렉션을 만들고 싶을 때 사용한다.
	public CustomUser(MemberVO mvo) {
		super(mvo.getMid(), mvo.getPw(),
				Collections.singleton(new SimpleGrantedAuthority(mvo.getAuth().getAuth())));
		this.mvo = mvo;
	}
	
	
	public CustomUser(String username, String password, boolean enabled, boolean accountNonExpired,
			boolean credentialsNonExpired, boolean accountNonLocked,
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
		// TODO Auto-generated constructor stub
	}

	
}
