package org.artauc.mapper;

import java.util.List;

import org.artauc.domain.ArtistVO;
import org.artauc.domain.Criteria;
import org.artauc.domain.MemberVO;
import org.artauc.domain.RequestVO;

public interface AdminMapper {
	
	public List<MemberVO> selectAll(Criteria cri); //회원목록 select MemberVO
	public List<MemberVO> lockSelectAll(Criteria cri);  // 잠금 회원목록
	public int lockUpdate(String mid); // 잠금해제하기 update
	public int lockDateUpdate(String mid);   //잠금해제시 stopdate null로	
	public List<MemberVO> artSelectAll(Criteria cri);//작가회원목록 select MemberVO
	public List<RequestVO> requeSelectAll(Criteria cri);//작가신청목록 select RequestVO
	public ArtistVO requeselect(String mid);//작가 신청상세조회 select
	public int requeUpdate(String mid);//작가 신청 승인시 권한 바뀌는거
	public int requeDelete(String mid); // 작가 신청 거절시 작가테이블에서 삭제
	public int stateUpdate(RequestVO rvo);   /// 작가 신청 승인 / 거절시 신청상황 업뎃
	public List<RequestVO> okNoSelectAll(Criteria cri); //작가 승인 / 거절 목록 select RequestVO
	public List<RequestVO> okSelectAll(Criteria cri); //작가 승인  목록 select RequestVO
	public List<RequestVO> noSelectAll(Criteria cri); //작가 거절 목록 select RequestVO
	public int delete(String mid); // 회원 탈퇴 delete
	
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
