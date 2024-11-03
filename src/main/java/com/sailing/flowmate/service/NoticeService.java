package com.sailing.flowmate.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sailing.flowmate.dao.FilesDao;
import com.sailing.flowmate.dao.NoticeDao;
import com.sailing.flowmate.dto.FilesDto;
import com.sailing.flowmate.dto.NoticeDto;
import com.sailing.flowmate.dto.PagerDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NoticeService {

	@Autowired
	NoticeDao noticeDao;
	
	@Autowired
	FilesDao filesDao;
	
	@Transactional
	public void insertNotice(NoticeDto notice) {
		int noticeNewNo = noticeDao.selectNewNo();
		String noticeId = "PROJ-1-NTC-" + noticeNewNo;
		notice.setNoticeId(noticeId);
		noticeDao.insertNotice(notice);
	}

	public void insertNoticeAttach(FilesDto dbFiles) {
		filesDao.insertFiles(dbFiles);
	}
	
	public List<NoticeDto> getNoticeList(PagerDto pager) {
		List<NoticeDto> noticeList = noticeDao.getNoticeList(pager);
		return noticeList;
	}
	
	public NoticeDto getNotice(String noticeId) {
		NoticeDto notice = noticeDao.getNotice(noticeId);
		return notice;
	}

	public int getTotalRows() {
		int totalRows = noticeDao.getTotalRows();
		return totalRows;
	}

	public void updateNotice(NoticeDto notice) {
		noticeDao.updateNotice(notice);
	}

	public void enabledNotice(NoticeDto notice) {
		noticeDao.enabledNotice(notice);
	}

	public void addHitNum(String noticeId) {
		noticeDao.addHitNum(noticeId);
	}

	public List<NoticeDto> getNoticeFiles(String noticeId) {
		return noticeDao.getNoticeFiles(noticeId);
	}

	public NoticeDto getFile(String fileId) {
		return noticeDao.getFile(fileId);
	}

	public void updateNoticeAttach(NoticeDto notice) {
		noticeDao.updateNoticeAttach(notice);
	}

}
