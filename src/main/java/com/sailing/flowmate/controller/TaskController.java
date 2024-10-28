package com.sailing.flowmate.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sailing.flowmate.dto.TaskCreatingForm;
import com.sailing.flowmate.dto.TaskDto;
import com.sailing.flowmate.service.TaskService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/task")
public class TaskController {
	
	@Autowired
	TaskService taskService;
	
	@PostMapping("/taskCreate")
	public String createTask(TaskCreatingForm taskCreate, @RequestParam(value = "taskAttach", required = false) MultipartFile[] taskAttach )
	throws Exception{
		log.info("작업추가 실행");
		TaskDto taskDto = new TaskDto();
		taskDto.setTaskName(taskCreate.getTaskName());
		taskDto.setTaskContent(taskCreate.getTaskContent());	
		taskDto.setTaskLog(taskCreate.getTaskLog());
		taskDto.setStepStartDate(taskCreate.getStepStartDate());
		taskDto.setStepDueDate(taskCreate.getStepDueDate());
		taskDto.setTaskPriority(taskCreate.getTaskPriority());

		taskService.insertTask(taskDto);
		
	    
	    MultipartFile[] files = taskAttach;
	    if (files != null) {
	        for (MultipartFile file : files) {
	            if (!file.isEmpty()) {
	                taskDto.setFileName(file.getOriginalFilename());
	                taskDto.setFileType(file.getContentType());
	                taskDto.setFileData(file.getBytes());

	               
	                taskService.insertTaskAttach(taskDto);
	            }
	        }
	    }
		//log.info("파일 확인: "+files.toString());

		
		log.info(taskCreate.toString());
		return "redirect:/project/projectBoard";
	}
}
