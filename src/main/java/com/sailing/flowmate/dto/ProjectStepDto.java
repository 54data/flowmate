package com.sailing.flowmate.dto;

import lombok.Data;

@Data
public class ProjectStepDto {
	private String stepId;
	private String projectId;
	private String stepName;
	private String stepStartDate;
	private String stepDueDate;
	private String stepUpdateDate;
	private String stepUpdateMid;
	private boolean stepEnabled;
}
