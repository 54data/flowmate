package com.sailing.flowmate.controller;

import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.sailing.flowmate.dto.NoticeDto;
import com.sailing.flowmate.dto.NoticeFormDto;
import com.sailing.flowmate.dto.PagerDto;
import com.sailing.flowmate.service.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/notice")
@Controller
public class NoticeController {
	@Autowired
	NoticeService noticeService; 
	
	@GetMapping("/noticeForm")
	public String noticeForm() {
		return "notice/noticeForm";
	}
	
	@PostMapping("/insertNotice")
	public String insertNotice(NoticeFormDto noticeForm) throws Exception {
		NoticeDto dbnotice = new NoticeDto();
		dbnotice.setMemberId("yerin");
		dbnotice.setProjectId("PROJ-1");
		dbnotice.setNoticeTitle(noticeForm.getNoticeTitle());
		dbnotice.setNoticeContent(noticeForm.getNoticeContent());
		dbnotice.setNoticeEnabled(true);	
		
		MultipartFile noticeAttach = noticeForm.getNoticeAttach();
		noticeService.insertNotice(dbnotice);	

		log.info("실행" + noticeAttach.toString());
		log.info("텅비었다고?" + noticeAttach.isEmpty());
		if(!noticeAttach.isEmpty()) {
			log.info("잘 담기나요");
			dbnotice.setFileName(noticeAttach.getOriginalFilename());
			dbnotice.setFileType(noticeAttach.getContentType());
			dbnotice.setFileData(noticeAttach.getBytes());
			
			noticeService.insertNoticeAttach(dbnotice);
		}
						
		return "redirect:/notice/noticeList?pageNo=1";
	}
	
	@GetMapping("/noticeList")
	public String noticeList(Model model, 
			@RequestParam(defaultValue="1") int pageNo,
			HttpSession session){
		int totalRows = noticeService.getTotalRows();
		PagerDto pager = new PagerDto(3, 5, totalRows, pageNo);
		session.setAttribute("pager", pager);
		List<NoticeDto> noticeList = noticeService.getNoticeList(pager);
		model.addAttribute("noticeList", noticeList);
		return "notice/noticeList";
	}
	
	@GetMapping("/noticeDetail")
	public String noticeDetail(Model model, String noticeId){
		NoticeDto notice = noticeService.getNotice(noticeId);
		List<NoticeDto> noticeFiles = noticeService.getNoticeFiles(noticeId);
		noticeService.addHitNum(noticeId);
		
		model.addAttribute("notice", notice);
		model.addAttribute("noticeFiles", noticeFiles);
		return "notice/noticeDetail";
	}
	
	@GetMapping("/updateNoticeForm")
	public String updateNoticeForm(Model model, @RequestParam String noticeId) {	
		NoticeDto notice = noticeService.getNotice(noticeId);
		List<NoticeDto> noticeFiles = noticeService.getNoticeFiles(noticeId);
		noticeService.addHitNum(noticeId);

		model.addAttribute("notice", notice);
		model.addAttribute("noticeFiles", noticeFiles);

		return "notice/noticeForm";
	}

	@PostMapping("/updateNotice")
	public String updateNotice(NoticeDto notice) {
		NoticeDto dbnotice = new NoticeDto();
		dbnotice.setNoticeId(notice.getNoticeId());
		dbnotice.setNoticeTitle(notice.getNoticeTitle());
		dbnotice.setNoticeContent(notice.getNoticeContent());
		noticeService.updateNotice(dbnotice);
		return "redirect:/notice/noticeDetail?noticeId="+notice.getNoticeId();
	}
	
	@RequestMapping("/enabledNotice")
	public String enabledNotice(String noticeId) {
		NoticeDto dbnotice = new NoticeDto();
		dbnotice.setNoticeId(noticeId);
		dbnotice.setNoticeEnabled(false);
		noticeService.enabledNotice(dbnotice);
		return "redirect:/notice/noticeList?pageNo=1";
	}
	
	@GetMapping("/downloadFile")
	public void downloadFile(@RequestParam("fileId") String fileId, HttpServletResponse response) throws Exception {
	    NoticeDto file = noticeService.getFile(fileId);
	    
	    String contentType = file.getFileType();
	    response.setContentType(contentType);
	    
	    String fileName = file.getFileName();
	    String encodingFileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
	    response.setHeader("Content-Disposition", "attachment; filename=\"" + encodingFileName + "\"");
	
		OutputStream out = response.getOutputStream();
		out.write(file.getFileData());
		out.flush();
		out.close();
	}
}
