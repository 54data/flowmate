package com.sailing.flowmate.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
public class HomeController {
	
	@RequestMapping("")
	public String getMypageMain(Authentication authentication, Model model) {
	    if(authentication != null) {
	    	String userName = authentication.getName();
	    	model.addAttribute("userName", userName);
	    }
		return "mypageMain";
	}

}
