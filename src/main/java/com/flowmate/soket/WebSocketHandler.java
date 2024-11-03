package com.flowmate.soket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sailing.flowmate.dao.MemberDao;
import com.sailing.flowmate.dao.NoticeDao;
import com.sailing.flowmate.dao.ProjectDao;
import com.sailing.flowmate.dao.TaskDao;

import lombok.extern.slf4j.Slf4j;


@Component
@RequestMapping("/header")
@Slf4j
public class WebSocketHandler extends TextWebSocketHandler {
	
	private final ObjectMapper objectMapper = new ObjectMapper(); //Java 객체를 JSON으로 직렬화
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private ProjectDao projectDao;
	
	@Autowired
	private NoticeDao noticeDao;
	
	@Autowired
	private TaskDao taskDao;
	

	
}
