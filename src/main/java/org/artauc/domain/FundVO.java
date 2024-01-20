package org.artauc.domain;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class FundVO {
	
	 private int fno; //펀딩번호
	 private String mid;
	 private String fundName; //펀딩명
	 private String pr; //소개
	 
	 private int targetPrice; //목표금액
	 private int totalPrice; //누적금액
	 private int partcpntCnt; //참가자 수
	 
	 @DateTimeFormat(pattern="yyyy-MM-dd")
	 private Date startDate; //시작일
	 
	 @DateTimeFormat(pattern="yyyy-MM-dd")
	 private Date endDate; //종료일
	 
	 private ArtistVO atvo;
	 private MemberVO mvo;
	 private ArtVO avo;
	 private CareerVO carvo;
	 
//	 private String mid; //아이디
//	 private String name; //작가명
//	 private String photo; //작가이미지

}
