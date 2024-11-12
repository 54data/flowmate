package com.sailing.flowmate.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sailing.flowmate.dto.FilesDto;
import com.sailing.flowmate.dto.IssueCommentDto;
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
	
	@GetMapping("/getIssueList")
	public ResponseEntity<List<IssueDto>> getIssueList(@RequestParam String projectId, @RequestParam(required = false) String taskId) {
		List<IssueDto> projectIssueList;
		if (taskId == null) {
			projectIssueList = issueService.getProjectIssues(projectId);
		} else {
			projectIssueList = issueService.getTaskIssues(taskId);
		}
		return ResponseEntity.ok(projectIssueList);
	}
	
	@GetMapping("/getIssueCnt")
	@ResponseBody
	public double getIssueCnt(@RequestParam String projectId, @RequestParam(required = false) String taskId) {
		double issueProgress;
		if (taskId == null) {
			issueProgress = issueService.getProjectIssueProgress(projectId);
		} else {
			issueProgress = issueService.getTaskIssueProgress(taskId);
		}
		return issueProgress;
	}
	
	@GetMapping("/getIssue")
	@ResponseBody
	public IssueDto getIssue(@RequestParam String issueId) {
		IssueDto issueDto = issueService.getIssueData(issueId);
		return issueDto;
	}
	
	@GetMapping("/getIssueFiles")
	public ResponseEntity<List<FilesDto>> getIssueFiles(@RequestParam String issueId) {
		List<FilesDto> issueFileList = issueService.getIssueFileList(issueId);
		return ResponseEntity.ok(issueFileList);
	}
	
	@GetMapping("/downloadFile")
	public void downloadFile(@RequestParam("fileId") String fileId, HttpServletResponse response) throws Exception {
	    FilesDto file = issueService.getIssueFile(fileId);
	    
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
	
	@PostMapping("/updateIssueNewFiles")
	public ResponseEntity<String> updateIssueNewFiles(
			@RequestPart("issueId") String issueId, 
			@RequestPart(value = "deleteFileList", required = false) List<String> deleteFileList,
			@RequestPart(value = "issueNewFiles", required = false) MultipartFile[] issueNewFiles) throws IOException {
		if (deleteFileList != null) {
			issueService.deleteIssueFileList(issueId, deleteFileList);
		}
		if (issueNewFiles != null) {
			issueService.addIssueFiles(issueId, issueNewFiles);
		}
		return ResponseEntity.ok(issueId);
	}
	
	@PostMapping("/updateIssue")
	@ResponseBody
	public String updateIssue(@RequestBody IssueDto issueDto, Authentication authentication) {
		String updateMemberId = authentication.getName();
		issueDto.setIssueUpdateMid(updateMemberId);
		issueService.updateIssueData(issueDto);
		return "Success";
	}
	
	@PostMapping("/updateIssueDeactivated")
	public ResponseEntity<String> updateIssueDeactivated(@RequestParam String issueId, Authentication authentication) {
		String issueUpdateMid = authentication.getName();
		issueService.updateIssueEnabled(issueId, issueUpdateMid);
		return ResponseEntity.ok("Success");
	}
	
	@PostMapping("/insertIssCmt")
	public String insertIssCmt(IssueCommentDto isscmtForm, Authentication authentication) {
		String memberId = authentication.getName();
		
		IssueCommentDto isscmt = new IssueCommentDto();
		isscmt.setIssueId(isscmtForm.getIssueId());
		isscmt.setProjectId(isscmtForm.getProjectId());
		isscmt.setIssueCommentContent(isscmtForm.getIssueCommentContent());
		isscmt.setMemberId(memberId);
		
		if(isscmtForm.getIssueCommentParentId() != null) {
			isscmt.setIssueCommentParentId(isscmtForm.getIssueCommentParentId());
		}
		issueService.insertIssCmt(isscmt);
		
		return "redirect:/project/projectBoard?projectId="+isscmtForm.getProjectId();
	}
	
	@GetMapping("/getIssCmtList")
	@ResponseBody
	public List<IssueCommentDto> getIssCmtList(String issueId){
		List<IssueCommentDto> isscmts = issueService.getIssCmts(issueId);
		log.info(issueId);
		log.info("이슈코멘트불러오기 : " + isscmts.toString());
		
		return isscmts;
	}
	
	@PostMapping("/updateIssCmt")
	@ResponseBody
	public void updateIssCmt(IssueCommentDto isscmtForm) {		
		IssueCommentDto isscmt = new IssueCommentDto();
		log.info("issue id : " + isscmt.getIssueCommentId());
		log.info("issue content : " + isscmt.getIssueCommentContent());
		isscmt.setIssueCommentId(isscmtForm.getIssueCommentId());
		isscmt.setIssueCommentContent(isscmtForm.getIssueCommentContent());
		
		issueService.updatingIssCmt(isscmt);
	}
	
	@PostMapping("/deleteComment")
	@ResponseBody
	public void deleteComment(String commentId) {
		log.info(commentId);
		issueService.deleteCmt(commentId);
	}
}
