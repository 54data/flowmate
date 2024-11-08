package com.sailing.flowmate.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sailing.flowmate.dao.FilesDao;
import com.sailing.flowmate.dao.MessageDao;
import com.sailing.flowmate.dto.MessageDto;
import com.sailing.flowmate.soket.WebSocketHandler;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MessageService {

	@Autowired
	MessageDao messageDao;
	
	 @Autowired
	WebSocketHandler webSocketHandler;
	
	@Autowired
	FilesDao fileDao;
    @Transactional
    public int insertMessages(String senderId, List<String> memberIds, MessageDto msgDto)
    throws Exception{
        int messageNewNo = messageDao.selectNewNo();
        log.info("messageNewNo: " + messageNewNo);

        String msgId = "MSG-" + messageNewNo;
        msgDto.setMessageId(msgId);
        msgDto.setMessageSenderId(senderId);

        int insertedCount = 0;
        for (String receiverId : memberIds) {
            msgDto.setMessageReceiverId(receiverId);
            insertedCount += messageDao.insertMsg(msgDto); 
            
            // 수신자에게 실시간 알림 전송
            webSocketHandler.notifyUser(receiverId, null ,insertedCount);
        }
        
        return insertedCount;
    }
	
    public int insertMsgAttach(MessageDto msgDto) {
		return fileDao.insertMsgAttach(msgDto);	
	}

	public int selectCntUnReadMsg(String memberId) throws Exception{
		int unCnt = messageDao.selectUnreadMsgCnt(memberId);
        webSocketHandler.notifyUser(memberId, null ,unCnt);
		return unCnt;
	}




}
