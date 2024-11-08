package com.sailing.flowmate.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sailing.flowmate.dto.ApprovalDto;
import com.sailing.flowmate.dto.ProjectDto;
import com.sailing.flowmate.service.ApprovalService;
import com.sailing.flowmate.service.MemberService;
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
	
	@Autowired
	MemberService memberService;
	
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
	
	@PostMapping("/updateApprRespResult")
	public String updateApprRespResult(
			@RequestParam("projectId") String projectId,
            @RequestParam("approvalId") String approvalId,
            @RequestParam("approvalResponseResult") String approvalResponseResult			
	) {
		
		Map<String, Object> params = new HashMap<>();
		params.put("approvalId", approvalId);
		params.put("approvalResponseResult", approvalResponseResult);

		approvalService.updateApprResp(params);
		
		return "redirect:/project/projectApprovalStay?projectId=" + projectId;
	}
	
	@GetMapping("/isApprRequested")
	@ResponseBody
	public boolean isApprRequested(@RequestParam("taskId") String taskId) {
		return approvalService.chkApprRequested(taskId); //true 아직 요청안한것
	}
	
	@PostMapping("/updateTask")
	public String updateTaskState(
            @RequestParam("projectId") String projectId,
            @RequestParam("approvalId") String approvalId,
            Authentication authentication
	) {
		log.info("task 상태 변경 시작");
		String memberId = authentication.getName();
		
		Map<String, Object> params = new HashMap<>();
				
		ApprovalDto appr = approvalService.getApprById(approvalId);
		String selectedStatus = appr.getApprovalState();
		String taskId = appr.getTaskId();
		log.info("변경한 상태 : " + selectedStatus);
		
		params.put("selectedStatus", selectedStatus);
		params.put("taskId", taskId);
		params.put("memberId", memberId);
		
		approvalService.updateTaskState(params);
		
		return "redirect:/project/projectApprovalStay?projectId=" + projectId;
	}
}
