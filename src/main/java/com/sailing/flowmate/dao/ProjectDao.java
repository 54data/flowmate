package com.sailing.flowmate.dao;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sailing.flowmate.dto.ProjectDto;
import com.sailing.flowmate.dto.ProjectMemberDto;
import com.sailing.flowmate.dto.ProjectStepDto;

@Mapper
public interface ProjectDao {

	public int selectProjectNum();
	
	public int insertProject(ProjectDto projectDto);

	public int insertProjectMember(ProjectMemberDto projectMemberDto);

	public int selectStepNum();

	public int insertProjectStep(ProjectStepDto projectStepDto);

	public ProjectDto selectProject(String projectId);

	public ProjectStepDto selectProjectStep(String projectId);

	public List<ProjectStepDto> selectProjectStepList(String projectId);

	public List<ProjectDto> selectMyProjectList(String memberId);
}
