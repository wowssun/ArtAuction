package org.artauc.mapper;



import org.apache.ibatis.annotations.Param;
import org.artauc.domain.PayVO;

public interface PayMapper {

	public int insert(@Param("ano")int ano, @Param("price")int price);
	public PayVO bidlist(String mid);
}
