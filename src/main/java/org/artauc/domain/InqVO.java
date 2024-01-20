package org.artauc.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class InqVO {

	private int rno;
	private String mid;
	private String title;
	private String detail;
	private String answer;
	private Date writeDate;
	private Date updateDate;
	private Date answerDate;
}
