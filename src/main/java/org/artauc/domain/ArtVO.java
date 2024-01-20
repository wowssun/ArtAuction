package org.artauc.domain;

import lombok.Data;

@Data
public class ArtVO {
	
	private int ano; //작품번호
	private String mid; //아이디
	private String artist;//작가이름
	private String artName; //작품명
	private String genre; //기법
	private String asize; //작품크기
	private String intro; // 작품소개
	private String artImg; //작품이미지
//	private String uuid; // UUID


}
