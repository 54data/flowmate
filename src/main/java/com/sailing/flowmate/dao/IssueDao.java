package com.sailing.flowmate.dao;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sailing.flowmate.dto.IssueDto;
import com.sailing.flowmate.dto.MemberDto;

@Mapper
public interface IssueDao {

	public List<MemberDto> selectIssueMembers(String projectId);

	public int selectIssueNum();

	public int selectFmtIssueSeq(String projectId);
	
	public int insertIssue(IssueDto issueDto);
	
}
