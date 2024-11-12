package com.sailing.flowmate.dto;

import lombok.Data;

@Data
public class ProjectDto {
	private String projectId;
	private String memberId;
	private String memberName;
	private String projectName;	
	private String projectStartDate;
	private String projectDueDate;
	private String projectEndDate;
	private String projectContent;
	private boolean projectEnabled;
	private String projectRegdate;
	private String projectUpdateDate;
	private String projectUpdateMid;
	private String projectState;
	
	private double projectProgress;
	private int projectMcnt;
	private int totalTaskCnt;
	private int doneTaskCnt;
	
	private int myTotalTaskCnt;
	private int myInprogressTaskCnt;
	private int myInprogressTaskRatio;
	private int myTbTaskCnt;
	private int myTbTaskRatio;
	private int myDoneTaskCnt;
	private int myDoneTaskRatio;
	private int myHoldTaskCnt;
	private int myHoldTaskRatio;
	private int myTotalIsuCnt;
	
	private int inprogressProjTaskCnt;
	private int doneProjTaskCnt;
	private int tbProjTaskCnt;
	private int holdProjTaskCnt;
	private int delayProjTaskCnt;
}
