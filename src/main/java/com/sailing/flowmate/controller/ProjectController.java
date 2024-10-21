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
	
	@RequestMapping("/projectCreating")
	public String projectCreating() {
		return "project/projectCreating";
	}
}
