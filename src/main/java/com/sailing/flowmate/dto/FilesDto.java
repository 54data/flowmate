package com.sailing.flowmate.dto;

import lombok.Data;

@Data
public class FilesDto {
	private String fileId;
	private String relatedId; 
	private String fileName;
	private String fileType;
	private byte[] fileData;
	private String fileRegdate;
}
