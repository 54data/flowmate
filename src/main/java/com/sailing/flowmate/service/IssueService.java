package com.sailing.flowmate.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.sailing.flowmate.dao.FilesDao;
import com.sailing.flowmate.dao.IssueDao;
import com.sailing.flowmate.dto.FilesDto;
import com.sailing.flowmate.dto.IssueDto;
import com.sailing.flowmate.dto.MemberDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class IssueService {
	@Autowired
	IssueDao issueDao;
	
	@Autowired
	FilesDao fileDao;
	
	public List<MemberDto> getMembers(String projectId) {
		List<MemberDto> memberList = issueDao.selectIssueMembers(projectId);
		return memberList;
	}
	
	@Transactional
	public void createNewIssue(IssueDto issueDto) {
		int issueNum = issueDao.selectIssueNum();
		String projectId = issueDto.getProjectId();
		String issueId = projectId + "-ISU-" + issueNum;
		issueDto.setIssueId(issueId);
		issueDto.setProjectId(projectId);
		if (issueDto.getTaskId() == "") {			
			issueDto.setTaskId(null);
		}
		int fmtIssueNum = issueDao.selectFmtIssueSeq(projectId) + 1;
		String fmtIssueId = "ISU-" + fmtIssueNum;
		issueDto.setFmtIssueId(fmtIssueId);
		issueDao.insertIssue(issueDto);
	}
	
	@Transactional
	public void addIssueFiles(String issueId, MultipartFile[] issueFiles) throws IOException {
		FilesDto filesDto = new FilesDto();
		for (MultipartFile file : issueFiles) {
			filesDto.setRelatedId(issueId);
			filesDto.setFileType(file.getContentType());
			filesDto.setFileName(file.getOriginalFilename());
			filesDto.setFileData(file.getBytes());
			fileDao.insertFiles(filesDto);
		}
	}

	public List<IssueDto> getProjectIssues(String projectId) {
		List<IssueDto> projectIssueList = issueDao.selectProjectIssues(projectId);
		return projectIssueList;
	}

	public double getIssueProgress(String projectId) {
		double issueProgress = issueDao.selectIssueProgress(projectId);
		return issueProgress;
	}

	public IssueDto getIssueData(String issueId) {
		IssueDto issueDto = issueDao.selectIssueById(issueId);
		return issueDto;
	}

	public List<FilesDto> getIssueFileList(String issueId) {
		List<FilesDto> issueFileList = fileDao.selectIssueFileList(issueId);
		return issueFileList;
	}

	public FilesDto getIssueFile(String fileId) {
		FilesDto file = fileDao.selectFile(fileId);
		return file;
	}

	public void deleteIssueFileList(String issueId, List<String> deleteIssueFileList) {
		fileDao.deleteIssueFileData(issueId, deleteIssueFileList);
	}

	public void updateIssueData(IssueDto issueDto) {
		issueDao.updateIssueById(issueDto);
	}

	public void updateIssueEnabled(String issueId) {
		issueDao.updateIssueDataEnabled(issueId);
	}
}