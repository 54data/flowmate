package com.sailing.flowmate.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	@ResponseBody
	public String createIssue (@RequestBody IssueDto issue) {
		String fmtIssueId = issueService.createNewIssue(issue);
		return fmtIssueId;
	}
}
