package org.artauc.domain;

import lombok.Data;

@Data
public class HongboVO {
	
	private String exhImg;
	private String field; //분야
	private String exhName; //전시회명
	private String exhDate; //전시기간
	private String exhTime; //전시시간
	//private String city; //지역
	private String place; //장소
	private String charge; //요금
	private String contact; //문의or번호
	private String homeurl; //해당 전시회 홈페이지
	private String exhIntro; //전시소개
	private String pSeq; //뷰페이지로 넘어갈때 필요
	private String pRo; //뷰페이지로 넘어갈때 필요


}
