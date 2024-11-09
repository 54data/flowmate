package com.sailing.flowmate.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sailing.flowmate.dto.MessageDto;
import com.sailing.flowmate.dto.PagerDto;

@Mapper
public interface MessageDao {


	int insertMsg(MessageDto msgDto);

	int selectNewNo();

	int selectUnreadMsgCnt(String memberId);

	List<MessageDto> selectMessageReceiveList(PagerDto pager);

	List<MessageDto> selectMessageContentList(String receiverId);

	int totalRows(String receiverId);



}
