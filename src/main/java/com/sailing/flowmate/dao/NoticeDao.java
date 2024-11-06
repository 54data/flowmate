package com.sailing.flowmate.dao;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import com.sailing.flowmate.dto.NoticeDto;

@Mapper
public interface NoticeDao {

	public void insertNotice(NoticeDto notice);

	public void insertNoticeAttach(NoticeDto notice);

	/*public List<NoticeDto> getNoticeList(Map<String, Object> paramMap);*/
	
	public List<NoticeDto> getNoticeList(String projectId);

	public NoticeDto getNotice(String noticeId);

	public int getTotalRows();

	public void updateNotice(NoticeDto notice);

	public void enabledNotice(NoticeDto notice);

	public void addHitNum(String noticeId);

	public NoticeDto getFile(String fileId);

	public void updateNoticeAttach(NoticeDto notice);

	public int selectNewNo();

	

}
