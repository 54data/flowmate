package com.sailing.flowmate.dao;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import com.sailing.flowmate.dto.NoticeDto;
import com.sailing.flowmate.dto.PagerDto;

@Mapper
public interface NoticeDao {

	public void insertNotice(NoticeDto notice);

	public void insertNoticeAttach(NoticeDto notice);

	public List<NoticeDto> getNoticeList(PagerDto pager);

	public NoticeDto getNotice(String noticeId);

	public int getTotalRows();

	public void updateNotice(NoticeDto notice);

	public void enabledNotice(NoticeDto notice);

	public void addHitNum(String noticeId);

	public List<NoticeDto> getNoticeFiles(String noticeId);

	public NoticeDto getFile(String fileId);

}
