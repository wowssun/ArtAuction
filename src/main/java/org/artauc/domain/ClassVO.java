package org.artauc.domain;

import java.util.List;

import lombok.Data;



@Data
public class ClassVO {
	private int cno;
	private String mid; //작가
	private String classname;
	private String classinfo;
	private String classdate; //진행 날짜
	private String classtime; //진행 시간
	private int peoplenum;
	private int runningtime;
	private String classimg;
	private int reqcnt; //신청 갯수
	
//	private List<ClassAttachVO> attachList; //파일 목록
	
	private List<ClassReqVO> reqList;
	private List<ReviewVO> rvList;
	

}
