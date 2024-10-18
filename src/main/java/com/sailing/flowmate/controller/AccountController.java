package com.sailing.flowmate.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/account")
@Controller
public class AccountController {

	@GetMapping("/login")
	public String login() {
		return "account/login";
	}
	
	@GetMapping("/logout")
	public String logout() {
		return "account/logout";
	}
}
