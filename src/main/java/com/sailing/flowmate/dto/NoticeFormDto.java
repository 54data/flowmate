package com.sailing.flowmate.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class NoticeFormDto {
	private int noticeNum;
	private String memberId;
	private String noticeId;
	private String projectId;
	private String noticeTitle;
	private String noticeContent;
	private String noticeRegdate;
	private int noticeHitnum;
	private boolean noticeEnabled;
	private String noticeUpdateDate;
	private String noticeUpdateMid;
	private MultipartFile[] noticeAttach;
}
