package org.artauc.domain;

import java.util.Date;

import lombok.Data;

@Data
public class FundPayVO {
	
	private int fpno;
	private String mid; //회원아이디(내펀딩내역때문)
	private int fno;
	//private String fundName;
	private int amount; //금액
	private Date payDate; //결제일
	private String impUid; // 아임포트 UID
	
	private FundVO fvo;

}
