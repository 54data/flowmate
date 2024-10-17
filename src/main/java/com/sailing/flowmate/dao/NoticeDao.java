package com.sailing.flowmate.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sailing.flowmate.dto.NoticeDto;

@Mapper
public interface NoticeDao {

	public List<NoticeDto> getAllNotices(String projectId);
}
