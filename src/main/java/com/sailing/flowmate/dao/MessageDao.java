package com.sailing.flowmate.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sailing.flowmate.dto.MessageDto;
import com.sailing.flowmate.dto.PagerDto;

@Mapper
public interface MessageDao {


	int insertMsg(MessageDto msgDto);

	int selectNewNo();

	int selectUnreadMsgCnt(String memberId);

	List<MessageDto> selectMessageReceiveList(PagerDto pager);

	List<MessageDto> selectReceieveMessageContentList(String receiverId);
	
	List<MessageDto> selectSentMessageContentList(String senderId);

	int totalRecieveRows(String receiverId);

	List<MessageDto> selectMessageSentList(PagerDto pager);

	int totalSentRows(String senderId);

	int searchTotalRows(PagerDto pager);

	List<MessageDto> selectSearchMessgaes(PagerDto pager);

	List<MessageDto> selectSearchContentList(PagerDto pager);

	MessageDto selectMessageDetail(String messageId);

	String selectMessageContentDetail(String messageId);

	List<MessageDto> selectMessageReceiver(String messageId);





}
