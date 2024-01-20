package org.artauc.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	
	private String mid; 				// 아이디
	private String pw; 					// 비밀번호
	private String name; 				// 이름
	private String phone; 				// 전화번호
	private String email; 				// 이메일
	private Date joinDate; 				// 가입일자
	private Date stopDate; 				// 계정중지 일시 
	private boolean enabled;   			// 계정 활성화 / 비활성화 

	private AuthVO auth; 				// 권한 : 권한 하나만 가져올거라서 vo로 처리 / 회원, 작가, 관리자, 잠금 → 잠금해제되면 무조건 회원
}
