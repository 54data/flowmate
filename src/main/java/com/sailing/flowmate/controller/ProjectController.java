package com.sailing.flowmate.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/project")
@Controller
public class ProjectController {
	@RequestMapping("/projectBoard")
	public String projectBoard() {
		return "project/projectBoard";
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
