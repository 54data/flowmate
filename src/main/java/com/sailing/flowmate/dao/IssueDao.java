package com.sailing.flowmate.dao;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sailing.flowmate.dto.IssueCommentDto;
import com.sailing.flowmate.dto.IssueDto;
import com.sailing.flowmate.dto.MemberDto;

@Mapper
public interface IssueDao {

	public List<MemberDto> selectIssueMembers(String projectId);

	public int selectIssueNum();

	public int selectFmtIssueSeq(String projectId);
	
	public int insertIssue(IssueDto issueDto);

	public List<IssueDto> selectProjectIssues(String projectId);

	public double selectProjectIssueProgress(String projectId);

	public double selectTaskIssueProgress(String taskId);

	public IssueDto selectIssueById(String issueId);

	public int updateIssueById(IssueDto issueDto);
	
	public int updateIssueDataEnabled(@Param("issueId") String issueId, @Param("issueUpdateMid") String issueUpdateMid);

	public List<IssueDto> selectTaskIssues(String taskId);

	public List<IssueDto> selectMyIssueList(String memberId);
	
	public void enrollIssCmt(IssueCommentDto isscmt);

	public int selectNewNo();
	
	public List<IssueCommentDto> leadingIssCmts(String issueId);

	public void updateIssCmt(IssueCommentDto isscmt);

	public void deleteIssCmt(String commentId);

}
