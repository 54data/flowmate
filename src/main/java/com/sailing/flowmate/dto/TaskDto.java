package com.sailing.flowmate.dto;

import lombok.Data;

@Data
public class TaskDto {
	
	private String taskId;
	private String projectId;
	private String memberId;
	private String taskStep;
	private String taskName;
	private String taskPriority;
	private String taskState;
	private String taskStartDate;
	private String taskDueDate;
	private String taskEndDate;
	private String taskContent;
	private String taskRegdate;
	private boolean taskEnabled;
	private String stepStartDate;
	private String stepDueDate;
	private String taskUpdateDate;
	private String taskUpdateMid;
	private String taskLog;
	
	private String fileId;
	private String fileName;
	private String fileType;
	private byte[] fileData;	
	
	private String memberName;
}
