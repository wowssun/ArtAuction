package org.artauc.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class PayVO {

	private int pno;
	private int ano;
	private int price;
	private Date payDate;
}
