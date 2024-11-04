package com.sailing.flowmate.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sailing.flowmate.dao.FilesDao;
import com.sailing.flowmate.dao.NoticeDao;
import com.sailing.flowmate.dto.FilesDto;
import com.sailing.flowmate.dto.NoticeDto;

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
	
	public List<NoticeDto> getNoticeList(Map<String, Object> paramMap) {
		List<NoticeDto> noticeList = noticeDao.getNoticeList(paramMap);
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

	public List<FilesDto> getNoticeFiles(String noticeId) {
		return filesDao.getNoticeFiles(noticeId);
	}

	public NoticeDto getFile(String fileId) {
		return noticeDao.getFile(fileId);
	}

	public void updateNoticeAttach(NoticeDto notice) {
		noticeDao.updateNoticeAttach(notice);
	}
	
	public void deleteAttaches(String fileId){
		filesDao.deleteTaskAttach(fileId);
	}

}
