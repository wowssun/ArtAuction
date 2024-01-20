package org.artauc.service;

import java.util.List;

import org.artauc.domain.BidVO;
import org.artauc.domain.Criteria;
import org.artauc.mapper.BidMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
public class BidServiceImpl implements BidService {
	@Setter(onMethod_ = @Autowired)
	private BidMapper bidMapper;

	@Override
	public List<BidVO> bidlist(Criteria cri, String mid) {
		return bidMapper.bidlist(cri, mid);
	}

	@Override
	public int bidCount(Criteria cri, String mid) {
	    return bidMapper.bidCount(cri, mid);
	}
}
