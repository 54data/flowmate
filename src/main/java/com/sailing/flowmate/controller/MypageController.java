package com.sailing.flowmate.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sailing.flowmate.dto.MemberDto;
import com.sailing.flowmate.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/mypage")
public class MypageController {
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/mypageMain")
	public String getMypageMain() {
		
		return "mypage/mypageMain";
	}
	
	@GetMapping("/messageBox")
	public String getMessageBox(){
		
		return "mypage/messageBox";
	}
	
	@GetMapping("/messageDetail")
	public String getMessageDetail(){
		
		return "mypage/messageDetail";
	}
	
	
	@Secured("ROLE_ADMIN")
	@GetMapping("/adminPage")
	public String getAdminPage(){
		
		return "mypage/adminPage";
	}

	@Secured("ROLE_ADMIN")
	@GetMapping("/adminPageDisable")
	public String getAdminPageDisable(){
		
		return "mypage/adminPageDisable";
	}
	
	@Secured("ROLE_ADMIN")
	@GetMapping("/adminPageStay")
	public String getAdminPageStay(){
		
		return "mypage/adminPageStay";
	}
	
	@GetMapping("/myIssue")
	public String getMyIssue(){
		
		return "mypage/myIssue";
	}
	
	@GetMapping("/myProject_Dev")
	public String getMyProjectDev(){
		
		return "mypage/myProject_Dev";
	}
	
	@GetMapping("/myProject")
	public String getMyProject(){
		
		return "mypage/myProject";
	}
	
	@GetMapping("/myTask")
	public String getMyTask(){
		
		return "mypage/myTask";
	}
	
	@GetMapping("/editInfo")
	public String editInfo(Authentication authentication, Model model){
		String memberId = authentication.getName();
		MemberDto member = memberService.getMember(memberId);
		model.addAttribute("member", member);
		return "mypage/editInfo";
	}
	
	@PostMapping("/updateInfo")
	public String updateInfo(Authentication authentication, MemberDto memberForm){
		String memberId = authentication.getName();
		MemberDto member = memberService.getMember(memberId);
		
		member.setMemberDeptId(memberForm.getMemberDeptId());
		member.setMemberRankId(memberForm.getMemberRankId());
		member.setMemberRoleId(memberForm.getMemberRoleId());
		
		memberService.updateInfo(member);
		
		return "redirect:/mypage/editInfo";
	}
	
}
