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
	
	private int doneStepTaskCnt;
	private int totalStepTaskCnt;
	private double stepProgress;
	private int totalTaskCnt;
	private int inprogressTaskCnt;
	private int tbTaskCnt;
	private int holdTaskCnt;
	private int doneTaskCnt;
}
