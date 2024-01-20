package org.artauc.service;

import java.util.List;

import org.artauc.domain.Criteria;
import org.artauc.domain.FCriteria;
import org.artauc.domain.FundPayVO;
import org.artauc.domain.FundVO;
import org.artauc.mapper.FundMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class FundServiceImpl implements FundService {
	
	@Setter(onMethod_ = @Autowired)
	private FundMapper fundMapper;


	@Override
	public boolean register(FundVO fvo) {
		log.info("Service Fund Register!" + fvo);
		
		return fundMapper.insert(fvo)==1;
	}

	@Override
	public FundVO view(int fno) {
		log.info("Service Fund View!" + fno);
		
		return fundMapper.select(fno);
	}
	
//	@Override
//	public List<FundVO> list(FCriteria cri, String sort) { //최신순
//		log.info("Service Fund list!");
//		
//		return fundMapper.selectAllPaging(cri, sort);
//	}

	@Override
	public List<FundVO> list(FCriteria cri) { //최신순
		log.info("Service Fund Latest list!");
		
		return fundMapper.selectAllPaging(cri);
	}
//	
//	@Override
//	public List<FundVO> listP(FCriteria cri) { //누적금액순
//		log.info("Service Fund Total Price list!");
//		
//		return fundMapper.selectAllPagingP(cri);
//	}
//	
//	@Override
//	public List<FundVO> listD(FCriteria cri) { //마감임박일순
//		log.info("Service Fund End Date list!");
//		
//		return fundMapper.selectAllPagingD(cri);
//	}
	
	@Override
	public List<FundVO> myfundList(String mid, FCriteria cri) {
		log.info("Service My Fund list!");
		
		return fundMapper.selectMyFund(mid, cri);
	}
	
	@Override
	public List<FundPayVO> mypayList(String mid, Criteria cri) {
		log.info("Service My Pay list!");
		
		return fundMapper.selectMyPay(mid, cri);
	}
	
	@Override
	public int totalCount(FCriteria cri) {
		log.info("Service Fund totalCount!");
		
		return fundMapper.totalCount(cri);
	}

//	@Override
//	public int totalCount(FCriteria cri, String sort) {
//		log.info("Service Fund totalCount!");
//		
//		return fundMapper.totalCount(cri, sort);
//	}
	
	@Override
	public int myFundCount(String mid, FCriteria cri) { //나의펀딩게시글
		log.info("Service My Fund Count!");
		return fundMapper.myFundCount(mid, cri);
	}
	
	@Override
	public int myPayCount(String mid, Criteria cri) { //나의결제내역
		log.info("Service My Pay Count!");
		return fundMapper.myPayCount(mid, cri);
	}

	@Override
	public boolean modify(FundVO fvo) {
		log.info("Service Fund Modify!");
		
		return fundMapper.update(fvo)==1;
	}

	@Override
	public boolean remove(int fno) {
		log.info("Service Fund Remove!");
		
		return fundMapper.delete(fno)==1;
	}
	


	@Override
	public boolean payRegister(String mid, int fno, int amount) {
		log.info("Service FundPay payRegister!");
		
		return fundMapper.insertPay(mid, fno, amount)==1;
	}

//	@Override
//	public boolean totalPriceUpdate(int fno, int amount) {
//		log.info("Service FundPay totalPriceUpdate!");
//		
//		return fundMapper.totalPriceUpdate(fno, amount)==1;
//	}

	@Override
	public boolean partcpntCntUpdate(int fno) {
		log.info("Service FundPay partcpntCntUpdate!");
		return fundMapper.partcpntCntUpdate(fno)==1;
	}


	}

	



