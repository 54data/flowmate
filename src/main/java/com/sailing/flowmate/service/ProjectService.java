package com.sailing.flowmate.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sailing.flowmate.dao.ProjectDao;
import com.sailing.flowmate.dto.ProjectDto;
import com.sailing.flowmate.dto.ProjectMemberDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ProjectService {
	@Autowired
	ProjectDao projectDao;
	
	@Transactional
	public void createProjectService(ProjectDto projectDto) {
		int projectNum = projectDao.getProjectNum();
		projectDto.setProjectId("PROJ-" + projectNum);
		projectDao.insertProject(projectDto);
	}
	
	@Transactional
	public void addProjectMember(ProjectDto projectDto, List<String> projectMemberList) {
		String projectId = projectDto.getProjectId();
		ProjectMemberDto projectMemberDto = new ProjectMemberDto();
		for (String memberId : projectMemberList) {
			projectMemberDto.setMemberId(memberId);
			projectMemberDto.setProjectId(projectId);
			projectDao.insertProjectMember(projectMemberDto);
		}
	}
	
	@Transactional
	public void createProjectStep(ProjectDto projectDto, Object object) {
	}
}
