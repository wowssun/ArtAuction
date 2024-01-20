package org.artauc.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyVO {
	
	private int rpno; // 댓글 번호
	private int frno; // 게시판 번호
	private String mid;  // 회원 아이디
	private String reply; // 댓글 내용
	private Date regDate; // 댓글 작성일
	private Date updateDate; // 댓글 수정일
	
	private String title; // 게시판 제목

}
