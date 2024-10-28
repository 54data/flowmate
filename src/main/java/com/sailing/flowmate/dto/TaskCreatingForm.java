package com.sailing.flowmate.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class TaskCreatingForm {
	
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
	
	private MultipartFile[] taskAttach;

}
