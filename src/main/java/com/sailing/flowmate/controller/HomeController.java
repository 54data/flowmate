package com.sailing.flowmate.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sailing.flowmate.dto.MemberDto;
import com.sailing.flowmate.dto.MessageDto;
import com.sailing.flowmate.dto.ProjectDto;
import com.sailing.flowmate.dto.TaskDto;
import com.sailing.flowmate.service.MemberService;
import com.sailing.flowmate.service.MessageService;
import com.sailing.flowmate.service.ProjectService;
import com.sailing.flowmate.service.TaskService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@Secured("ROLE_DEV")
public class HomeController {
	@Autowired
	ProjectService projectService;
	
	@Autowired
	TaskService taskService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	MessageService messageService;
	
	@RequestMapping("")
	public String getMypageMain(Authentication authentication, Model model) {
		if (authentication != null) {
	    	String memberId = authentication.getName();
	    	
	    	MemberDto member = memberService.getMember(memberId);
	    	model.addAttribute("userName", member.getMemberName());
	    	List<ProjectDto> myProjectsList = getMyProjects(memberId);
	    	List<MessageDto> myMsgList = getHomeMessage(memberId);
	    	
	    	
	    	model.addAttribute("myProjectsList", myProjectsList);
	    	model.addAttribute("myMsgList", myMsgList);
		}
		return "mypageMain";
	}
	
	public List<ProjectDto> getMyProjects(String memberId) {
		List<ProjectDto> myProjectsList = projectService.getMyProjectList(memberId);
		return myProjectsList;
	}

	@GetMapping("/myTasks")
	public String getTasks(@RequestParam("type") String type, Authentication authentication, Model model) {
		String memberId = authentication.getName();
	    List<TaskDto> tasks = new ArrayList<>();
	    String noTasksMessage = "";  
	    if ("today".equals(type)) {
	        tasks = taskService.getMyTaskListForHome(memberId);
	        if (tasks.isEmpty()) {
	            noTasksMessage = "진행 중인 작업이 없습니다.";
	        }
	    } else if ("delayed".equals(type)) {
	        tasks = taskService.getMyDelayTask(memberId);
	        if (tasks.isEmpty()) {
	            noTasksMessage = "지연된 작업이 없습니다.";
	        }
	    }
	    model.addAttribute("tasks", tasks);
	    model.addAttribute("noTasksMessage", noTasksMessage);
	    return "mypage/myTaskListHome";
	}
	
	
	public List<MessageDto> getHomeMessage(String memberId){
		String receiverId = memberId;
		List<MessageDto> homeMsg = messageService.selectHomeMessge(receiverId);
		return homeMsg;
	}
	
	@GetMapping("/getMyProjectStats")
	public ResponseEntity<ProjectDto> getMyProjectStats(String projectId, Authentication authentication) {
		String memberId = authentication.getName();
		ProjectDto myrojectStats = projectService.getMyProjectStatsById(projectId, memberId);
		return ResponseEntity.ok(myrojectStats);
	}
}
