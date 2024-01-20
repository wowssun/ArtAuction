package org.artauc.service;

import java.util.List;

import org.artauc.domain.Criteria;
import org.artauc.domain.InqVO;
import org.artauc.mapper.InqMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;

@Service
public class InqServiceImpl implements InqService {
	@Setter(onMethod_ = @Autowired)
	private InqMapper inqMapper;
	
	@Override
	public List<InqVO> selectAllPaging(Criteria cri) {
		return inqMapper.selectAllPaging(cri);
	}

	@Override
	public int totalCount(Criteria cri) {
		return inqMapper.totalCount(cri);
	}

	@Override
	public boolean update(InqVO ivo) {
		return inqMapper.update(ivo)==1;
	}

	@Override
	public boolean delete(int rno) {
		return inqMapper.delete(rno)==1;
	}

	@Override
	public boolean insertSelectKey(InqVO ivo) {
		return inqMapper.insertSelectKey(ivo)==1;
	}

	@Override
	public InqVO select(int rno) {
		return inqMapper.select(rno);
	}

	@Override
	public List<InqVO> selectAll() {
		return inqMapper.selectAll();
	}

	@Override
	public List<InqVO> mylist(Criteria cri, String mid) {
		return inqMapper.mylist(cri, mid);
	}

	@Override
	public List<InqVO> answerlist(Criteria cri) {
		return inqMapper.answerlist(cri);
	}

	@Override
	public int myCount(Criteria cri, String mid) {
		return inqMapper.myCount(cri, mid);
	}

	@Override
	public int ansCount(Criteria cri) {
		return inqMapper.ansCount(cri);
	}

	@Override
	public boolean updateAdmin(InqVO ivo) {
		return inqMapper.updateAdmin(ivo)==1;
	}

}
