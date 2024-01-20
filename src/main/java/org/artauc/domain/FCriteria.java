package org.artauc.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FCriteria {
	private int amount;
	private int pageNum;// 페이지 번호
	private String sort;
	private String type; // 검색
	private String keyword; // 검색
	
	public FCriteria(int amount, int pageNum, String sort) {
        this.amount = amount;
        this.pageNum = pageNum;
        this.sort = sort;
    }

    public FCriteria() {
        this(8, 1, "latest");
    }
    
    public String [] getTypeArr() {
		return type == null ? new String[]{} : type.split("");
	}
    
    public String [] getSortArr() {
		return sort == null ? new String[]{} : type.split("");
	}
    
}
