package com.sailing.flowmate.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sailing.flowmate.dto.MessageDto;

@Mapper
public interface MessageDao {


	int insertMsg(MessageDto msgDto);

	int selectNewNo();

	int selectUnreadMsgCnt(String memberId);



}
