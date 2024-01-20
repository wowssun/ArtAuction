package org.artauc.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AucCriteria {
	private int amount;
	private int pageNum;
	private String type;
	private String keyword;
	
	
	public AucCriteria() {
		this(6, 1);
	}

	
	public AucCriteria(int amount, int pageNum) {
		this.amount = amount;
		this.pageNum = pageNum;
	}
	
	public String[] getTypeArr() {
		return type == null ? new String[]{} : type.split("");
	}
}
