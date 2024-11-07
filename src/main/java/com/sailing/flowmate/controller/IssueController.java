package com.sailing.flowmate.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sailing.flowmate.dto.IssueDto;
import com.sailing.flowmate.dto.MemberDto;
import com.sailing.flowmate.dto.TaskDto;
import com.sailing.flowmate.service.IssueService;
import com.sailing.flowmate.service.ProjectService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/issue")
public class IssueController {
	@Autowired
	IssueService issueService;
	
	@Autowired
	ProjectService projectService;
	
	@GetMapping("/getIssuesMembers") 
	public ResponseEntity<Map<String, Object>> getIssuesMembers(@RequestParam String projectId) {
        List<MemberDto> members = issueService.getMembers(projectId);
        Map<String, Object> response = new HashMap<>();
        response.put("members", members);
		return ResponseEntity.ok(response);
	}
	
	@GetMapping("/getProjectTasks")
	public ResponseEntity<Map<String, Object>> getProjectTasks(@RequestParam String projectId) {
		List<TaskDto> projectTasks = projectService.getProjectTaskList(projectId);
		Map<String, Object> response = new HashMap<>();
		response.put("projectTasks", projectTasks);
		return ResponseEntity.ok(response);
	}
	
	@PostMapping("/createIssue")
	public ResponseEntity<String> createIssue (
			@RequestPart("issueData") IssueDto issueData,
			@RequestPart(value = "issueFiles", required = false) MultipartFile[] issueFiles) throws IOException {
		issueService.createNewIssue(issueData);
		String fmtIssueId = issueData.getFmtIssueId();
		String issueId = issueData.getIssueId();
		if (issueFiles != null) {
			issueService.addIssueFiles(issueId, issueFiles);
		}
		return ResponseEntity.ok(fmtIssueId);
	}
	
	@GetMapping("/getProjectIssues")
	public ResponseEntity<List<IssueDto>> getProjectIssues(@RequestParam String projectId) {
		List<IssueDto> projectIssueList = issueService.getProjectIssues(projectId);
		return ResponseEntity.ok(projectIssueList);
	}
	
	@GetMapping("/getProjectIssueCnt")
	@ResponseBody
	public double getProjectIssueCnt(@RequestParam String projectId) {
		double issueProgress = issueService.getIssueProgress(projectId);
		return issueProgress;
	}
}
