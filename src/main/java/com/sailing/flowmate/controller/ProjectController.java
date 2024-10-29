package com.sailing.flowmate.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

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
	
	@PostMapping("/createProject")
	public ResponseEntity<String> createProject(
			@RequestPart("projectData") ProjectDto projectData,
			@RequestPart("projectMemberList") List<String> projectMemberList,
			@RequestPart("projectStepList") List<Map<String, String>> projectStepList,
			@RequestPart("projectFiles") MultipartFile[] projectFiles,
			Authentication authentication
			) throws IOException {
		projectData.setMemberId(authentication.getName());
		projectService.createProjectService(projectData);
		String projectId = projectData.getProjectId();
		
		projectService.addProjectMember(projectId, projectMemberList);
		projectService.createProjectStep(projectId, projectStepList);
		projectService.addProjectFiles(projectId, projectFiles);
		System.out.println("File name: " + projectFiles[0].getOriginalFilename() + ", Size: " + projectFiles[0].getSize());
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
