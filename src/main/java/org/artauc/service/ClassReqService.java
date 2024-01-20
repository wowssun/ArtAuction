package org.artauc.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.artauc.domain.ClassReqVO;

public interface ClassReqService {
	
	public List<ClassReqVO> reqList(int cno); //신청자 목록
	public List<ClassReqVO> reqMyList(String mid); //내 신청자 목록
	public boolean reqRegi(ClassReqVO reqvo); //신청 등록
	public boolean reqCancle(int reqno); //신청 취소
	

}
