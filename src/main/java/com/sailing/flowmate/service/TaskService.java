package com.sailing.flowmate.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sailing.flowmate.dao.TaskDao;
import com.sailing.flowmate.dto.TaskDto;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class TaskService {
	
	@Autowired
	TaskDao taskDao;

	@Transactional
	public int insertTask(TaskDto taskDto) {
		log.info("실행");
		int TaskNewNo = taskDao.selectNewNo();
		log.info("taskId"+TaskNewNo);
		taskDto.setProjectId("PROJ-8");
		String taskId = taskDto.getProjectId() +"-"+ "TASK-"+ TaskNewNo;
		taskDto.setTaskId(taskId);
		taskDto.setMemberId("gunn0128");
		taskDto.setTaskEnabled(true);
		log.info(taskDto.toString());
		
		return taskDao.insertTask(taskDto);
	}
	
	@Transactional
	public int insertTaskAttach(TaskDto taskDto) {
		log.info("실행");
		return taskDao.insertTaskAttach(taskDto);
	}
	
	
}
