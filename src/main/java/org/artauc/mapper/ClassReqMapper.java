package org.artauc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.artauc.domain.ClassReqVO;
import org.artauc.domain.ClassVO;

public interface ClassReqMapper {
	public int insertReq(ClassReqVO reqvo); //클래스 신청
	public List<ClassReqVO> selectReq(int cno); //클래스 신청자 목록 
	public List<ClassReqVO> selectMyReq(String mid); //내 클래스 신청 목록
	public int deleteReq(int reqno); //신청 취소
	
	public int selectReqNum(int cno); //신청자 수
	public ClassReqVO select(int reqno); //신청 하나 선택 +
	


}
