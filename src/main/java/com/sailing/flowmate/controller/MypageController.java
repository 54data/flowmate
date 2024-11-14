package com.sailing.flowmate.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sailing.flowmate.dto.IssueDto;
import com.sailing.flowmate.dto.MemberDto;
import com.sailing.flowmate.dto.MessageDto;
import com.sailing.flowmate.dto.ProjectDto;
import com.sailing.flowmate.dto.TaskDto;
import com.sailing.flowmate.security.CustomUserDetailsService;
import com.sailing.flowmate.service.IssueService;
import com.sailing.flowmate.service.MemberService;
import com.sailing.flowmate.service.MessageService;
import com.sailing.flowmate.service.ProjectService;
import com.sailing.flowmate.service.TaskService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("")
@Secured("ROLE_DEV")
public class MypageController {
	@Autowired
	ProjectService projectService;
	
	@Autowired
	TaskService taskService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	MessageService messageService;
	
	@Autowired
	IssueService issueService;
	
	@Autowired
	CustomUserDetailsService usersDetailsService;
	
	@RequestMapping("")
	public String getMypageMain(Authentication authentication, Model model) {
		if (authentication != null) {
	    	String memberId = authentication.getName();
	    	
	    	MemberDto member = memberService.getMember(memberId);
	    	model.addAttribute("userName", member.getMemberName());
	    	List<ProjectDto> myProjectsList = getMyProjects(memberId);
	    	List<MessageDto> myMsgList = getHomeMessage(memberId);
	    	
	        for (MessageDto message : myMsgList) {
	            String messageContent = message.getMessageContent();
	            if (messageContent != null) {
	                // \n을 <br>로 변환
	                messageContent = messageContent.replace("\n", "<br>");
	                message.setMessageContent(messageContent);
	            }
	        }
	    	
	    	
	    	model.addAttribute("myProjectsList", myProjectsList);
	    	model.addAttribute("myMsgList", myMsgList);
		}
		return "mypageMain";
	}
	
	public List<ProjectDto> getMyProjects(String memberId) {
		List<ProjectDto> myProjectsList = projectService.getMyProjectList(memberId);
		return myProjectsList;
	}

	@GetMapping("/myTasks")
	public String getTasks(@RequestParam("type") String type, Authentication authentication, Model model) {
		String memberId = authentication.getName();
	    List<TaskDto> tasks = new ArrayList<>();
	    String noTasksMessage = "";  
	    if ("today".equals(type)) {
	        tasks = taskService.getMyTaskListForHome(memberId);
	        if (tasks.isEmpty()) {
	            noTasksMessage = "진행 중인 작업이 없습니다.";
	        }
	    } else if ("delayed".equals(type)) {
	        tasks = taskService.getMyDelayTask(memberId);
	        if (tasks.isEmpty()) {
	            noTasksMessage = "지연된 작업이 없습니다.";
	        }
	    }
	    model.addAttribute("tasks", tasks);
	    model.addAttribute("noTasksMessage", noTasksMessage);
	    return "mypage/myTaskListHome";
	}
	
	
	public List<MessageDto> getHomeMessage(String memberId){
		String receiverId = memberId;
		List<MessageDto> homeMsg = messageService.selectHomeMessge(receiverId);
		return homeMsg;
	}
	
	@GetMapping("/getMyProjectStats")
	public ResponseEntity<ProjectDto> getMyProjectStats(String projectId, Authentication authentication) {
		String memberId = authentication.getName();
		ProjectDto myrojectStats = projectService.getMyProjectStatsById(projectId, memberId);
		log.info(myrojectStats.toString());
		return ResponseEntity.ok(myrojectStats);
	}
	
	@GetMapping("/selectSchduel")
	@ResponseBody
	public List<TaskDto>  getSelectSchduel(@RequestParam("selectDate") String selectDate,
			TaskDto taskDto,
			Authentication authentication) {
		String memberId = authentication.getName();
		taskDto.setMemberId(memberId);
		List<TaskDto> schduel = taskService.getSelectDateSchduel(taskDto);
		return schduel;
	}
	
	@GetMapping("/mypage/myIssue")
	public String myIssue(Authentication authentication, Model model) {
		String memberId = authentication.getName();
		List<IssueDto> myIssueList = issueService.getMyIssue(memberId);
		model.addAttribute("myIssueList", myIssueList);
		return "mypage/myIssue";
	}
	
	@GetMapping("/mypage/myProject")
	public String getMyProject(Authentication authentication, Model model){
		String memberId = authentication.getName();
		List<ProjectDto> myProjectList = projectService.getMyProjectList(memberId);
		model.addAttribute("myProjectList", myProjectList);
		return "mypage/myProject";
	}
	
	@GetMapping("/mypage/myTask")
	public String getMyTask(Authentication authentication, Model model){
		String memberId = authentication.getName();
		List<TaskDto> myTaskList = taskService.getMyTaskList(memberId);
		model.addAttribute("myTaskList", myTaskList);
		
		return "mypage/myTask";
	}
	
	@GetMapping("/mypage/editInfo")
	public String editInfo(Authentication authentication, Model model){
		String memberId = authentication.getName();
		MemberDto member = memberService.getMember(memberId);
		model.addAttribute("member", member);
		return "mypage/editInfo";
	}
	
	@PostMapping("/mypage/updateInfo")
	public String updateInfo(Authentication authentication, MemberDto memberForm){
		String memberId = authentication.getName();
		MemberDto member = memberService.getMember(memberId);
		
		member.setMemberDeptId(memberForm.getMemberDeptId());
		member.setMemberRankId(memberForm.getMemberRankId());
		member.setMemberRoleId(memberForm.getMemberRoleId());
		
		memberService.updateInfo(member);
		
		return "redirect:/mypage/editInfo";
	}

	@PostMapping("/mypage/updatePwd")
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
	
	@GetMapping("/mypage/getInfo")
	@ResponseBody
	public MemberDto getInfo(Authentication authentication) {
        String memberId = authentication.getName();
        MemberDto member = memberService.getMemberWithCode(memberId);
        return member;
    }
}
