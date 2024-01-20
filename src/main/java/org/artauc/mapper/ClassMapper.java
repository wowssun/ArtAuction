package org.artauc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.artauc.domain.ClassVO;



public interface ClassMapper {
	
	public List<ClassVO> selectAll(); //목록 전체 불러오기
	public List<ClassVO> selectMyAll(String mid); //내 클래스 개설 목록
	public ClassVO select(int cno); //클래스 상세보기
	public int insert(ClassVO cvo); //클래스 등록
	public int delete(int cno); //클래스 삭제
	public int update(ClassVO cvo); //클래스 수정
	
	public void updateReqCnt(@Param("cntUpdate") int cntUpdate, @Param("cno") int cno); //클래스 신청 인원
//	public int selectReqMe(int cno, String mid); //클래스 신청 여부
	public int selectReqMe(@Param("cno") int cno, @Param("mid") String mid);//클래스 신청 여부
	
	
}
