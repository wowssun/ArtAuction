package org.artauc.domain;

import java.util.List;

import lombok.Data;

@Data
public class ArtistVO {

	
	private String mid; // 아이디
	private String major; // 전공분야
	private String photo; // 첨부사진 파일 이름. 작가 한명당 작가 사진 하나니까 이렇개 파일이름만 저장
	private String introduce; // 자기 소개

	// 이력을 새로운 테이블에서 리스트로 가져온다. 해당 아이디로
	private List<CareerVO> careerlist; 
	
	private String name;  // 이름


}