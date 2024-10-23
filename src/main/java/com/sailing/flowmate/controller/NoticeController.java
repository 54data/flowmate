package com.sailing.flowmate.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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
		dbnotice.setMemberId("aa");
		dbnotice.setProjectId("PROJ-1");
		dbnotice.setNoticeTitle(noticeForm.getNoticeTitle());
		dbnotice.setNoticeContent(noticeForm.getNoticeContent());
		dbnotice.setNoticeEnabled(true);

		MultipartFile noticeAttach = noticeForm.getNoticeAttach();
		
		log.info(noticeAttach.toString());
		
		noticeService.insertNotice(dbnotice);	
		
		if(!noticeAttach.isEmpty()) {
			dbnotice.setFileName(noticeAttach.getOriginalFilename());
			dbnotice.setFileType(noticeAttach.getContentType());
			dbnotice.setFileData(noticeAttach.getBytes());
			
			noticeService.insertNoticeAttach(dbnotice);
		}
						
		log.info("실행" + dbnotice.toString());
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
		log.info("페이지번호: " + pageNo);
		log.info("실행" + noticeList.toString());
		return "notice/noticeList";
	}
	
	@GetMapping("/noticeDetail")
	public String noticeDetail(Model model, String noticeId){
		NoticeDto notice = noticeService.getNotice(noticeId);
		List<NoticeDto> noticeFiles = noticeService.getNoticeFiles(noticeId);
		
		int currentHitNum = notice.getNoticeHitnum();
		notice.setNoticeHitnum(currentHitNum+1);
		noticeService.addHitNum(noticeId);
		
		model.addAttribute("notice", notice);
		model.addAttribute("noticeFiles", noticeFiles);
		
		log.info("실행" + notice.toString());
		log.info("fileList: " + noticeFiles.toString());
		return "notice/noticeDetail";
	}
	
	@GetMapping("/updateNoticeForm")
	public String updateNoticeForm(Model model, @RequestParam String noticeId) {	
		log.info("실행: " + noticeId);
		NoticeDto notice = noticeService.getNotice(noticeId);
		model.addAttribute("notice", notice);
		return "notice/noticeForm";
	}

	@PostMapping("/updateNotice")
	public String updateNotice(NoticeDto notice) {
		log.info("실행: " + notice.getNoticeId());
		NoticeDto dbnotice = new NoticeDto();
		dbnotice.setNoticeId(notice.getNoticeId());
		dbnotice.setNoticeTitle(notice.getNoticeTitle());
		dbnotice.setNoticeContent(notice.getNoticeContent());
		noticeService.updateNotice(dbnotice);
		return "redirect:/notice/noticeDetail?noticeId="+notice.getNoticeId();
	}
	
	@RequestMapping("/enabledNotice")
	public String enabledNotice(String noticeId) {
		log.info("실행: " + noticeId);
		NoticeDto dbnotice = new NoticeDto();
		dbnotice.setNoticeId(noticeId);
		dbnotice.setNoticeEnabled(false);
		noticeService.enabledNotice(dbnotice);
		return "redirect:/notice/noticeList?pageNo=1";
	}
	
	@GetMapping("/downloadFile")
	public ResponseEntity<byte[]> downloadFile(@RequestParam("fileId") String fileId) {
	    NoticeDto fileDto = noticeService.getFile(fileId);
	    byte[] fileData = fileDto.getFileData();
	    
	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentDisposition(ContentDisposition.builder("attachment")
	            .filename(fileDto.getFileName())
	            .build());
	    headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
	    
	    return new ResponseEntity<>(fileData, headers, HttpStatus.OK);
	}
}
