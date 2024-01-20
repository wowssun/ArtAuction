package org.artauc.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class BidVO {

	private int bno;
	private int ano;
	private String mid;
	private String artName;
	private String artImg;
	private int priceB;
	private int priceC;
	private Date bidDate;

}
