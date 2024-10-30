package com.sailing.flowmate.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sailing.flowmate.dto.ProjectDto;
import com.sailing.flowmate.service.ProjectService;

@Controller
public class HomeController {
	@Autowired
	ProjectService projectService;
	
	@RequestMapping("")
	public String getMypageMain(Authentication authentication, Model model) {
		if (authentication != null) {
	    	String memberId = authentication.getName();
	    	model.addAttribute("userName", memberId);
	    	List<ProjectDto> myProjectsList = getMyProjects(memberId);
	    	model.addAttribute("myProjectsList", myProjectsList);
		}
		return "mypageMain";
	}
	
	public List<ProjectDto> getMyProjects(String memberId) {
		List<ProjectDto> myProjectsList = projectService.getMyProjectsList(memberId);
		return myProjectsList;
	}
}
