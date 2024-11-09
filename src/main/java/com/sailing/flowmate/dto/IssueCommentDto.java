package com.sailing.flowmate.dto;

import lombok.Data;

@Data
public class IssueCommentDto {
	private String issueCommentId;
	private String issueId;
	private String projectId;
	private String memberId;
	private String issueCommentParentId;
	private String issueCommentRegdate;
	private String issueCommentContent;
}
