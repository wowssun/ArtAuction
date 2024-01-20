package org.artauc.mapper;

import java.util.List;

import org.artauc.domain.FreeAttachVO;

public interface FreeAttachMapper {
	
		// 전체 가져오기
		public List<FreeAttachVO> selectAll(int frno);
		
		// insert  
		public int insert(FreeAttachVO favo);
		
		// delete
		public int delete(String uuid);

		// deleteAll
		public int deleteAll(int frno);
		
		// 어제자 목록 가져오기
		public List<FreeAttachVO> yesterdayFiles();
}
