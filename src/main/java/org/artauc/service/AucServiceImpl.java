package org.artauc.service;

import java.util.List;

import org.artauc.domain.ArtVO;
import org.artauc.domain.AucCriteria;
import org.artauc.domain.AucVO;
import org.artauc.domain.BidVO;
import org.artauc.domain.Criteria;
import org.artauc.mapper.AucMapper;
import org.artauc.mapper.BidMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;

@Service
public class AucServiceImpl implements AucService {
	@Setter(onMethod_ = @Autowired)
	private AucMapper aucMapper;
	@Setter(onMethod_ = @Autowired)
	private BidMapper bidMapper;
	private boolean result;
	
	@Override
	public List<AucVO> selectAllPaging(AucCriteria cri) {
		return aucMapper.selectAllPaging(cri);
	}

	@Override
	public int totalCount(AucCriteria cri) {
		return aucMapper.totalCount(cri);
	}

	@Override
	public boolean update(AucVO avo) {
		return aucMapper.update(avo)==1;
	}

	@Override
	public boolean delete(int ano) {
		return aucMapper.delete(ano)==1;
	}

	@Override
	public boolean insertSelectKey(AucVO avo) {
		return aucMapper.insertSelectKey(avo)==1;
	}

	@Override
	public AucVO select(int ano) {
		return aucMapper.select(ano);
	}

	@Override
	@Transactional
	public boolean updateBid(int ano, String buyer, int priceC) {
		result = aucMapper.updateBid(ano, buyer, priceC)==1;
		if(result) {
			BidVO bvo = new BidVO();
			bvo.setAno(ano);
			bvo.setMid(buyer);
			bvo.setPriceB(priceC);
			bidMapper.insert(bvo);
		}
		return result;
	}

	@Override
	public List<ArtVO> selectart(String mid) {
		return aucMapper.selectart(mid); 
	}

	@Override
	public ArtVO selectArtdetail(String artName, String mid) {
		return aucMapper.selectArtdetail(artName, mid);
	}

	@Override
	public List<AucVO> selectAll() {
		return aucMapper.selectAll();
	}

	@Override
	public List<AucVO> mylist(AucCriteria cri, String mid) {
		return aucMapper.mylist(cri, mid);
	}

	@Override
	public int myAucCount(AucCriteria cri, String mid) {
		return aucMapper.myAucCount(cri, mid);
	}

	@Override
	public int sbidCount(AucCriteria cri, String mid) {
		return aucMapper.sbidCount(cri, mid);
	}

	@Override
	public List<AucVO> sbidlist(AucCriteria cri, String buyer) {
		return aucMapper.sbidlist(cri, buyer);
	}
}
