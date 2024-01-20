package org.artauc.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.artauc.domain.ArtVO;
import org.artauc.domain.AucCriteria;
import org.artauc.domain.AucVO;

public interface AucService {

	public List<AucVO> selectAllPaging(AucCriteria cri);
	public int totalCount(AucCriteria cri);
	public int myAucCount(@Param("cri")AucCriteria cri, @Param("mid")String mid);
	public int sbidCount(@Param("cri")AucCriteria cri, @Param("mid")String mid);
	public boolean update(AucVO avo);
	public boolean delete(int ano);
	public boolean insertSelectKey(AucVO avo);
	public AucVO select(int ano);
	public boolean updateBid(@Param("ano")int ano,@Param("buyer")String buyer,@Param("priceC")int priceC);
	public List<ArtVO> selectart(String mid);
	public ArtVO selectArtdetail(@Param("artName")String artName, @Param("mid") String mid);
	public List<AucVO> selectAll();
	public List<AucVO> mylist(@Param("cri")AucCriteria cri, @Param("mid")String mid);
	public List<AucVO> sbidlist(@Param("cri")AucCriteria cri, @Param("buyer")String buyer);
}
