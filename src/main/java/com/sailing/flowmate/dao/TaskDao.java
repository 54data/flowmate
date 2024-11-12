package com.sailing.flowmate.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sailing.flowmate.dto.FilesDto;
import com.sailing.flowmate.dto.IssueDto;
import com.sailing.flowmate.dto.PagerDto;
import com.sailing.flowmate.dto.ProjectMemberDto;
import com.sailing.flowmate.dto.ProjectStepDto;
import com.sailing.flowmate.dto.TaskDto;

@Mapper
public interface TaskDao {

	public int insertTask(TaskDto taskDto);


	public int selectNewNo();

	public List<ProjectStepDto> selectTaskModal(String projectId);

	public List<TaskDto> selectProjTask(String projectId);

	public List<ProjectMemberDto> selectTaskMembers(String projectId);

	public TaskDto taskUpdateModalInfo(TaskDto taskDto);

	public int updateProjectTask(TaskDto taskDto);

	public int taskDisabledProjectTask(TaskDto taskDto);

	public int selectFmtTaskSeq(String projectId);

	
	public List<TaskDto> selectMyTaskList(String memberId);


	public List<TaskDto> selectMyTaskListForHome(String memberId);


	public List<TaskDto> selectMyDelayTask(String memberId);


	public void updateTaskStateToday();

	//public int getTotalRows(String projectId);
	
	public TaskDto getTaskByTaskId(String taskId);

	public void updateTaskState(Map<String, Object> params);


	public String selectCheckRole(String projectId);


	public List<TaskDto> selectDateSchduel(TaskDto taskDto);


}
