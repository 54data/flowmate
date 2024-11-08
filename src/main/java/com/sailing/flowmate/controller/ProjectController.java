package com.sailing.flowmate.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import com.sailing.flowmate.dto.ApprovalDto;
import com.sailing.flowmate.dto.FilesDto;
import com.sailing.flowmate.dto.MemberDto;
import com.sailing.flowmate.dto.ProjectDto;
import com.sailing.flowmate.dto.ProjectStepDto;
import com.sailing.flowmate.dto.TaskDto;
import com.sailing.flowmate.service.ApprovalService;
import com.sailing.flowmate.service.MemberService;
import com.sailing.flowmate.service.ProjectService;
import com.sailing.flowmate.service.TaskService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/project")
@Controller
@Secured("ROLE_DEV")
public class ProjectController {
	@Autowired
	ProjectService projectService;
	
	@Autowired
	TaskService taskService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	ApprovalService approvalService;
	
	@GetMapping("/projectBoard")
	public String projectBoard(String projectId, Model model, HttpSession session) throws ParseException {
		ProjectDto projectData = projectService.getProjectDetails(projectId); 
		List<ProjectStepDto> projectStepList = projectService.getProjectStepList(projectId);
		List<ProjectStepDto> projectStepTaskCntList = projectService.getProjectStepTaskCntList(projectId);
		List<TaskDto> projectTaskList = projectService.getProjectTaskList(projectId);
		session.setAttribute("projectId", projectId);
		session.setAttribute("projectData", projectData);
		
		for (ProjectStepDto projectStep : projectStepList) {
			boolean stepTaskStatus = false;
			for (ProjectStepDto projectStepCnt : projectStepTaskCntList) {
				if (projectStep.getStepId().equals(projectStepCnt.getStepId())) {
					projectStep.setTotalStepTaskCnt(projectStepCnt.getTotalStepTaskCnt());
					projectStep.setStepProgress(projectStepCnt.getStepProgress());
					stepTaskStatus = true; 
		            break;
				}
			}
		    if (!stepTaskStatus) {
		        projectStep.setTotalStepTaskCnt(0);
		        projectStep.setStepProgress(0.0);
		    }
		}
		
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		Date projectDueDate = sdf.parse(projectData.getProjectDueDate());
		long projectDateRange = (projectDueDate.getTime() - now.getTime()) / (1000 * 60 * 60 * 24);
		String dateRange = "";
		
		if (projectDateRange < 0) {
		    dateRange = "+ " + Long.toString(-projectDateRange);
		} else {
		    dateRange = "- " + Long.toString(projectDateRange);
		}
		
		ProjectDto projectTaskCnt = projectService.getProjectTaskCnt(projectId);
		model.addAttribute("projectTaskCnt", projectTaskCnt);
		model.addAttribute("projectDateRange", dateRange);
		model.addAttribute("projectData", projectData);
		model.addAttribute("projectStepList", projectStepList);
		model.addAttribute("projectTaskList", projectTaskList);
		return "project/projectBoard";
	}
	
	@GetMapping("/getProjectMembers")
	public ResponseEntity<List<String>> getProjectMembers(@RequestParam String projectId, Authentication authentication) {
		String memberId = authentication.getName();
		List<String> projectMemberList = projectService.getProjectMemberList(projectId, memberId);
		return ResponseEntity.ok(projectMemberList);
	}
	
	@GetMapping("/getProjectSteps")
	public ResponseEntity<List<ProjectStepDto>> getProjectSteps(@RequestParam String projectId) {
		List<ProjectStepDto> projectStepList = projectService.getProjectStepList(projectId);
		return ResponseEntity.ok(projectStepList);
	}	
	
	@GetMapping("/getProjectFiles")
	public ResponseEntity<List<FilesDto>> getProjectFiles(@RequestParam String projectId) {
		List<FilesDto> projectFileList = projectService.getProjectFileList(projectId);
		return ResponseEntity.ok(projectFileList);
	}

	@GetMapping("/getMembers")
	public ResponseEntity<Map<String, Object>> getMembers(Authentication authentication) {
		String memberId = authentication.getName();
        List<MemberDto> members = memberService.getActiveMembers(memberId);
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
	
	@PostMapping("updateProjectNewFiles")
	public ResponseEntity<String> updateProjectNewFiles(
			@RequestPart("projectId") String projectId, 
			@RequestPart(value = "deleteFileList", required = false) List<String> deleteFileList,
			@RequestPart(value = "projectNewFiles", required = false) MultipartFile[] projectNewFiles) throws IOException {
		if (deleteFileList != null) {
			projectService.deleteProjectFileList(projectId, deleteFileList);
		}
		if (projectNewFiles != null) {
			projectService.addProjectFiles(projectId, projectNewFiles);
		}
		return ResponseEntity.ok(projectId);
	}
	
	@PostMapping("updateProjectNewMembers")
	public ResponseEntity<String> updateProjectNewMembers(
			@RequestPart("projectId") String projectId, 
			@RequestPart("projectMemberList") List<String> projectMemberList,
			Authentication authentication) {
		String memberId = authentication.getName();
		projectService.updateProjectMemberList(projectId, projectMemberList, memberId);
		return ResponseEntity.ok(projectId);
	}
	
	@PostMapping("updateProjectNewSteps")
	public ResponseEntity<String> updateProjectNewSteps(
			@RequestPart("projectId") String projectId, 
			@RequestPart("projectStepList") List<Map<String, String>> projectStepList,
			Authentication authentication) {
		String memberId = authentication.getName();
		projectService.updateProjectStepList(projectId, projectStepList, memberId);
		return ResponseEntity.ok(projectId);
	}
	
	@PostMapping("updateProjectNewData")
	public ResponseEntity<String> updateProjectNewData(
			@RequestPart("projectId") String projectId, 
			@RequestPart("projectData") ProjectDto projectData,
			Authentication authentication) {
		String memberId = authentication.getName();
		projectData.setProjectId(projectId);
		projectData.setProjectUpdateMid(memberId);
		projectService.updateProjectData(projectData);
		return ResponseEntity.ok(projectId);
	}
	
	@PostMapping("updateProjectDeactivated")
	public ResponseEntity<String> updateProjectDeactivated(@RequestParam String projectId, Authentication authentication) {
		String projectUpdateMid = authentication.getName();
		projectService.updateProjectEnabled(projectId, projectUpdateMid);
		return ResponseEntity.ok("Success");
	}
	
	@GetMapping("/downloadFile")
	public void downloadFile(@RequestParam("fileId") String fileId, HttpServletResponse response) throws Exception {
	    FilesDto file = projectService.getProjectFile(fileId);
	    
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
	
	@RequestMapping("/projectMember")
	public String projectMember() {
		return "project/projectMember";
	}
	
	@RequestMapping("/projectIssue")
	public String projectIssue() {
		return "project/projectIssue";
	}
	
	@RequestMapping("/projectTask")
	public String projectTask(@RequestParam String projectId, Model model) {
		List<TaskDto> projTask = taskService.selectProjTask(projectId);
		model.addAttribute("projTask", projTask);
		return "project/projectTask";
	}
	
	@RequestMapping("/projectApprovalList")
	public String projectApprovalList(@RequestParam("projectId")String projectId, Model model) {
		List<ApprovalDto> apprList = approvalService.getApprovals(projectId);
		
		for(ApprovalDto appr : apprList) {
			//멤버 이름 set
			String requesterName = memberService.getMember(appr.getRequesterId()).getMemberName();
			appr.setRequesterName(requesterName);
			//taskId에 따른 task 객체
			TaskDto taskByAppr = approvalService.getTaskInfoByAppr(appr.getTaskId());
			//작업명
			appr.setTaskName(taskByAppr.getTaskName());
			//요청 단계
			appr.setStepName(taskByAppr.getStepName());
			//현 상태
			appr.setCurrentState(taskByAppr.getTaskState());
			
			if(appr.getApprovalResponseResult() == null) {
				appr.setApprovalResponseResult("대기");
			}
		}
		model.addAttribute("apprList", apprList);
		
		return "project/projectApprovalList";
	}
	
	@GetMapping("/projectApprovalStay")
	public String projectApprovalStay(@RequestParam("projectId")String projectId, Model model){
		List<ApprovalDto> apprList = approvalService.getWaitingApprovals(projectId);
		
		for(ApprovalDto appr : apprList) {
			//멤버 이름 set
			String requesterName = memberService.getMember(appr.getRequesterId()).getMemberName();
			appr.setRequesterName(requesterName);
			//taskId에 따른 task 객체
			TaskDto taskByAppr = approvalService.getTaskInfoByAppr(appr.getTaskId());
			//작업명
			appr.setTaskName(taskByAppr.getTaskName());
			//요청 단계
			appr.setStepName(taskByAppr.getStepName());
			//현 상태
			appr.setCurrentState(taskByAppr.getTaskState());
		}
		if(!apprList.isEmpty()){
			model.addAttribute("apprList", apprList);
		}
		return "project/projectApprovalStay";
	}

	@RequestMapping("/projectMemberManage")
	public String projectMemberManage() {
		return "project/projectMemberManage";
	}
}
