package com.sailing.flowmate.controller;

import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sailing.flowmate.dto.FilesDto;
import com.sailing.flowmate.dto.IssueDto;
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
		taskService.FmtTaskIdSet(taskDTO);
		log.info(taskDTO.getFmtTaskId());
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
			@RequestParam(value = "removeFiles", required = false) String[] removeFileArray,
			@RequestParam String projectId)
	throws Exception{
		
		log.info("작업수정 실행");
		taskService.updateProjectTask(taskDTO);
		taskDTO.setProjectId(projectId);
		
	    MultipartFile[] files = taskAttach;

	    String[] removeFiles = removeFileArray;
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
	    
	   
	    // 파일 삭제 처리
	    if (removeFiles != null) {
	        for (String fileId : removeFiles) {
	            // 삭제할 파일 ID로 서비스 호출
	            taskService.deleteTaskAttach(fileId);
	        }
	    }
		
		
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
	public Map<String, Object> getTaskUpdateModalInfo(@RequestParam String projectId, TaskDto taskDto, 
			FilesDto filesDto,
			Authentication authentication
			){
		taskDto.setProjectId(projectId);
		TaskDto taskInfo = taskService.getTaskUpdateModalInfo(taskDto);
		filesDto.setFileId(taskDto.getTaskId());
		String relatedId = filesDto.getFileId();
		List<FilesDto> taskAttachList = taskService.getTaskAttachs(relatedId);
		List<ProjectMemberDto> taskMembers = taskService.getTaskMemebers(projectId);
		String memberRole = authentication.getAuthorities().toString();

		
	    Map<String, Object> response = new HashMap<>();
	    
	    log.info(taskInfo.toString());

	    response.put("loginMemberRole", memberRole);
	    response.put("taskInfo", taskInfo);
	    response.put("taskAttachList", taskAttachList);
	    response.put("taskMembers", taskMembers);
		return response;
	}
	
	@GetMapping("/downloadFile")
	public void downloadFile(@RequestParam("fileId")String fileId, HttpServletResponse response) throws Exception {
		FilesDto file = taskService.downTaskFile(fileId);
	    
	    String contentType = file.getFileType();
	    response.setContentType(contentType);
	    
	    String fileName = file.getFileName();
	    String encodingFileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
	    response.setHeader("Content-Disposition", "attachment; filename=\"" + encodingFileName + "\"");
	
		OutputStream out = response.getOutputStream();
		out.write(file.getFileData());
		out.flush();
		out.close();
	}
}
