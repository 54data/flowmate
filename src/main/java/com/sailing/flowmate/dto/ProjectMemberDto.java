package com.sailing.flowmate.dto;

import lombok.Data;

@Data
public class ProjectMemberDto {
	private String projectId;
	private String memberId;
	private boolean projectMemberEnabled;
	
	private String memberName;//멤버 이름 조회 용
}
