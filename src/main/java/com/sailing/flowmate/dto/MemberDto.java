package com.sailing.flowmate.dto;

import lombok.Data;

@Data
public class MemberDto {
	private String memberId;
	private int memberRankId;
	private int memberDeptId;
	private int memberRoleId;
	private String memberPw;
	private String memberName;
	private boolean memberEnabled;
	private String memberRegdate;
	private String memberUpdateDate;
	private String codeName;
	
}
