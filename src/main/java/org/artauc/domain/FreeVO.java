package org.artauc.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class FreeVO {

	private int frno; // 게시판 번호
	private String mid;   // 회원 아이디
	private String title; // 제목
	private String content; // 내용
	private Date regDate; // 작성일
	private Date updateDate; // 수정일
	private int replyCnt;  // 댓글수
	private int hit; // 조회수
	
	private List<FreeAttachVO> attachList;     // 목록으로 받는다.
	
}
