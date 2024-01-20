package org.artauc.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class FPageDTO {
	
	private final double NUM_PER_PAGE = 5.0; // 한 페이지에 표시할 페이지 번호 수
	private int start; // 시작 페이지 번호
	private int end; // 끝 페이지 번호
	private boolean prev; // 이전
	private boolean next;// 다음
	private FCriteria cri;// 한 페이지에 표시할 게시물의 수 및 페이지 번호

	
	public FPageDTO(FCriteria cri, int totalCount) {
		this.cri = cri;
		
		int pages = (int)(Math.ceil((double)totalCount/cri.getAmount())); 
		end = (int)(Math.ceil(cri.getPageNum()/NUM_PER_PAGE) * NUM_PER_PAGE); 
		start = end - (int)(NUM_PER_PAGE - 1);
		end   = end >= pages ? pages : end; 

		prev = start > 1;
		next = end < pages;
	}

}
