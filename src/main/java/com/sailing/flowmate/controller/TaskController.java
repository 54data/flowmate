package com.sailing.flowmate.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sailing.flowmate.dto.ProjectMemberDto;
import com.sailing.flowmate.dto.ProjectStepDto;
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
	public String createTask(TaskDto taskDTO, 
			@RequestParam(value = "taskAttach", required = false) MultipartFile[] taskAttach, 
			@RequestParam String projectId)
	throws Exception{
		
		log.info("작업추가 실행");
		log.info(taskDTO.toString());
		taskService.insertTask(taskDTO);
		taskDTO.setProjectId(projectId);
	    MultipartFile[] files = taskAttach;
	    if (files != null) {
	        for (MultipartFile file : files) {
	            if (!file.isEmpty()) {
	            	taskDTO.setFileName(file.getOriginalFilename());
	            	taskDTO.setFileType(file.getContentType());
	            	taskDTO.setFileData(file.getBytes());

	               
	                taskService.insertTaskAttach(taskDTO);
	            }
	        }
	    }
		//log.info("파일 확인: "+files.toString());

		
		return "redirect:/project/projectBoard?projectId=" + projectId;
	}
	
	@PostMapping("/taskUpdate")
	public String updateProjectTask(TaskDto taskDTO, 
			@RequestParam(value = "taskAttach", required = false) MultipartFile[] taskAttach, 
			@RequestParam String projectId)
	throws Exception{
		
		log.info("작업수정 실행");
		taskService.updateProjectTask(taskDTO);
		taskDTO.setProjectId(projectId);
		
	    /*MultipartFile[] files = taskAttach;
	    if (files != null) {
	        for (MultipartFile file : files) {
	            if (!file.isEmpty()) {
	            	taskDTO.setFileName(file.getOriginalFilename());
	            	taskDTO.setFileType(file.getContentType());
	            	taskDTO.setFileData(file.getBytes());

	               
	                taskService.insertTaskAttach(taskDTO);
	            }
	        }
	    }*/
		
		
		return "redirect:/project/projectBoard?projectId=" + projectId;
	}
	
	@PostMapping("/taskDisabled")
	public String disabledProjectTask(TaskDto taskDTO,  
			@RequestParam String projectId)
	throws Exception{
		
		log.info("작업추가 실행");
		taskService.disabledProjectTask(taskDTO);
		taskDTO.setProjectId(projectId);
			
		return "redirect:/project/projectBoard?projectId=" + projectId;
	}
	
	@GetMapping("/taskModalInfo")
	@ResponseBody
	public List<ProjectStepDto> getTaskModalInfo(
			@RequestParam String projectId){
		
		log.info("실행");
		List<ProjectStepDto> taskModalInfo = taskService.getTaskModalInfo(projectId);
		log.info(taskModalInfo.toString());
		return taskModalInfo;
	}
	
	@GetMapping("/getTaskMembers")
	@ResponseBody
	public List<ProjectMemberDto> getTaskMembers(@RequestParam String projectId){
		
		List<ProjectMemberDto> taskMembers = taskService.getTaskMemebers(projectId);
		log.info(taskMembers.toString());
		return taskMembers;
	}
	
	@GetMapping("/getTaskUpdateModalInfo")
	@ResponseBody
	public List<TaskDto> getTaskUpdateModalInfo(@RequestParam String projectId, TaskDto taskDto){
		taskDto.setProjectId(projectId);
		List<TaskDto> taskInfo = taskService.getTaskUpdateModalInfo(taskDto);
		log.info(taskInfo.toString());
		return taskInfo;
	}
	
	
}
