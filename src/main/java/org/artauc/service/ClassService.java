package org.artauc.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.artauc.domain.ClassAttachVO;
import org.artauc.domain.ClassReqVO;
import org.artauc.domain.ClassVO;



public interface ClassService {
	

	public List<ClassVO> list(); //전체 리스트
	public List<ClassVO> myList(String mid); //내 클래스 리스트
	public ClassVO view(int cno); //클래스 상세보기
	public boolean register(ClassVO cvo); //클래스 등록
	public boolean remove(int cno); //클래스 삭제
	public boolean modify(ClassVO cvo); //클래스 수정
	
//	public int reqPeople(int cno);
	public boolean reqMyId(int cno, String mid);
	
}


