package com.sailing.flowmate.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sailing.flowmate.dto.MemberDto;
import com.sailing.flowmate.dto.ProjectDto;
import com.sailing.flowmate.security.CustomUserDetailsService;
import com.sailing.flowmate.service.MemberService;
import com.sailing.flowmate.service.ProjectService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/mypage")
public class MypageController {
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CustomUserDetailsService usersDetailsService;
	
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
	
	@Secured("ROLE_DEV")
	@GetMapping("/myProject")
	public String getMyProject(Authentication authentication, Model model){
		String memberId = authentication.getName();
		List<ProjectDto> myProjectList = projectService.getMyProjectList(memberId);
		model.addAttribute("myProjectList", myProjectList);
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
	
/*	@PostMapping("/updatePwd")
	@ResponseBody
	public String updatePwd(Authentication authentication, MemberDto memberForm){
		String currentPwd = memberForm.getCurrentPwd();
		String newPwd = memberForm.getNewPwd();
		
		String memberId = authentication.getName();
		MemberDto member = memberService.getMember(memberId);
		UserDetails userDetails = usersDetailsService.loadUserByUsername(memberId);
		
		PasswordEncoder passwordEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
	    if (!passwordEncoder.matches(currentPwd, userDetails.getPassword())) {
	        return "NOT EQUAL";
	    }
	    
	    String encodedNewPwd = passwordEncoder.encode(newPwd);
	    member.setMemberPw(encodedNewPwd);
	    
	    Boolean updateResult = memberService.updatePwd(member);
	    if (updateResult) {
	    	Authentication newAuth = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
	        SecurityContextHolder.getContext().setAuthentication(newAuth);
	        return "SUCCESS";
	    }
	    return "FAIL";
	}
	
	@PostMapping("/deactiveMember")
	@ResponseBody
	public void deactiveMember(Authentication authentication) {
		memberService.deactiveMember(authentication.getName());
	}
*/	
}
