package com.sailing.flowmate.dto;

import lombok.Data;

@Data
public class ProjectDto {
	private String projectId;
	private String memberId;
	private String projectName;
	private String projectStartDate;
	private String projectDueDate;
	private String projectEndDate;
	private String projectContent;
	private boolean projectEnabled;
	private String projectRegdate;
	private String projectUpdateDate;
	private String projectUpdateMid;
	
	private boolean projectMemberEnabled;
	
	
}
