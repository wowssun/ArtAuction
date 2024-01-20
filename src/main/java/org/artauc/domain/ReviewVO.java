package org.artauc.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReviewVO {
	private int rno;
	private String reviewscript;
	private Date uploaddate;
	private String mid;
	private int cno;
//	private String className; 

	private ClassVO cvo;
//	private List<ClassVO> cvoList;

}
