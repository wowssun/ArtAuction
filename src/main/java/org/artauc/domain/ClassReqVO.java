package org.artauc.domain;

import java.util.List;

import lombok.Data;

@Data
public class ClassReqVO {
	private int reqno;
	private int cno;
	private String mid;
//	private MemberVO mvo;
//	private ClassVO cvo;
	
	private MemberVO mvo; //list x
	private ClassVO cvo;
}
