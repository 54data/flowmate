package com.sailing.flowmate.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sailing.flowmate.dao.FilesDao;
import com.sailing.flowmate.dao.TaskDao;
import com.sailing.flowmate.dto.FilesDto;
import com.sailing.flowmate.dto.IssueDto;
import com.sailing.flowmate.dto.ProjectMemberDto;
import com.sailing.flowmate.dto.ProjectStepDto;
import com.sailing.flowmate.dto.TaskDto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class TaskService {
	
	@Autowired
	TaskDao taskDao;
	@Autowired
	FilesDao fiiesDao;
	
	@Transactional
	public int insertTask(TaskDto taskDto) {
		log.info("실행");
		int TaskNewNo = taskDao.selectNewNo();
		log.info("taskId"+TaskNewNo);
		String taskId = taskDto.getProjectId() +"-"+ "TASK-"+ TaskNewNo;
		
		taskDto.setTaskId(taskId);
		taskDto.setTaskEnabled(true);
		log.info(taskDto.toString());
		
		return taskDao.insertTask(taskDto);
	}
	
	public String FmtTaskIdSet(TaskDto taskDTO) {
	    int fmtTaskSeq = taskDao.selectFmtTaskSeq(taskDTO.getProjectId());
	    String fmtTaskId = "TASK-" + (fmtTaskSeq + 1);
	    taskDTO.setFmtTaskId(fmtTaskId);
	    log.info("fmtTaskId: " + fmtTaskId);
	    return fmtTaskId;
	}
	
	@Transactional
	public int insertTaskAttach(TaskDto taskDto) {
		log.info("실행");
		return fiiesDao.insertTaskAttach(taskDto);
	}

	public List<ProjectStepDto> getTaskModalInfo(String projectId) {
		
		List<ProjectStepDto> taskModalInfo = taskDao.selectTaskModal(projectId); 
		
		return taskModalInfo;
	}

	public List<TaskDto> selectProjTask(String projectId) {
		List<TaskDto> projTaskList = taskDao.selectProjTask(projectId);
		return projTaskList;
	}

	public List<ProjectMemberDto> getTaskMemebers(String projectId) {
		List<ProjectMemberDto> taskMembers = taskDao.selectTaskMembers(projectId);
		return taskMembers;
	}

	public TaskDto getTaskUpdateModalInfo(TaskDto taskDto) {
		TaskDto taskInfo = taskDao.taskUpdateModalInfo(taskDto);
		return taskInfo;
	}

	public int updateProjectTask(TaskDto taskDto) {
		int taskUpdate = taskDao.updateProjectTask(taskDto);
		return taskUpdate;
	}

	public int disabledProjectTask(TaskDto taskDto) {
		int taskDisabled = taskDao.taskDisabledProjectTask(taskDto);
		
		return taskDisabled;
	}


	public List<FilesDto> getTaskAttachs(String relatedId) {
		
		return fiiesDao.selectTaskAttach(relatedId);
	}
	
	@Transactional
	public int deleteTaskAttach(String fileId) {
		return fiiesDao.deleteTaskAttach(fileId);
		
	}

	public List<TaskDto> getMyTaskList(String memberId) {
		
		return taskDao.selectMyTaskList(memberId);
	}

	public FilesDto downTaskFile(String fileId) {
		
		return  fiiesDao.downFile(fileId);
	}

	public List<TaskDto> getMyTaskListForHome(String memberId) {
		
		return taskDao.selectMyTaskListForHome(memberId);
	}

	public List<TaskDto> getMyDelayTask(String memberId) {
		
		return taskDao.selectMyDelayTask(memberId);
	}
	
	@Scheduled(cron = "0 0 0 * * ?")
	public void updateTaskStateToday() {
		taskDao.updateTaskStateToday();
	}

	public String selectCheckRole(String projectId) {
		
		return taskDao.selectCheckRole(projectId);
	}

	public List<TaskDto> getSelectDateSchduel(TaskDto taskDto) {
		return taskDao.selectDateSchduel(taskDto);
	}

}	
