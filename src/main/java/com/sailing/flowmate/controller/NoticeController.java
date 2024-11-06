package com.sailing.flowmate.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.sailing.flowmate.dto.FilesDto;
import com.sailing.flowmate.dto.MemberDto;
import com.sailing.flowmate.dto.NoticeDto;
import com.sailing.flowmate.dto.PagerDto;
import com.sailing.flowmate.service.MemberService;
import com.sailing.flowmate.service.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/notice")
@Controller
public class NoticeController {
	@Autowired
	NoticeService noticeService; 
	
	@Autowired
	MemberService memberService; 	
	
	@GetMapping("/noticeForm")
	public String noticeForm(@RequestParam("projectId")String projectId, Model model) {
		model.addAttribute("projectId", projectId);
		return "notice/noticeForm";
	}
	
	@PostMapping("/insertNotice")
	public String insertNotice(@RequestParam(value = "noticeAttaches", required = false) MultipartFile[] noticeAttaches,
            @RequestParam("noticeTitle") String noticeTitle,
            @RequestParam("noticeContent") String noticeContent,
            @RequestParam("projectId") String projectId,
			Authentication authentication) throws Exception {
		NoticeDto dbnotice = new NoticeDto();
		
		dbnotice.setMemberId(authentication.getName());
		dbnotice.setNoticeTitle(noticeTitle);
		dbnotice.setNoticeContent(noticeContent);
		dbnotice.setProjectId(projectId);
		dbnotice.setNoticeEnabled(true);	
		
		noticeService.insertNotice(dbnotice);	
		
		FilesDto dbFiles = new FilesDto();

		if(noticeAttaches != null) {
			for (MultipartFile file : noticeAttaches) {
				if (!file.isEmpty()) {
					dbFiles.setFileName(file.getOriginalFilename());
					dbFiles.setFileType(file.getContentType());
					dbFiles.setFileData(file.getBytes());
					dbFiles.setRelatedId(dbnotice.getNoticeId());
					noticeService.insertNoticeAttach(dbFiles);
				}
			}
		}
		return "redirect:/notice/noticeList?projectId="+projectId+"&pageNo=1";
	}
	
	@GetMapping("/noticeList")
	public String noticeList(Model model, 
			@RequestParam("projectId")String projectId
//			@RequestParam(defaultValue="1")int pageNo,
			/*HttpSession session*/){
		/*int totalRows = noticeService.getTotalRows();
		PagerDto pager = new PagerDto(10, 5, totalRows, pageNo);
		session.setAttribute("pager", pager);*/
		
	    /*Map<String, Object> paramMap = new HashMap<>();*/
	    /*paramMap.put("projectId", projectId);*/
/*	    paramMap.put("startRowNo", pager.getStartRowNo());
	    paramMap.put("endRowNo", pager.getEndRowNo());*/

	    /*log.info(paramMap.toString());*/
	    
/*	    List<NoticeDto> noticeList = noticeService.getNoticeList(paramMap);
*/		
	    List<NoticeDto> noticeList = noticeService.getNoticeList(projectId);
	    
	    String memberId = "";
	    for (NoticeDto notice : noticeList) {
	        String noticeId = notice.getNoticeId();
	        String lastPart = noticeId.substring(noticeId.lastIndexOf("-") + 1);
	        int noticeNewNo = Integer.parseInt(lastPart);
	        memberId = notice.getMemberId();
	        notice.setNoticeNewNo(noticeNewNo);
	    }

    	MemberDto member = memberService.getMember(memberId);
    	model.addAttribute("userName", member.getMemberName());

	    model.addAttribute("projectId", projectId);
	    model.addAttribute("noticeList", noticeList);
		/*model.addAttribute("totalRows", totalRows);*/
		return "notice/noticeList";
	}
	
	@GetMapping("/noticeDetail")
	public String noticeDetail(Model model, @RequestParam("projectId")String projectId, @RequestParam("noticeId") String noticeId){
		noticeService.addHitNum(noticeId);
		NoticeDto notice = noticeService.getNotice(noticeId);
		List<FilesDto> noticeFiles = noticeService.getNoticeFiles(noticeId);
		
		int fileCount = 0;
		for (FilesDto file : noticeFiles) {
			fileCount++;
		}
				
		model.addAttribute("fileCount", fileCount);
		model.addAttribute("projectId", projectId);
		model.addAttribute("notice", notice);
		model.addAttribute("noticeFiles", noticeFiles);
		return "notice/noticeDetail";
	}
	
	@GetMapping("/updateNoticeForm")
	public String updateNoticeForm(Model model, @RequestParam("projectId") String projectId, @RequestParam("noticeId")String noticeId) {	
		NoticeDto notice = noticeService.getNotice(noticeId);
		List<FilesDto> noticeFiles = noticeService.getNoticeFiles(noticeId);
		
		int fileCount = 0;
		for (FilesDto file : noticeFiles) {
			fileCount++;
		}

		int titleLength = notice.getNoticeTitle().length();
		noticeService.addHitNum(noticeId);

		model.addAttribute("titleLength", titleLength);
		model.addAttribute("fileCount", fileCount);
		model.addAttribute("projectId", projectId);
		model.addAttribute("notice", notice);
		model.addAttribute("noticeFiles", noticeFiles);

		return "notice/noticeForm";
	}

	@PostMapping("/updateNotice")
	public String updateNotice(
			@RequestParam(value = "noticeAttaches", required = false) MultipartFile[] noticeAttaches,
            @RequestParam("noticeTitle") String noticeTitle,
            @RequestParam("noticeContent") String noticeContent,
            @RequestParam("projectId") String projectId,
            @RequestParam("noticeId") String noticeId,
            @RequestParam(value = "existingFileIds", required = false) String[] existingFileIds,
            Authentication authentication) throws IOException {
		NoticeDto dbnotice = new NoticeDto();
		dbnotice.setNoticeId(noticeId);
		dbnotice.setNoticeTitle(noticeTitle);
		dbnotice.setNoticeContent(noticeContent);
		dbnotice.setProjectId(projectId);
		dbnotice.setNoticeUpdateMid(authentication.getName());
		
		if (existingFileIds != null) {
	        for (String fileId : existingFileIds) {
	            noticeService.deleteAttaches(fileId);
	        }
	    }
				
		noticeService.updateNotice(dbnotice);	
		
		FilesDto dbFiles = new FilesDto();
		
		if(noticeAttaches != null) {
			for (MultipartFile file : noticeAttaches) {
				if (!file.isEmpty()) {
					dbFiles.setFileName(file.getOriginalFilename());
					dbFiles.setFileType(file.getContentType());
					dbFiles.setFileData(file.getBytes());
					dbFiles.setRelatedId(noticeId);
					noticeService.insertNoticeAttach(dbFiles);
				}
			}
		}
		return "redirect:/notice/noticeDetail?projectId="+projectId+"&noticeId="+noticeId;
	}
	
	@RequestMapping("/enabledNotice")
	public String enabledNotice(@RequestParam("noticeId")String noticeId, @RequestParam("projectId")String projectId) {
		NoticeDto dbnotice = new NoticeDto();
		dbnotice.setNoticeId(noticeId);
		dbnotice.setNoticeEnabled(false);
		noticeService.enabledNotice(dbnotice);
		return "redirect:/notice/noticeList?projectId="+projectId+"&pageNo=1";
	}
	
	@GetMapping("/downloadFile")
	public void downloadFile(@RequestParam("fileId")String fileId, HttpServletResponse response) throws Exception {
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
