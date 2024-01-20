                                                                                                        package org.artauc.security;

import org.artauc.domain.MemberVO;
import org.artauc.mapper.MainMapper;
import org.artauc.security.domain.CustomUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {
	
	@Setter(onMethod_ = @Autowired )
	private MainMapper memMapper;

	// 사용자가 입력한 아이디가 username으로 들어온다.
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		log.warn("loadUserByUsername() : " + username);
		
		MemberVO mvo = memMapper.select(username);
		
		return mvo == null ? null : new CustomUser(mvo);
	}

}
