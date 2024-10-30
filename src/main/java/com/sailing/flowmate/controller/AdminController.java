package com.sailing.flowmate.controller;


import java.util.List;

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
@RequestMapping("/admin")
@Controller
public class AdminController {
	@Autowired
	MemberService memberService;
	
	@GetMapping("/adminPage")
	public String adminPage(Model model) {
		List<MemberDto> enableMembers = memberService.getEnableMembers();
		model.addAttribute("enableMembers", enableMembers);
		return "admin/adminPage";
	}
	
	@GetMapping("/adminPageDisable")
	public String adminPageDisable(Model model) {
		List<MemberDto> disableMembers = memberService.getDisableMembers();
		model.addAttribute("disableMembers", disableMembers);
		return "admin/adminPageDisable";
	}
	
	@GetMapping("/adminPageStay")
	public String adminPageStay(Model model) {
		List<MemberDto> waitingMembers = memberService.getwaitingMembers();
		model.addAttribute("waitingMembers", waitingMembers);
		return "admin/adminPageStay";
	}

	@GetMapping("/updateMemberStatus")
	public String updateMemberStatus(Model model, String memberId, int memberEnabled) {
		MemberDto member = memberService.getMember(memberId);
		member.setMemberStatus(memberEnabled);
		memberService.updateMemberStatus(member);
		return "redirect:/admin/adminPage";
	}
}
