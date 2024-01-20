package org.artauc.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import org.artauc.domain.Criteria;
import org.artauc.domain.ReplyPageDTO;
import org.artauc.domain.ReplyVO;
import org.artauc.mapper.FreeMapper;
import org.artauc.mapper.ReplyMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


// @AllArgsConstructor 나 @Setter 붙이기!

@Service     												// 서비스단은 서비스 어노테이션
@AllArgsConstructor											// 생성자
@Log4j
public class ReplyServiceImpl implements ReplyService {

	private ReplyMapper replyMapper;
	private FreeMapper freeMapper;
	
	@Override
	public ReplyVO view(int rpno) {
		
		log.info("reply view....");
		return replyMapper.reSelect(rpno);
	}
	
	@Transactional   // 트랜잭션 어노테이션 필수 -> 등록되면 숫자 댓글 카운트
	@Override
	public boolean add(ReplyVO rvo) {
		log.info("reply add....");
		
		freeMapper.updateReplyCnt(1, rvo.getFrno());
	
		return replyMapper.reInsert(rvo)==1 ;
	}

	@Transactional     // 알아서 파악해서 추가되고 삭제될 것이다.
	@Override
	public boolean remove(int rpno) {
		ReplyVO rvo =replyMapper.reSelect(rpno);  // 객체가 필요하고 select 된 댓글 중 게시판 번호 가져오기
		log.info("reply remove....");
		
		freeMapper.updateReplyCnt(-1, rvo.getFrno());
		return replyMapper.reDelete(rpno)== 1;
	}

	@Override
	public boolean modify(ReplyVO rvo) {
		log.info("reply modify....");
		return replyMapper.reUpdate(rvo) ==1;
	}

	@Override
	public ReplyPageDTO list(int frno, Criteria cri) {
		
		// pto에 생성자를 만들었으니 dto에 두개를 담아서 보내면 된다.
   return new ReplyPageDTO(replyMapper.selectReply(frno),replyMapper.reSelectAllPaging(frno,cri));
	
	}

	@Override
	public List<ReplyVO> mylist(String mid, Criteria cri) {
		
		log.info("remylist"+ cri + mid);
				
		return replyMapper.reSelectAllmy(mid, cri);
	
	}

	@Override
	public int totalmy(String mid, Criteria cri) {
		log.info("reply mytotal....");
		return replyMapper.totalmy(mid,cri);
	}



}
