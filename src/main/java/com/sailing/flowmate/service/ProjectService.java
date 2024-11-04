package com.sailing.flowmate.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.sailing.flowmate.dao.FilesDao;
import com.sailing.flowmate.dao.ProjectDao;
import com.sailing.flowmate.dto.FilesDto;
import com.sailing.flowmate.dto.ProjectDto;
import com.sailing.flowmate.dto.ProjectMemberDto;
import com.sailing.flowmate.dto.ProjectStepDto;
import com.sailing.flowmate.dto.TaskDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Secured("ROLE_DEV")
public class ProjectService {
	@Autowired
	ProjectDao projectDao;
	
	@Autowired
	FilesDao fileDao;
	
	@Transactional
	public void createProjectService(ProjectDto projectDto) {
		int projectNum = projectDao.selectProjectNum();
		projectDto.setProjectId("PROJ-" + projectNum);
		projectDao.insertProject(projectDto);
	}
	
	@Transactional
	public void addProjectMember(String projectId, List<String> projectMemberList) {
		ProjectMemberDto projectMemberDto = new ProjectMemberDto();
		for (String memberId : projectMemberList) {
			projectMemberDto.setMemberId(memberId);
			projectMemberDto.setProjectId(projectId);
			projectDao.insertProjectMember(projectMemberDto);
		}
	}
	
	@Transactional
	public void createProjectStep(String projectId, List<Map<String, String>> projectStepList) {
		ProjectStepDto projectStepDto = new ProjectStepDto();
		for (Map<String, String> stepInfo : projectStepList) {
			int stepNum = projectDao.selectStepNum();
			projectStepDto.setStepId(projectId + "-STEP-" + stepNum);
			projectStepDto.setProjectId(projectId);
			projectStepDto.setStepName(stepInfo.get("stepName"));
			projectStepDto.setStepStartDate(stepInfo.get("stepStartDate"));
			projectStepDto.setStepDueDate(stepInfo.get("stepDueDate"));
			projectDao.insertProjectStep(projectStepDto);
		}
	}

	@Transactional
	public void addProjectFiles(String projectId, MultipartFile[] projectFiles) throws IOException {
		FilesDto filesDto = new FilesDto();
		for (MultipartFile file : projectFiles) {
			filesDto.setRelatedId(projectId);
			filesDto.setFileType(file.getContentType());
			filesDto.setFileName(file.getOriginalFilename());
			filesDto.setFileData(file.getBytes());
			fileDao.insertFiles(filesDto);
		}
	}

	public ProjectDto getProjectDetails(String projectId) {
		ProjectDto projectDto = projectDao.selectProject(projectId);
		return projectDto;
	}

	public List<ProjectStepDto> getProjectStepList(String projectId) {
		List<ProjectStepDto> projectStepList = projectDao.selectProjectStepList(projectId);
		return projectStepList;
	}

	public List<ProjectDto> getMyProjectList(String memberId) {
		List<ProjectDto> myProjectList = projectDao.selectMyProjectList(memberId);
		return myProjectList;
	}

	public ProjectDto getProjectTaskCnt(String projectId) {
		ProjectDto projectTaskCnt = projectDao.selectProjectTaskCnt(projectId);
		return projectTaskCnt;
	}

	public List<String> getProjectMemberList(String projectId, String memberId) {
		List<String> projectMemberList = projectDao.selectProjectMemberList(projectId, memberId);
		return projectMemberList;
	}

	public List<FilesDto> getProjectFileList(String projectId) {
		List<FilesDto> projectFileList = projectDao.selectProjectFileList(projectId);
		return projectFileList;
	}

	public List<TaskDto> getProjectTaskList(String projectId) {
		List<TaskDto> projectTaskList = projectDao.selectProjectTaskList(projectId);
		return projectTaskList;
	}
	
	public void deleteProjectFileList(String projectId, List<String> fileIdList) {
		fileDao.deleteProjectFileData(projectId, fileIdList);
	}

	public void updateProjectMemberList(String projectId, List<String> projectMemberList, String memberId) {
		projectDao.updateProjectMemberData(projectId, projectMemberList, memberId);
		ProjectMemberDto projectMemberDto = new ProjectMemberDto();
		projectMemberDto.setProjectId(projectId);
		for (String projectMemberId : projectMemberList) {
			projectMemberDto.setMemberId(projectMemberId);
			boolean memberExists = projectDao.selectProjectMemberExists(projectMemberDto);
			if (memberExists) {
				projectDao.updateProjectMemberEnabled(projectMemberDto);
			} else {
				projectDao.insertProjectMember(projectMemberDto);
			}
		}
	}

	public void updateProjectStepList(String projectId, List<Map<String, String>> projectStepList, String memberId) {
	    List<String> stepIdList = new ArrayList<>(); 
	    ProjectStepDto projectStepDto = new ProjectStepDto();
	    for (Map<String, String> step : projectStepList) {
	        String stepId = step.get("stepId"); 
	        if (stepId != null) { 
	        	stepIdList.add(stepId); 
	        	projectStepDto.setStepId(stepId);
	        	projectStepDto.setProjectId(projectId);
				projectStepDto.setStepName(step.get("stepName"));
				projectStepDto.setStepStartDate(step.get("stepStartDate"));
				projectStepDto.setStepDueDate(step.get("stepDueDate"));
				projectStepDto.setStepUpdateMid(memberId);
				projectDao.updateProjectStep(projectStepDto);
	        } else {
				int stepNum = projectDao.selectStepNum();
				String newStepId = projectId + "-STEP-" + stepNum;
				projectStepDto.setStepId(newStepId);
				stepIdList.add(newStepId);
				projectStepDto.setProjectId(projectId);
				projectStepDto.setStepName(step.get("stepName"));
				projectStepDto.setStepStartDate(step.get("stepStartDate"));
				projectStepDto.setStepDueDate(step.get("stepDueDate"));
				projectDao.insertProjectStep(projectStepDto);
	        }
	    }
	    projectDao.UpdateProjectStepEnabled(projectId, stepIdList, memberId);
	}

	public void updateProjectData(ProjectDto projectData) {
		projectDao.updateProject(projectData);
	}

	public List<ProjectStepDto> getProjectStepTaskCntList(String projectId) {
		List<ProjectStepDto> projectStepTaskCntList = projectDao.selectProjectStepTaskCnt(projectId);
		return projectStepTaskCntList;
	}

	public void updateProjectEnabled(String projectId) {
		projectDao.updateProjectDataEnabled(projectId);
	}
}