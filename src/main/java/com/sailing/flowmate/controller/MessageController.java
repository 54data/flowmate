package com.sailing.flowmate.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sailing.flowmate.dto.MessageDto;
import com.sailing.flowmate.service.MessageService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/message")
public class MessageController {
	
	@Autowired
	MessageService messageService;
	
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
	
	@PostMapping("/sendMessage")
	@ResponseBody
	public String sendMessage(
	        @RequestParam List<String> memberIds,
	        MessageDto msgDto,
	        @RequestParam(value = "files", required = false) MultipartFile[] msgFiles,
	        Authentication authentication) 
	throws Exception {
		
		String senderId = authentication.getName();
		log.info("발신자:" + senderId);

        msgDto.setMessageSenderId(senderId); // 발신자 ID 설정

        // 중복된 수신자 ID 제거
        Set<String> receiverMemberIds = new HashSet<>(memberIds);
        List<String> setMemberIds = new ArrayList<>(receiverMemberIds);

        // 메시지 전송
        messageService.insertMessages(senderId, setMemberIds, msgDto);
	    //첨부파일 추가
        MultipartFile[] files = msgFiles;


	    if (files != null) {
	        for (MultipartFile file : files) {
	            if (!file.isEmpty()) {
	            	
	            	msgDto.setFileName(file.getOriginalFilename());
	            	msgDto.setFileType(file.getContentType());
	            	msgDto.setFileData(file.getBytes());

	               
	                messageService.insertMsgAttach(msgDto);
	            }
	        }
	    }
	    return "쪽지가 성공적으로 전송되었습니다.";
	}
	
	
}
