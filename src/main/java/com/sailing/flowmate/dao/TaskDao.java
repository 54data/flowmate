package com.sailing.flowmate.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sailing.flowmate.dto.ProjectStepDto;
import com.sailing.flowmate.dto.TaskDto;

@Mapper
public interface TaskDao {

	public int insertTask(TaskDto taskDto);

	public int insertTaskAttach(TaskDto taskDto);

	public int selectNewNo();

	public List<ProjectStepDto> selectTaskModal(String projectId);

	public List<TaskDto> selectProjTask(String projectId);
	
}
