package com.sailing.flowmate.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sailing.flowmate.dto.IssueDto;
import com.sailing.flowmate.dto.MemberDto;
import com.sailing.flowmate.dto.ProjectDto;
import com.sailing.flowmate.dto.TaskDto;
import com.sailing.flowmate.security.CustomUserDetailsService;
import com.sailing.flowmate.service.IssueService;
import com.sailing.flowmate.service.MemberService;
import com.sailing.flowmate.service.ProjectService;
import com.sailing.flowmate.service.TaskService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/mypage")
@Secured("ROLE_DEV")
public class MypageController {
	@Autowired
	private ProjectService projectService;
	
	@Autowired
	private TaskService taskService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private IssueService issueService;
	
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
	public String myIssue(Authentication authentication, Model model) {
		String memberId = authentication.getName();
		List<IssueDto> myIssueList = issueService.getMyIssue(memberId);
		model.addAttribute("myIssueList", myIssueList);
		return "mypage/myIssue";
	}
	
	@GetMapping("/myProject")
	public String getMyProject(Authentication authentication, Model model){
		String memberId = authentication.getName();
		List<ProjectDto> myProjectList = projectService.getMyProjectList(memberId);
		model.addAttribute("myProjectList", myProjectList);
		return "mypage/myProject";
	}
	
	@GetMapping("/myTask")
	public String getMyTask(Authentication authentication, Model model){
		String memberId = authentication.getName();
		List<TaskDto> myTaskList = taskService.getMyTaskList(memberId);
		log.info(myTaskList.toString());
		model.addAttribute("myTaskList", myTaskList);
		
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

	@PostMapping("/updatePwd")
	@ResponseBody
	public String updateUserPassword(@RequestBody Map<String, String> pwdData, Authentication authentication) {
	    String currentPwd = pwdData.get("currentPwd");
	    String newPwd = pwdData.get("newPwd");
	    
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
	
	@GetMapping("/getInfo")
	@ResponseBody
	public MemberDto getInfo(Authentication authentication) {
        String memberId = authentication.getName();
        MemberDto member = memberService.getMemberWithCode(memberId);
        return member;
    }	
}
