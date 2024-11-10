package com.sailing.flowmate.dto;

import lombok.Data;

@Data
public class ProjectMemberDto {
	private String projectId;
	private String memberId;
	private boolean projectMemberEnabled;
	
	// 작업 멤버 조회용	
	private String memberName;
	private String memberRank; 
	private String memberDept; 
	private String memberRole; 
	private String fmtMemberEnabled;
}
