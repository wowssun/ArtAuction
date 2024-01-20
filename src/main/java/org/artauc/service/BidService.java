package org.artauc.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.artauc.domain.BidVO;
import org.artauc.domain.Criteria;

public interface BidService {
	
	public List<BidVO> bidlist(@Param("cri")Criteria cri, @Param("mid")String mid);
	public int bidCount(@Param("cri")Criteria cri, @Param("mid")String mid);
}
