package com.flowmate.soket;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sailing.flowmate.dao.MemberDao;
import com.sailing.flowmate.dao.MessageDao;
import com.sailing.flowmate.dao.NoticeDao;
import com.sailing.flowmate.dao.ProjectDao;
import com.sailing.flowmate.dao.TaskDao;

import lombok.extern.slf4j.Slf4j;


@Component
@RequestMapping("/header")
@Slf4j
public class WebSocketHandler extends TextWebSocketHandler {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private ProjectDao projectDao;
	
	@Autowired
	private NoticeDao noticeDao;
	
	@Autowired
	private TaskDao taskDao;
	
	@Autowired
	private MessageDao messageDao;
	
	private final ObjectMapper objectMapper = new ObjectMapper(); //Java 객체를 JSON으로 직렬화
	
	
	// 사용자 ID와 WebSocket 세션을 매핑
	private Map<String, WebSocketSession> userSessionMap = new ConcurrentHashMap<>();
	
	// WebSocket 세션 연결 시 호출
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		String userId = session.getPrincipal().getName();
		userSessionMap.put(userId, session);
		log.info("소켓연결됨 누구여: " + userId);
		
	}
	
	@Override
	// WebSocket 세션이 종료될 때 호출
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String userId = session.getPrincipal().getName();
		userSessionMap.remove(userId);
		log.info("소켓 종료 누구여: " + userId);
	}
	
	
	
}
