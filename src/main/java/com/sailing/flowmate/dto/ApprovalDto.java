package com.sailing.flowmate.dto;

import lombok.Data;

@Data
public class ApprovalDto {
	private String approvalId;
	private String taskId;
	private String projectId;
	private String requesterId;
	private String responderId;
	private String approvalState;
	private String approvalMessage;
	private String approvalDeniedMessage;
	private String approvalRequestDate;
	private String approvalResponseDate;
	private String approvalResponseResult;
	private int apprNewNo;
	private String taskStepId;
	private String taskName;
	private String stepName;
	private String requesterName;
	private String currentState;
}
