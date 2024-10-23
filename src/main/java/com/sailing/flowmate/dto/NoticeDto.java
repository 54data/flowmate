package com.sailing.flowmate.dto;

import lombok.Data;

@Data
public class NoticeDto {
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
	
	private String fileId;
	private String fileName;
	private String fileType;
	private byte[] fileData;
	
}
