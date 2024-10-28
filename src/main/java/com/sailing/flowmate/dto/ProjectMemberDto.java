package com.sailing.flowmate.dto;

import lombok.Data;

@Data
public class ProjectMemberDto {
	private String projectId;
	private String memberId;
	private boolean projectMemberEnabled;
}
