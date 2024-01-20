package org.artauc.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	
	// 마켓때는 controller에서 해줬다면 이제는 여기 dto 생성자에서 페이지 처리한다음에 넘기기
	
	private final double NUM_PER_PAGE = 5.0;  // 한 페이지에 표시할 페이지 번호 수 , 한페이지에 숫자 눌러서 가는 페이지 번호
	private int start; 						  // 시작 페이지 번호
	private int end;  						  // 끝 페이지 번호
	private boolean prev; 				 	  // 이전
	private boolean next;   				  // 다음
	private Criteria cri; 				      // 한 페이지에 표시할 게시물의 수 및 페이지 번호 -> 얘는 cri쓴다.
	
	public PageDTO(Criteria cri, int totalCount) {
		// 전체 페이지 얼마나 나오는지
		// 시작값이랑 끝, 이전, 다음 ,cri는 받을거니까 this로 담아야함.
		this.cri = cri;
		
		int pages = (int)(Math.ceil((double)totalCount / cri.getAmount())); 	// amount와 pageNum은 cri에서 가져온다. 
																				// totalCount 와 amount는 int라서 double로 형변환
		// 각 페이지의 시작 페이지 번호 | ... | 끝번호
		end =(int)(Math.ceil(cri.getPageNum() / NUM_PER_PAGE)*NUM_PER_PAGE);   // 끝페이지 번호
		start = end - (int)(NUM_PER_PAGE - 1);
		end = end > pages ? pages : end;
		
		// 이전 | 이후 버튼 활성화 여부
		prev = start > 1;
		next = end < pages;
}

}
