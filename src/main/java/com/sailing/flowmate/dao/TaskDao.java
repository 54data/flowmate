package com.sailing.flowmate.dao;

import org.apache.ibatis.annotations.Mapper;

import com.sailing.flowmate.dto.TaskDto;

@Mapper
public interface TaskDao {

	public int insertTask(TaskDto taskDto);

	public int insertTaskAttach(TaskDto taskDto);

	public int selectNewNo();
	
}
