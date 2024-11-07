package com.sailing.flowmate.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sailing.flowmate.dao.IssueDao;
import com.sailing.flowmate.dto.IssueDto;
import com.sailing.flowmate.dto.MemberDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class IssueService {
	@Autowired
	IssueDao issueDao;
	
	public List<MemberDto> getMembers(String projectId) {
		List<MemberDto> memberList = issueDao.selectIssueMembers(projectId);
		return memberList;
	}
	
	@Transactional
	public String createNewIssue(IssueDto issue) {
		int issueNum = issueDao.selectIssueNum();
		String projectId = issue.getProjectId();
		String issueId = projectId + "-ISU-" + issueNum;
		IssueDto issueDto = new IssueDto();
		issueDto.setIssueId(issueId);
		issueDto.setProjectId(projectId);
		issueDto.setMemberId(issue.getMemberId());
		if (issue.getTaskId() == "") {			
			issueDto.setTaskId(null);
		}
		issueDto.setIssueTitle(issue.getIssueTitle());
		issueDto.setIssueRegdate(issue.getIssueRegdate());
		issueDto.setIssueContent(issue.getIssueContent());
		int fmtIssueNum = issueDao.selectFmtIssueSeq(projectId) + 1;
		String fmtIssueId = "ISU-" + fmtIssueNum;
		issueDto.setFmtIssueId(fmtIssueId);
		issueDao.insertIssue(issueDto);
		return fmtIssueId;
	}
}