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

import com.sailing.flowmate.dto.MemberDto;
import com.sailing.flowmate.dto.ProjectDto;
import com.sailing.flowmate.service.MemberService;
import com.sailing.flowmate.service.ProjectService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/project")
@Controller
public class ProjectController {
	@Autowired
	ProjectService projectService;
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping("/projectBoard")
	public String projectBoard() {
		return "project/projectBoard";
	}
	
	@GetMapping("/getMembers")
	public ResponseEntity<Map<String, Object>> getMembers() {
        List<MemberDto> members = memberService.getMembers();
        Map<String, Object> response = new HashMap<>();
        response.put("members", members);
		return ResponseEntity.ok(response);
	}
	
	@SuppressWarnings("unchecked")
	@PostMapping("/createProject")
	public ResponseEntity<String> createProject(@RequestBody Map<String, Object> projectData) {
		ProjectDto projectDto = new ProjectDto();
		//projectDto.setMemberId(authentication.getName());
		projectDto.setMemberId("kkk");		
		projectDto.setProjectName((String) projectData.get("projectName"));
		projectDto.setProjectStartDate((String) projectData.get("projectStartDate"));
		projectDto.setProjectDueDate((String) projectData.get("projectDueDate"));
		projectDto.setProjectContent((String) projectData.get("projectContent"));
		
		projectService.createProjectService(projectDto);
		projectService.addProjectMember(projectDto, (List<String>) projectData.get("projectMemberList"));
		projectService.createProjectStep(projectDto, (List<Map<String, String>>) projectData.get("projectStepList"));
		return ResponseEntity.ok("Success");
	}
	
	@RequestMapping("/projectMember")
	public String projectMember() {
		return "project/projectMember";
	}
	
	@RequestMapping("/projectIssue")
	public String projectIssue() {
		return "project/projectIssue";
	}
	
	@RequestMapping("/projectTask")
	public String projectTask() {
		return "project/projectTask";
	}
	
	@RequestMapping("/projectApprovalList")
	public String projectApprovalList() {
		return "project/projectApprovalList";
	}
	
	@RequestMapping("/projectApproval")
	public String projectApproval() {
		return "project/projectApproval";
	}
	
	@RequestMapping("/projectApprovalStay")//결재 대기-페이지 보기 위해 임시로 만들었습니다.
	public String projectApprovalStay() {
		return "project/projectApprovalStay";
	}
	
	@RequestMapping("/projectMemberManage")
	public String projectMemberManage() {
		return "project/projectMemberManage";
	}
}
