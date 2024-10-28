package com.sailing.flowmate.dao;
import org.apache.ibatis.annotations.Mapper;

import com.sailing.flowmate.dto.ProjectDto;
import com.sailing.flowmate.dto.ProjectMemberDto;

@Mapper
public interface ProjectDao {

	public int getProjectNum();
	
	public int insertProject(ProjectDto projectDto);

	public int insertProjectMember(ProjectMemberDto projectMemberDto);

}
