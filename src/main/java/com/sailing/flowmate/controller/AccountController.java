package com.sailing.flowmate.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public String login(Model model) {
		model.addAttribute("errorMessage", null);
		return "account/loginForm";
	}
	
	@GetMapping("/checkUserFailure")
	@ResponseBody
	public ResponseEntity<String> checkUserFailure(@RequestParam String memberId, @RequestParam String rawPassword) {
	    log.info(memberId);
	    MemberDto member = memberService.getMember(memberId);
	    PasswordEncoder passwordEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
	    
	    if(member == null) {
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_TYPE, "text/plain; charset=UTF-8")
                    .body("존재하지 않는 회원입니다.");
	    }
	    if (!passwordEncoder.matches(rawPassword, member.getMemberPw())) {
            log.info("비밀번호가 일치하지 않습니다.");
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_TYPE, "text/plain; charset=UTF-8")
                    .body("비밀번호가 일치하지 않습니다.");
        }
	    String errorMessage = "good";  // 기본값
	    if (!passwordEncoder.matches(rawPassword, member.getMemberPw())) {
	        return ResponseEntity.ok()
	                .header(HttpHeaders.CONTENT_TYPE, "text/plain; charset=UTF-8")
	                .body("비밀번호가 일치하지 않습니다.");
	    }
	    if (!member.isMemberEnabled()) {
	        errorMessage = "비활성화된 회원입니다.";
	    }
	    if (!member.isMemberStatus()) {
	        errorMessage = "승인 대기중입니다.";
	    }

	    log.info(errorMessage);
	    return ResponseEntity.ok()
	            .header(HttpHeaders.CONTENT_TYPE, "text/plain; charset=UTF-8")
	            .body(errorMessage);
	}


	@GetMapping("/signupForm")
	public String signup() {
		return "account/signupForm";
	}
	
	@PostMapping("/signup")
	@ResponseBody
	public String join(MemberDto member, Model model) {
		member.setMemberEnabled(true);
		member.setMemberStatus(false);
		
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
	
	@PostMapping("/idDuplicateChk")
	@ResponseBody
	public boolean idDuplicateChk(@RequestParam("memberId") String memberId, Model model){
		JoinResult joinResult = memberService.hasMember(memberId);
		log.info("실행 : " + joinResult);
		return joinResult != JoinResult.FAIL_DUPLICATED_USERID;
	}
}
