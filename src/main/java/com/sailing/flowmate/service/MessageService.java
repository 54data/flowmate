package com.sailing.flowmate.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sailing.flowmate.dao.FilesDao;
import com.sailing.flowmate.dao.MessageDao;
import com.sailing.flowmate.dto.MessageDto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MessageService {

	@Autowired
	MessageDao messageDao;
	
	@Autowired
	FilesDao fileDao;
    @Transactional
    public int insertMessages(String senderId, List<String> memberIds, MessageDto msgDto) {
        int messageNewNo = messageDao.selectNewNo();
        log.info("messageNewNo: " + messageNewNo);

        String msgId = "MSG-" + messageNewNo;
        msgDto.setMessageId(msgId);
        msgDto.setMessageSenderId(senderId);

        int insertedCount = 0;
        for (String receiverId : memberIds) {
            msgDto.setMessageReceiverId(receiverId);
            insertedCount += messageDao.insertMsg(msgDto); 
        }
        
        return insertedCount;
    }
	
	public int insertMsgAttach(MessageDto msgDto) {
		return fileDao.insertMsgAttach(msgDto);	
	}
	



}
