package org.artauc.service;

import java.util.List;

import org.artauc.domain.ArtistVO;
import org.artauc.domain.Criteria;
import org.artauc.domain.MemberVO;
import org.artauc.domain.RequestVO;

public interface AdminService {

	
	public List<MemberVO> list(Criteria cri); //회원목록 select MemberVO
	public List<MemberVO> lockList(Criteria cri); //잠금회원목록 select MemberVO
	public boolean lockModify(String mid); // 잠금해제하기 update
	public List<MemberVO> artList(Criteria cri); //작가회원목록 select MemberVO
	public List<RequestVO> requeList(Criteria cri); //작가신청목록 select RequestVO
	public ArtistVO requeselect(String mid); //작가 신청상세조회 select	
	public boolean stateModify(RequestVO rvo); //작가 신청 승인 / 거절 update
	public List<RequestVO> okNoList(Criteria cri); //작가 승인 / 거절 목록 select RequestVO
	public List<RequestVO> okList(Criteria cri); //작가 승인  목록 select RequestVO
	public List<RequestVO> noList(Criteria cri); //작가  거절 목록 select RequestVO
	public boolean remove(String mid) ;// 회원 탈퇴 delete
	
	// member 전체 게시물 수
    public int mtotalCount(Criteria cri);
    
	// artist 전체 게시물 수
    public int atotalCount(Criteria cri);
    
	// request 전체 게시물 수
    public int rtotalCount(Criteria cri);
    
 // locktotalCount 잠금회원 수
    public int locktotalCount(Criteria cri);
    
 // oknototalCount 상태가 승인이나 거절인 회원 수
    public int oknototalCount(Criteria cri);
    public int oktotalCount(Criteria cri);
    public int nototalCount(Criteria cri);
}
