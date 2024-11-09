package com.sailing.flowmate.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sailing.flowmate.dto.MessageDto;
import com.sailing.flowmate.dto.PagerDto;
import com.sailing.flowmate.service.MessageService;
import com.sailing.flowmate.soket.WebSocketHandler;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/message")
public class MessageController {

	@Autowired
	MessageService messageService;
	@Autowired
	WebSocketHandler webSocketHandler;

	@GetMapping("/messageBox")
	public String getMessageBox(Authentication authentication, Model model,
			@RequestParam(defaultValue = "1") int pageNo, HttpSession session) {

		String receiverId = authentication.getName();
		int totalRows = messageService.getReceieveTotalRows(receiverId);
		PagerDto pager = new PagerDto(8, 5, totalRows, pageNo);

		pager.setMessageReceiverId(receiverId);
		session.setAttribute("pager", pager);

		List<MessageDto> msgReceiveList = messageService.selectMessageReceiveList(pager);
		// CLOB 타입은 그룹화 안됨으로 따로 가져옴 (단체 쪽지)
		List<MessageDto> msgContentList = messageService.selectReceieveMessageContentList(receiverId);

		// msgContentList를 Map으로 변환하여 messageId 기준으로 콘텐츠를 가져오기
		Map<String, String> contentMap = new HashMap<>();
		for (MessageDto content : msgContentList) {
			contentMap.put(content.getMessageId(), content.getMessageContent());
		}

		// msgReceiveList의 각 메시지에 콘텐츠 설정
		for (MessageDto msg : msgReceiveList) {
			msg.setMessageContent(contentMap.get(msg.getMessageId()));
		}

		model.addAttribute("msgList", msgReceiveList);
		model.addAttribute("pager", pager);
		model.addAttribute("currentPage", "receive");
		return "message/messageBox";
	}

	@GetMapping("/messageSentBox")
	public String getMessageSentBox(Authentication authentication, Model model,
	                                @RequestParam(defaultValue = "1") int pageNo, HttpSession session) {

	    String senderId = authentication.getName();
	    int totalRows = messageService.getSentTotalRows(senderId);
	    PagerDto pager = new PagerDto(8, 5, totalRows, pageNo);

	    pager.setMessageSenderId(senderId);
	    session.setAttribute("pager", pager);

	    List<MessageDto> msgSentList = messageService.selectMessageSentList(pager);
	    // CLOB 타입은 그룹화가 안되므로 별도로 가져옴 (단체 쪽지)
	    List<MessageDto> msgContentList = messageService.selectSentMessageContentList(senderId);

	    Map<String, String> contentMap = new HashMap<>();
	    for (MessageDto content : msgContentList) {
	        contentMap.put(content.getMessageId(), content.getMessageContent());
	    }

	    for (MessageDto msg : msgSentList) {
	        msg.setMessageContent(contentMap.get(msg.getMessageId()));
	    }

	    model.addAttribute("msgList", msgSentList);
	    model.addAttribute("pager", pager);
	    model.addAttribute("currentPage", "sent");
	    return "message/messageBox";
	}


	@GetMapping("/messageDetail")
	public String getMessageDetail() {
		return "message/messageDetail";
	}

	@GetMapping("/messageSend")
	public String getMessageSend() {
		return "message/messageSend";
	}

	@PostMapping("/sendMessage")
	@ResponseBody
	public String sendMessage(@RequestParam List<String> memberIds, MessageDto msgDto,
			@RequestParam(value = "files", required = false) MultipartFile[] msgFiles, Authentication authentication)
			throws Exception {

		String senderId = authentication.getName();

		msgDto.setMessageSenderId(senderId); // 발신자 ID 설정

		// 중복된 수신자 ID 제거
		Set<String> receiverMemberIds = new HashSet<>(memberIds);
		List<String> setMemberIds = new ArrayList<>(receiverMemberIds);
		// 메시지 전송
		messageService.insertMessages(senderId, setMemberIds, msgDto);
		for (String receiverId : setMemberIds) {
			String notificationMessage = senderId + "님으로부터 새로운 쪽지가 도착했습니다.";
			int unreadMsgCount = messageService.selectCntUnReadMsg(receiverId);
			webSocketHandler.notifyUser(receiverId, notificationMessage, unreadMsgCount); // 알림 전송
		}
		// 첨부파일 추가
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

	@GetMapping("/msgCnt")
	@ResponseBody
	public int getUnreadMessageCount(Authentication authentication) throws Exception {
		MessageDto msgDto = new MessageDto();
		String messageReceiverId = authentication.getName();
		msgDto.setMessageReceiverId(messageReceiverId);
		int unreadMsgCount = messageService.selectCntUnReadMsg(messageReceiverId);
		webSocketHandler.notifyUser(messageReceiverId, null, unreadMsgCount);
		return unreadMsgCount;
	}

}
