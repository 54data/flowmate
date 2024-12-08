package com.sailing.flowmate.dto;

import lombok.Data;

@Data
public class IssueDto {
	private String issueId;
	private String projectId;
	private String memberId;
	private String taskId;
	private String issueTitle;
	private String issueRegdate;
	private String issueEndDate;
	private String issueState;
	private String issueContent;
	private Boolean issueEnabled;
	private String issueUpdateDate;
	private String issueUpdateMid;
	private String fmtIssueId;
	
	private String memberName;
	private double issueProgress;
	private String projectPmId;
	private String relatedTask;
	private String fmtIssueRegdate;
	private String projectName;
	private int unresolvedIsu;
	private int resolvedIsu;
}
