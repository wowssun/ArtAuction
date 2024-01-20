package org.artauc.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.artauc.domain.Criteria;
import org.artauc.domain.InqVO;

public interface InqService {

	public List<InqVO> selectAllPaging(Criteria cri);
	public List<InqVO> selectAll();
	public List<InqVO> mylist(@Param("cri")Criteria cri, @Param("mid")String mid);
	public List<InqVO> answerlist(Criteria cri);
	public int totalCount(Criteria cri);
	public int myCount(@Param("cri")Criteria cri, @Param("mid")String mid);
	public int ansCount(Criteria cri);
	public boolean update(InqVO ivo);
	public boolean updateAdmin(InqVO ivo);
	public boolean delete(int rno);
	public boolean insertSelectKey(InqVO ivo);
	public InqVO select(int rno);
}
