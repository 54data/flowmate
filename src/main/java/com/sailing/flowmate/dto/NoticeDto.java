package com.sailing.flowmate.dto;

import lombok.Data;

@Data
public class NoticeDto {
	private int noticeNum;
	private int noticeNewNo;
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
	
	private String fileId;
	private String fileName;
	private String fileType;
	private byte[] fileData;
	
}
