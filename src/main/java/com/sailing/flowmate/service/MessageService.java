package com.sailing.flowmate.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sailing.flowmate.dao.FilesDao;
import com.sailing.flowmate.dao.MessageDao;
import com.sailing.flowmate.dto.FilesDto;
import com.sailing.flowmate.dto.MessageDto;
import com.sailing.flowmate.dto.PagerDto;
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

	public List<MessageDto> selectMessageReceiveList(PagerDto pager) {
		List<MessageDto> msgReciveList = messageDao.selectMessageReceiveList(pager);
		return msgReciveList;
	}

	public List<MessageDto> selectReceieveMessageContentList(String receiverId) {
		List<MessageDto> msgReceieveContentList = messageDao.selectReceieveMessageContentList(receiverId);
		return msgReceieveContentList;
	}

	public int getReceieveTotalRows(String receiverId) {
		
		return messageDao.totalRecieveRows(receiverId);
	}

	public List<MessageDto> selectMessageSentList(PagerDto pager) {
		List<MessageDto> msgSentList = messageDao.selectMessageSentList(pager);
		return msgSentList;
	}

	public int getSentTotalRows(String senderId) {
		return messageDao.totalSentRows(senderId);
	}

	public List<MessageDto> selectSentMessageContentList(String senderId) {
		List<MessageDto> msgSentContentList = messageDao.selectSentMessageContentList(senderId);		
		return msgSentContentList;
	}

	public int getSearchTotalRows(PagerDto pager) {
		
		return messageDao.searchTotalRows(pager);
	}

	public List<MessageDto> searchMessages(PagerDto pager) {
		return messageDao.selectSearchMessgaes(pager);
	}

	public List<MessageDto> searchContentList(PagerDto pager) {
		return messageDao.selectSearchContentList(pager);
	}

	public MessageDto getMessageDetail(String messageId) {

		return messageDao.selectMessageDetail(messageId);
	}

	public String getMessageContent(String messageId) {

		return messageDao.selectMessageContentDetail(messageId);
	}

	public List<MessageDto> getDetailReceiver(String messageId) {
		return messageDao.selectMessageReceiver(messageId);
	}

	public int updateMsgReadDate(MessageDto msgDto) {
		return messageDao.updateMsgReadDate(msgDto);
	}

	public List<MessageDto> selectHomeMessge(String receiverId) {
		return messageDao.selectHomeMessge(receiverId);
	}

	public int updateReciverEnable(MessageDto msgDto) {

	    String[] messageIdArray = msgDto.getMessageId().split(",");
	    int updatedReceiveRows = 0;
	    for(String msgId : messageIdArray ) {
	    		msgDto.setMessageId(msgId);
	    		updatedReceiveRows += messageDao.updateReciverEnabled(msgDto);
	    }
	    
	    return updatedReceiveRows;
	    
	}

	public int updateSenderEnable(MessageDto msgDto) {

	    String[] messageIdArray = msgDto.getMessageId().split(",");
	    int updatedSendRows = 0;
	    for(String msgId : messageIdArray ) {
	    		msgDto.setMessageId(msgId);
	    		updatedSendRows += messageDao.updateSenderEnabled(msgDto);
	    }
	    
	    return updatedSendRows;
	    
		
	}

	public int deleteMsg() {
		
		return messageDao.deleteMsg();
	}

	public List<FilesDto> getMsgFiles(String messageId) {

		return fileDao.getMsgFiles(messageId);
	}

	public FilesDto downMagFile(String fileId) {
		return fileDao.downFile(fileId);
	}




}
