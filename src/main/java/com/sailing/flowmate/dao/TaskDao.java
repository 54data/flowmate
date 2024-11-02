package com.sailing.flowmate.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sailing.flowmate.dto.FilesDto;
import com.sailing.flowmate.dto.PagerDto;
import com.sailing.flowmate.dto.ProjectMemberDto;
import com.sailing.flowmate.dto.ProjectStepDto;
import com.sailing.flowmate.dto.TaskDto;

@Mapper
public interface TaskDao {

	public int insertTask(TaskDto taskDto);

	public int insertTaskAttach(TaskDto taskDto);

	public int selectNewNo();

	public List<ProjectStepDto> selectTaskModal(String projectId);

	public List<TaskDto> selectProjTask(String projectId);

	public List<ProjectMemberDto> selectTaskMembers(String projectId);

	public TaskDto taskUpdateModalInfo(TaskDto taskDto);

	public int updateProjectTask(TaskDto taskDto);

	public int taskDisabledProjectTask(TaskDto taskDto);

	public int selectFmtTaskSeq(String projectId);

	public List<FilesDto> selectTaskAttach(String relatedId);

	public int deleteTaskAttach(String fileId);

	//public int getTotalRows(String projectId);
	
}
