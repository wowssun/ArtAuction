package org.artauc.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.artauc.domain.FreeAttachVO;
import org.artauc.domain.FreeVO;
import org.artauc.domain.Criteria;
import org.artauc.mapper.FreeAttachMapper;
import org.artauc.mapper.FreeMapper;
import org.artauc.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;



@Service     												// 서비스단은 서비스 어노테이션
@Log4j
public class FreeServiceImpl implements FreeService {
	
	  @Setter(onMethod_ = @Autowired)
	   private FreeMapper freeMapper;						// 생성자 넣으니까 안된다. 다시 setter로 변경
		
	   @Setter(onMethod_ = @Autowired)
	  private FreeAttachMapper freeAttachMapper;				// 그 다음에는 root context에 가서
	   
	   @Setter(onMethod_ = @Autowired)
	   private ReplyMapper replyMapper;
	   
	
		
	@Override
	@Transactional   // 두 테이블이 같이 움직여야 하니까 어노테이션 필수!
	public boolean register(FreeVO fvo) {	
		log.info("register..." + fvo);
		
		boolean result = freeMapper.insertSelectKey(fvo) ==1;
		
		
		if(fvo.getAttachList() != null &&  fvo.getAttachList().size() > 0) { // 만약bvo의 attachaList가 있다면
			fvo.getAttachList().forEach( favo -> {  // for문 돌면서 bvolist에 bno를 꺼내서
						favo.setFrno(fvo.getFrno());
						freeAttachMapper.insert(favo);
					});						
		 
	}
		return result;			
		
	}
			

	@Override
	public FreeVO view(int frno) {
		
		log.info("view....");
					

	    return freeMapper.select(frno);
				
	} 


	@Override
	@Transactional
	public boolean remove(int frno) {
		
		log.info("remove...");
		
		// 게시판 번호를 모두 가지고 있어서 미리 삭제를 해주고 게시판삭제.
		
		// 댓글 모두 삭제  --> 여기 mapper로 만들어서 처리했습니다.
		replyMapper.reDeleteAll(frno);
		
		// 첨부파일 모두 삭제
		freeAttachMapper.deleteAll(frno);
		
		//baMapper.delete(uuid) ==1;
		
		return freeMapper.delete(frno);
		
		
	}

	@Override
	@Transactional
	public boolean modify(FreeVO fvo) {
		
		log.info("modify...");
		
		// 첨부파일 모두 삭제
		freeAttachMapper.deleteAll(fvo.getFrno());
		
		boolean result =  freeMapper.update(fvo); 		// 게시물 수정
		
		// 첨부파일이 있으면 등록
		if(fvo.getAttachList() != null  &&  fvo.getAttachList().size() > 0) {  // 만약 bvo의 attachaList가 있다면 
			
			fvo.getAttachList().forEach(favo -> { favo.setFrno(fvo.getFrno());   // for문 돌면서 bvolist에 bno를 꺼내서
			
			freeAttachMapper.insert(favo);
		});
	}	
		return result;
			
	}
	

	@Override
	public int totalCount(Criteria cri) {
		log.info("totalCount...");
		
		return freeMapper.totalCount(cri);
	}

	@Override
	public List<FreeVO> list(Criteria cri) {
		log.info(cri);
		return freeMapper.selectAllPaging(cri);
	}

	@Override
	public List<FreeAttachVO> attachList(int frno) {
		
		log.info("attach view");
		
		return freeAttachMapper.selectAll(frno);
	}

	@Override
	public boolean updateHit(int frno) {
		
		log.info("updateHit");
		
		return freeMapper.updateHit(frno)==1;
	}


	@Override
	public int insertSelectKey(FreeVO fvo) {
		// TODO Auto-generated method stub
		return 0;
	}


	@Override
	public List<FreeVO> selectAllmy(String mid,Criteria cri) {
		log.info("mylist free");
		
		return freeMapper.selectAllmy(mid,cri);
	}


	@Override
	public int mycount(String mid,Criteria cri) {
	log.info("myCount...");
		
		return freeMapper.mycount(mid,cri);
	}


	/*
	 * @Override public boolean replyCntmodify(int amount, int bno) {
	 * 
	 * log.info("amount : " + amount); log.info("bno : " + bno);
	 * 
	 * return boardMapper.updateReplyCnt(amount, bno) == 1; }
	 */

}
