package com.sailing.flowmate.controller;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sailing.flowmate.dto.MemberDto;
import com.sailing.flowmate.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/admin")
@Controller
@Secured("ROLE_ADMIN")
public class AdminController {
	@Autowired
	MemberService memberService;
	
	//status, enabled 모두 true
	@GetMapping("/adminPage")
	public String adminPage(Model model) {
		List<MemberDto> enableMembers = memberService.getMembersForAdmin(true, true);
		model.addAttribute("enableMembers", enableMembers);
		return "admin/adminPage";
	}
	
	//status true, enabled false
	@GetMapping("/adminPageDisable")
	public String adminPageDisable(Model model) {
		List<MemberDto> disableMembers = memberService.getMembersForAdmin(true, false);
		model.addAttribute("disableMembers", disableMembers);
		return "admin/adminPageDisable";
	}
	
	//status false, enabled true
	@GetMapping("/adminPageStay")
	public String adminPageStay(Model model) {
		List<MemberDto> waitingMembers = memberService.getMembersForAdmin(false, true);
		model.addAttribute("waitingMembers", waitingMembers);
		return "admin/adminPageStay";
	}

	@GetMapping("/updateMemberByAdmin")
	public String updateMemberByAdmin(Model model, String memberId, @Param("memberStatus")boolean memberStatus, 
			@Param("memberEnabled")boolean memberEnabled) {
		MemberDto member = memberService.getMember(memberId);
		member.setMemberStatus(memberStatus);
		member.setMemberEnabled(memberEnabled);
		memberService.updateMemberByAdmin(member);
		return "redirect:/admin/adminPage";
	}
	
	@PostMapping("/updateInfo")
	public String updateInfo(@RequestBody List<MemberDto> updatedMembers) {
		log.info("실행");
	    for (MemberDto memberForm : updatedMembers) {
	        memberService.updateInfo(memberForm);
	    }
	    return "redirect:/admin/adminPage"; 
	}

}
