package org.artauc.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class AucVO {

	private int ano;
	private String mid;
	private String artName;
	private String artist;
	private Date startDate;
	private Date endDate;
	private Date payDate;
	private int priceC;
	private int priceE;
	private int priceS;
	private String intro;
	private String artImg;
	private String condition;
	private String paystatement;
	private String buyer;
}
