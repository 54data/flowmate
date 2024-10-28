package com.sailing.flowmate.dao;
import org.apache.ibatis.annotations.Mapper;

import com.sailing.flowmate.dto.ProjectDto;
import com.sailing.flowmate.dto.ProjectMemberDto;
import com.sailing.flowmate.dto.ProjectStepDto;

@Mapper
public interface ProjectDao {

	public int getProjectNum();
	
	public int insertProject(ProjectDto projectDto);

	public int insertProjectMember(ProjectMemberDto projectMemberDto);

	public int getStepNum();

	public int insertProjectStep(ProjectStepDto projectStepDto);

}
