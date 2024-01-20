package org.artauc.mapper;

import java.util.List;

import org.artauc.domain.ClassAttachVO;


public interface ClassAttachMapper {
	public int caDelete(String uuid);
	public void caDeleteAll(int cno);
	public void caInsert(ClassAttachVO cvo);
	public List<ClassAttachVO> caSelect(int cno);
	public List<ClassAttachVO> yesterdayFile();  //날짜 비교해서 폴더에서 지우는것
}
