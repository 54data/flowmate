package com.sailing.flowmate.soket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;


@Component
@Slf4j
@RequestMapping("/ws")
public class WebSocketHandler extends TextWebSocketHandler {
	

	//로그인한 인원 전체
	private static List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	
	private final ObjectMapper objectMapper = new ObjectMapper(); //Java 객체를 JSON으로 직렬화
	
	
	// 사용자 ID와 WebSocket 세션을 매핑
	private Map<String, WebSocketSession> userSessionMap = new ConcurrentHashMap<>();
	
	private Map<String, Integer> alarmCount = new ConcurrentHashMap<String, Integer>();

	
	// WebSocket 세션 연결 시 호출
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

        String userId = session.getPrincipal().getName();
        userSessionMap.put(userId, session);
        sessions.add(session); // 로그인한 세션을 리스트에 추가
        log.info("소켓 연결됨 누구여: " + userId);
		
	}
	
	//알림 전송 메서드
	public void notifyUser(String userId, String message, int unReadMsgCnt) throws Exception {
	    WebSocketSession session = userSessionMap.get(userId); // userSessionMap에서 사용자 세션 검색
	    if (session != null && session.isOpen()) {
	    	
	    	 		Map<String, Object> msgSocket = new HashMap<>();
	    	 		msgSocket.put("type", "NEW_MESSAGE"); 
	    	 		msgSocket.put("message", message);
	    	 		msgSocket.put("unReadCount", unReadMsgCnt);
	    	 		log.info("안읽은 수: " + unReadMsgCnt);
	            String msg = objectMapper.writeValueAsString(msgSocket); // JSON 형식의 메시지 전송
	            session.sendMessage(new TextMessage(msg));
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
        log.info("소켓 종료 누구여: " + userId);
	}

	
	
	
	
}
