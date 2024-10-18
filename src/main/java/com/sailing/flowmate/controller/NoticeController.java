package com.sailing.flowmate.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sailing.flowmate.dto.NoticeDto;
import com.sailing.flowmate.service.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/notice")
@Controller
public class NoticeController {
	@Autowired
	private NoticeService noticeService;
	
	@GetMapping("/noticeForm")
	public String noticeForm() {
		return "notice/noticeForm";
	}
	
	@GetMapping("/noticeList")
	public String noticeList(String projectId, Model model){
		
		List<NoticeDto> allNotices = noticeService.getAllNotices(projectId);
		model.addAttribute(allNotices);
		return "notice/noticeList";
	}
}
