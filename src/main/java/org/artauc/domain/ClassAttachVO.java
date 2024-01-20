package org.artauc.domain;

import lombok.Data;

@Data
public class ClassAttachVO {
	//connect with classList, didnt need find pic so delete
	private int cno;
	private String uuid; //중복되지 않는 아이디
	private String upfolder; //경로 이름
	private String filename; //파일 이름 
	
}
