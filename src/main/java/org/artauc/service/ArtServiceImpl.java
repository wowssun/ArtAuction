package org.artauc.service;

import java.util.List;

import org.artauc.domain.ArtVO;
import org.artauc.domain.Criteria;
import org.artauc.mapper.ArtMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Service
@Log4j
public class ArtServiceImpl implements ArtService {

@Setter(onMethod_ = @Autowired)
private ArtMapper artMapper;

	@Override
	public boolean register(ArtVO avo) {
		log.info("Service Art Register!" + avo);
		
		return artMapper.insert(avo) == 1;
	}

	@Override
	public ArtVO view(int ano) {
		log.info("Service Art View!");
		
		return artMapper.select(ano);
	}

	@Override
	public List<ArtVO> listAll(Criteria cri) {
		log.info("Service Art list!");
		
		return artMapper.selectAllPaging(cri);
	}
	
	@Override
	public List<ArtVO> myartList(String mid, Criteria cri) {
		log.info("Service My Art list!");
		
		return artMapper.selectMyArt(mid, cri);
	}
	
	
	@Override
	public int totalCount(Criteria cri) {
		log.info("Service Art totalCount!");
		
		return artMapper.totalCount(cri);
	}
	
	public int myArtCount(String mid, Criteria cri) {
		log.info("Service My Art Count!");
		
		return artMapper.myArtCount(mid, cri);
	}

	@Override
	public boolean modify(ArtVO avo) {
		log.info("Service Art Modify!");
		
		return artMapper.update(avo) == 1;
	}

	@Override
	public boolean remove(int ano) {
		log.info("Service Art Remove!");
		
		return artMapper.delete(ano) == 1;
	}

	@Override
	public List<ArtVO> list() {
		log.info("list..........");
		return artMapper.selectAll();
	}

	@Override
	public List<ArtVO> myartListF(String mid) {
		log.info("myartListF..........");
		return artMapper.selectMyArtF(mid);
	}

	
	
	
//	//테스트용
//	@Override
//	public List<ArtVO> list() {
//		log.info("list..........");
//		return artMapper.selectAll();
//	}

	

}
