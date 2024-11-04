package com.sailing.flowmate.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sailing.flowmate.dto.MemberDto;
import com.sailing.flowmate.dto.ProjectDto;
import com.sailing.flowmate.dto.TaskDto;
import com.sailing.flowmate.service.MemberService;
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
	
	@RequestMapping("")
	public String getMypageMain(Authentication authentication, Model model) {
		if (authentication != null) {
	    	String memberId = authentication.getName();
	    	
	    	MemberDto member = memberService.getMember(memberId);
	    	model.addAttribute("userName", member.getMemberName());
	    	List<ProjectDto> myProjectsList = getMyProjects(memberId);

	    	model.addAttribute("myProjectsList", myProjectsList);

		}
		return "mypageMain";
	}
	
	public List<ProjectDto> getMyProjects(String memberId) {
		List<ProjectDto> myProjectsList = projectService.getMyProjectList(memberId);
		return myProjectsList;
	}
	

	@GetMapping("/myTasks")
	public String getTasksFragment(@RequestParam("type") String type, Authentication authentication, Model model) {
	    String memberId = authentication.getName();
	    List<TaskDto> tasks = new ArrayList<>();

	    
	    if ("today".equals(type)) {
	        tasks = taskService.getMyTaskListForHome(memberId); 
	    } else if ("delayed".equals(type)) {
	        tasks = taskService.getMyDelayTask(memberId);
	    }

	    model.addAttribute("tasks", tasks);
	    return "mypage/myTaskList";
	}
}
