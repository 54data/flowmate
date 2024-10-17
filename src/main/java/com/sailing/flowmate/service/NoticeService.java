package com.sailing.flowmate.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sailing.flowmate.dao.NoticeDao;
import com.sailing.flowmate.dto.NoticeDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class NoticeService {
	@Autowired
	private NoticeDao noticeDao;
	
	public List<NoticeDto> getAllNotices(String projectId) {
	
		List<NoticeDto> allNotices = noticeDao.getAllNotices(projectId);
	
		// TODO Auto-generated method stub
		return allNotices;
	}

}
