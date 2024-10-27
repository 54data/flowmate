package com.sailing.flowmate.controller;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.annotation.RequestScope;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/message")
public class MessageController {
	
	
	@GetMapping("/messageBox")
	public String getMessageBox(){
		return "message/messageBox";
	}
	@GetMapping("/messageSentBox")
	public String getMessageSentBox(){
		return "message/messageSentBox";
	}
	@GetMapping("/messageDetail")
	public String getMessageDetail(){
		return "message/messageDetail";
	}
	@GetMapping("/messageSend")
	public String getMessageSend() {
		log.info("실행");
		return "message/messageSend";
	}
}
