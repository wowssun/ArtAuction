package org.artauc.service;



import org.apache.ibatis.annotations.Param;
import org.artauc.domain.PayVO;

public interface PayService {

	public boolean insert(@Param("ano")int ano, @Param("price")int price);
	public PayVO bidlist(String mid);
}
