package org.artauc.service;

import java.util.List;

import org.artauc.domain.ArtVO;
import org.artauc.domain.Criteria;


public interface ArtService {

	public boolean register(ArtVO avo); //작품등록

	public ArtVO view(int ano); //상세조회

	public List<ArtVO> listAll(Criteria cri); //전체목록
	
	public List<ArtVO> myartList(String mid, Criteria cri); //나의작품목록

	public int totalCount(Criteria cri); //전체 게시글 수
	
	public int myArtCount(String mid, Criteria cri); //나의 게시글 수
	
	public boolean modify(ArtVO avo); //수정

	public boolean remove(int ano); //삭제
	
	
	public List<ArtVO> list();
	
	public List<ArtVO> myartListF(String mid);

	


}
