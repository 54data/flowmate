package com.sailing.flowmate.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sailing.flowmate.dto.MemberDto;
import com.sailing.flowmate.service.MemberService;
import com.sailing.flowmate.service.MemberService.JoinResult;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/account")
@Controller
public class AccountController {
	@Autowired
	MemberService memberService;
	
	@GetMapping("/loginForm")
	public String login() {
		return "account/loginForm";
	}
	
	@GetMapping("/signupForm")
	public String signup() {
		return "account/signupForm";
	}
	
	@PostMapping("/signup")
	public String join(MemberDto member, Model model) {
		member.setMemberEnabled(true);
		
		PasswordEncoder passwordEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
		member.setMemberPw(passwordEncoder.encode(member.getMemberPw()));
		
		log.info("실행" + member.toString());
		
		JoinResult joinResult = memberService.join(member);
		if(joinResult == JoinResult.FAIL_DUPLICATED_USERID){
			String errorMessage = "아이디가 존재합니다";
			model.addAttribute(errorMessage);
			return "account/signupForm";
		} else {
			return "redirect:/account/loginForm";
		}
	}
}
