package org.artauc.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

// 한 페이지에 출력할 게시물의 수, 페이지 번호,
// 검색 타입,검색 키워드 저장 및 전달

@Setter
@Getter
@ToString
public class Criteria {

	private  int amount;
	private int pageNum;
	private String type;
	private String keyword;
	
	
	// 값을 지정하지 않은 경우
	// 한 페이지 게시물은 3개, 페이지 번호는 1로 지정
	public Criteria() {
		this(10,1);
		}
	// 그럼 위에서 받아서 아래로 전달
	
	// 값을 지정한 경우
	// 매개변수로 전달 받은 값으로 지정
	public Criteria(int amount, int pageNum) {
		super();
		this.amount = amount;
		this.pageNum = pageNum;
		
	}
	
	// 검색
	public String [] getTypeArr(){
		return type == null ? new String[] {} : type.split("");   // 타입이 값이 없으면 그냥 문자열 배열 객체 만들어 보낼거고
																  // 값이 있으면 잘라서 보낼거다. ex ) TC가 오면 T랑 C
	}														
	
	
	
	
	
	
}
