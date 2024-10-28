package com.sailing.flowmate.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sailing.flowmate.dao.ProjectDao;
import com.sailing.flowmate.dto.ProjectDto;
import com.sailing.flowmate.dto.ProjectMemberDto;
import com.sailing.flowmate.dto.ProjectStepDto;

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
	public void createProjectStep(ProjectDto projectDto, List<Map<String, String>> projectStepList) {
		String projectId = projectDto.getProjectId();
		ProjectStepDto projectStepDto = new ProjectStepDto();
		for (Map<String, String> stepInfo : projectStepList) {
			int stepNum = projectDao.getStepNum();
			projectStepDto.setStepId("STEP-" + stepNum);
			projectStepDto.setProjectId(projectId);
			projectStepDto.setStepName(stepInfo.get("stepName"));
			projectStepDto.setStepStartDate(stepInfo.get("stepStartDate"));
			projectStepDto.setStepDueDate(stepInfo.get("stepDueDate"));
			projectDao.insertProjectStep(projectStepDto);
		}
	}
}
