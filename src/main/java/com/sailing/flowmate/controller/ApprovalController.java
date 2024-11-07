package com.sailing.flowmate.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sailing.flowmate.dto.ApprovalDto;
import com.sailing.flowmate.dto.ProjectDto;
import com.sailing.flowmate.service.ApprovalService;
import com.sailing.flowmate.service.ProjectService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/approval")
@Controller
public class ApprovalController {

	@Autowired
	ApprovalService approvalService;

	@Autowired
	ProjectService projectService;
	
	@PostMapping("/insertAppr")
	public String insertAppr(
            @RequestParam("selectedStatus") String selectedStatus,
            @RequestParam("taskReqContent") String taskReqContent,
            @RequestParam("projectId") String projectId,
            @RequestParam("taskId") String taskId,
            Authentication authentication
		){
		
		String requester = authentication.getName();
		
		ProjectDto project = projectService.getProjectDetails(projectId);
		String responder = project.getMemberId();
		
		ApprovalDto apprData = new ApprovalDto();
		
		apprData.setProjectId(projectId);
		apprData.setTaskId(taskId);
		apprData.setRequesterId(requester);
		apprData.setResponderId(responder);
		apprData.setApprovalState(selectedStatus);
		apprData.setApprovalMessage(taskReqContent);
		
		approvalService.insertApprInfo(apprData);
		
		return "redirect:/project/projectBoard?projectId=" + projectId;
		
	}
}
