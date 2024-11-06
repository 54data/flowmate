package com.sailing.flowmate.dto;

import lombok.Data;

@Data
public class MessageDto {
	private String messageId;
	private String messageReceiverId;
	private String messageSenderId;
	private String messageContent;
	private String messageSendDate;
	private String messageReadDate;
	
	private String fileId;
	private String fileName;
	private String fileType;
	private byte[] fileData;
}
