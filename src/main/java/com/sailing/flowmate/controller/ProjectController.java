package com.sailing.flowmate.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import com.sailing.flowmate.dto.MemberDto;
import com.sailing.flowmate.dto.ProjectDto;
import com.sailing.flowmate.dto.ProjectStepDto;
import com.sailing.flowmate.dto.TaskDto;
import com.sailing.flowmate.service.MemberService;
import com.sailing.flowmate.service.ProjectService;
import com.sailing.flowmate.service.TaskService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/project")
@Controller
public class ProjectController {
	@Autowired
	ProjectService projectService;
	
	@Autowired
	TaskService taskService;
	
	@Autowired
	MemberService memberService;
	
	@GetMapping("/projectBoard")
	public String projectBoard(String projectId, Model model) throws ParseException {
		ProjectDto projectData = projectService.getProjectDetails(projectId); 
		List<ProjectStepDto> projectStepList = projectService.getProjectStepList(projectId);

		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		Date projectDueDate = sdf.parse(projectData.getProjectDueDate());
		long projectDateRange = (projectDueDate.getTime() - now.getTime()) / (1000 * 60 * 60 * 24);
		String dateRange = "";
		
		if (projectDateRange < 0) {
		    dateRange = "+" + Long.toString(-projectDateRange);
		} else {
		    dateRange = "-" + Long.toString(projectDateRange);
		}
		
		model.addAttribute("projectId", projectId);
		model.addAttribute("projectDateRange", dateRange);
		model.addAttribute("projectData", projectData);
		model.addAttribute("projectStepList", projectStepList);
		return "project/projectBoard";
	}
	
	@GetMapping("/getMembers")
	public ResponseEntity<Map<String, Object>> getMembers(Authentication authentication) {
		String memberId = authentication.getName();
        List<MemberDto> members = memberService.getMembers(memberId);
        Map<String, Object> response = new HashMap<>();
        response.put("members", members);
		return ResponseEntity.ok(response);
	}
	
	@PostMapping("/createProject")
	public ResponseEntity<String> createProject(
			@RequestPart("projectData") ProjectDto projectData,
			@RequestPart("projectMemberList") List<String> projectMemberList,
			@RequestPart("projectStepList") List<Map<String, String>> projectStepList,
			@RequestPart(value = "projectFiles", required = false) MultipartFile[] projectFiles,
			Authentication authentication
			) throws IOException {
		projectData.setMemberId(authentication.getName());
		projectService.createProjectService(projectData);
		String projectId = projectData.getProjectId();
		projectMemberList.add(authentication.getName());
		projectService.addProjectMember(projectId, projectMemberList);
		projectService.createProjectStep(projectId, projectStepList);
		if (projectFiles != null) {
			projectService.addProjectFiles(projectId, projectFiles);
		}
		return ResponseEntity.ok(projectId);
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
	public String projectTask(@RequestParam(defaultValue="PROJ-8") String projectId, Model model) {
		List<TaskDto> projTask = taskService.selectProjTask(projectId);
		model.addAttribute("projTask", projTask);
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
