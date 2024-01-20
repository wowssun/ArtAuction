package org.artauc.service;

import org.artauc.domain.PayVO;
import org.artauc.mapper.PayMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
public class PayServiceImpl implements PayService {
	@Setter(onMethod_ = @Autowired)
	private PayMapper payMapper;

	@Override
	public PayVO bidlist(String mid) {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public boolean insert(int ano, int price) {
		return payMapper.insert(ano, price)==1;
	}

}
