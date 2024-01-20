package org.artauc.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.artauc.domain.ArtVO;
import org.artauc.domain.Criteria;

public interface ArtMapper {

	public int insert(ArtVO avo); //등록

	public ArtVO select(int ano); //상세조회

	public List<ArtVO> selectAllPaging(Criteria cri); //전체목록

	public int totalCount(Criteria cri); //전체 게시글 수
	
	public List<ArtVO> selectMyArt(@Param("mid") String mid, @Param("cri") Criteria cri); //나의작품목록
	
	public List<ArtVO> selectMyArtF(String mid); //나의작품목록 펀딩페이지에서 쓸것
	
	public int myArtCount(@Param("mid") String mid, @Param("cri") Criteria cri); //나의 게시글 수

	public int update(ArtVO avo); //수정

	public int delete(int ano); //삭제
	
	
	//테스트용
	public List<ArtVO> selectAll();


}
