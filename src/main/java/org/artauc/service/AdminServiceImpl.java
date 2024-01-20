package org.artauc.service;

import java.util.List;

import org.artauc.domain.ArtistVO;
import org.artauc.domain.Criteria;
import org.artauc.domain.MemberVO;
import org.artauc.domain.RequestVO;
import org.artauc.mapper.AdminMapper;
import org.artauc.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service     												// 서비스단은 서비스 어노테이션
@Log4j
public class AdminServiceImpl implements AdminService {
	
	@Setter(onMethod_ = @Autowired)
	private AdminMapper adminMapper;
	
	@Setter(onMethod_ = @Autowired)
	private UserMapper us;

	@Override
	public List<MemberVO> list(Criteria cri) {
		
		log.info("list...");
		
		return adminMapper.selectAll(cri);
	}

	@Override
	public List<MemberVO> lockList(Criteria cri) {
	
		log.info("lockList...");
		
		return adminMapper.lockSelectAll(cri);
	}

	@Override
	@Transactional   // 두 테이블이 같이 움직여야 하니까 어노테이션 필수!
	public boolean lockModify (String mid) {
		
		log.info("lockModify...");
		
		if(adminMapper.lockUpdate(mid)==1) {
			adminMapper.lockDateUpdate(mid);
			return true;
		}
			
		return false;
	}

	@Override
	public List<MemberVO> artList(Criteria cri) {
		
		log.info("artList...");
		
		return adminMapper.artSelectAll(cri);
	}

	@Override
	public List<RequestVO> requeList(Criteria cri) {
		
		log.info("requeList...");
		
		return adminMapper.requeSelectAll(cri);
	}

	@Override
	public ArtistVO requeselect(String mid) {
		
		log.info("requeselect...");
		
		return adminMapper.requeselect(mid);
	}

	@Override
	@Transactional  // 테이블 같이 움직이기
	public boolean stateModify(RequestVO rvo) {
		
		log.info("stateModify...");
		
		if(rvo.getState().equals("승인")) {  // 신청상태가 승인이면
			if(adminMapper.stateUpdate(rvo)==1) { // 일단 권한을 업데이트 하고
				adminMapper.requeUpdate(rvo.getMid());
				return true;
			}
		 }else {
			if(adminMapper.stateUpdate(rvo)==1) {
				adminMapper.requeDelete(rvo.getMid());
				
				return true;
				}
		 }
		
		return false;	
	}

	@Override
	public List<RequestVO> okNoList(Criteria cri) {
		
		log.info("okNoList...");
		
		return adminMapper.okNoSelectAll(cri);
	}

	@Override
	public boolean remove(String mid) {
		
		log.info("remove...");
		
		return adminMapper.delete(mid)==1;
	}

	@Override
	public int mtotalCount(Criteria cri) {
		
		log.info("mtotalCount...");
		
		return adminMapper.mtotalCount(cri);
	}

	@Override
	public int atotalCount(Criteria cri) {
		
		log.info("atotalCount...");
		
		return adminMapper.atotalCount(cri);
	}

	@Override
	public int rtotalCount(Criteria cri) {
		
		log.info("rtotalCount...");
		
		return adminMapper.rtotalCount(cri);
	}

	@Override
	public int locktotalCount(Criteria cri) {
		log.info("locktotalCount...");
		
		return adminMapper.locktotalCount(cri);
	}

	@Override
	public int oknototalCount(Criteria cri) {
		log.info("oknototalCount...");
		
		return adminMapper.oknototalCount(cri);
	}

	

	@Override
	public List<RequestVO> okList(Criteria cri) {
		log.info("okList...");
		
		return adminMapper.okSelectAll(cri);
	}

	@Override
	public List<RequestVO> noList(Criteria cri) {
		log.info("noList...");
		
		return adminMapper.noSelectAll(cri);
	}

	@Override
	public int oktotalCount(Criteria cri) {
		log.info("oktotalCount...");
		
		return adminMapper.oktotalCount(cri);
	}

	@Override
	public int nototalCount(Criteria cri) {
		log.info("nototalCount...");
		
		return adminMapper.nototalCount(cri);
	}
	
	
	

	
	
}
