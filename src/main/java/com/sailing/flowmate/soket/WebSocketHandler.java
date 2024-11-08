package com.sailing.flowmate.soket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sailing.flowmate.service.MessageService;

import lombok.extern.slf4j.Slf4j;


@Repository
@Slf4j
@RequestMapping("/ws")
public class WebSocketHandler extends TextWebSocketHandler {
	
	@Autowired
	MessageService messageService;
	
	//로그인한 인원 전체
	private static List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	
	private final ObjectMapper objectMapper = new ObjectMapper(); //Java 객체를 JSON으로 직렬화
	
	
	// 사용자 ID와 WebSocket 세션을 매핑
	private Map<String, WebSocketSession> userSessionMap = new ConcurrentHashMap<>();
	
	private Map<String, Integer> alarmCount = new ConcurrentHashMap<String, Integer>();

	
	// WebSocket 세션 연결 시 호출
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		

	    String userId = (session.getPrincipal() != null) ? session.getPrincipal().getName() : session.getId();

	    userSessionMap.put(userId, session);
	    sessions.add(session);

	    log.info("새로운 세션이 연결되었습니다. 사용자 ID: " + userId + ", 세션 ID: " + session.getId()); // 로그인한 세션을 리스트에 추가

		
	}
	
	public void logConnectedUsers() {
	    // 연결된 모든 사용자 ID를 가져와 로그에 출력
	    List<String> connectedUsers = new ArrayList<>(userSessionMap.keySet());
	    log.info("현재 연결된 사용자 수: " + connectedUsers.size());
	    log.info("연결된 사용자 목록: " + connectedUsers);
	}
	
	
	//알림 전송 메서드
	public void notifyUser(String userId, String message, int unReadMsgCnt) throws Exception {
	    WebSocketSession session = userSessionMap.get(userId); // userSessionMap에서 사용자 세션 검색
	    if (session != null && session.isOpen()) {
	    	
	    	 		Map<String, Object> msgSocket = new HashMap<>();
	    	 		msgSocket.put("type", "NEW_MESSAGE"); 
	    	 		msgSocket.put("message", message);
	    	 		msgSocket.put("unReadCount", unReadMsgCnt);
	            String msg = objectMapper.writeValueAsString(msgSocket); // JSON 형식의 메시지 전송
	            session.sendMessage(new TextMessage(msg));
	    }
	}
	
	@Override
	public void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
	    String payload = message.getPayload();
	    JSONObject json = new JSONObject(payload);

	    if ("REQUEST_UNREAD_COUNT".equals(json.getString("type"))) {
	        // DB에서 읽지 않은 메시지 수 조회
	    		String userId = session.getPrincipal().getName();
	    	
	        int unreadCount = messageService.selectCntUnReadMsg(userId);

	        // 클라이언트로 응답 전송
	        Map<String, Object> response = new HashMap<>();
	        response.put("type", "NEW_MESSAGE");
	        response.put("unReadCount", unreadCount);
	        session.sendMessage(new TextMessage(new ObjectMapper().writeValueAsString(response)));
	    }
	}

	
	
	public void sendMessgeToUser(String userId, String message) throws Exception{
			WebSocketSession session = userSessionMap.get(userId);
			TextMessage  msg =  new TextMessage(message);
			if(session != null && session.isOpen()) {
				session.sendMessage(msg);
			}
	}


    public void sendMessageToAll(String message) throws Exception {
        for (WebSocketSession session : sessions) {
            if (session.isOpen()) {
                session.sendMessage(new TextMessage(message));
            }
        }
    }
	

    
    
	@Override
	// WebSocket 세션이 종료될 때 호출
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String userId = session.getPrincipal().getName();
        userSessionMap.remove(userId);
        sessions.remove(session); // 세션 종료 시 리스트에서 제거
	}

	
	
	
	
}
