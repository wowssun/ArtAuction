package org.artauc.domain;

import java.util.Date;

import lombok.Data;

@Data
public class RequestVO {
	
	private int requeNo;  // 신청번호
	private String mid; // 아이디
	private String state; // 신청상태
	private Date requestDate; // 신청일자
	private Date compleDate; // 처리일자
	
	private MemberVO mvo;   // mapper에서 조인해서 이름 가져와야함.

}
