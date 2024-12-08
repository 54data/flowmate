package com.sailing.flowmate.dao;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sailing.flowmate.dto.FilesDto;
import com.sailing.flowmate.dto.IssueDto;
import com.sailing.flowmate.dto.MemberDto;
import com.sailing.flowmate.dto.ProjectDto;
import com.sailing.flowmate.dto.ProjectMemberDto;
import com.sailing.flowmate.dto.ProjectStepDto;
import com.sailing.flowmate.dto.TaskDto;

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

	public ProjectDto selectProjectTaskCnt(String projectId);

	public List<String> selectProjectMemberList(@Param("projectId") String projectId, @Param("memberId") String memberId);

	public List<FilesDto> selectProjectFileList(String projectId);

	public List<TaskDto> selectProjectTaskList(String projectId);

	public int updateProjectMemberData(@Param("projectId") String projectId, @Param("projectMemberList") List<String> projectMemberList, @Param("memberId") String memberId);

	public int insertProjectNewMember(ProjectMemberDto projectMemberDto);

	public boolean selectProjectMemberExists(ProjectMemberDto projectMemberDto);

	public int updateProjectMemberEnabled(ProjectMemberDto projectMemberDto);

	public int updateProjectStep(ProjectStepDto projectStepDto);

	public int UpdateProjectStepEnabled(@Param("projectId") String projectId, @Param("stepIdList") List<String> stepIdList, @Param("memberId") String memberId);

	public int updateProject(ProjectDto projectData);

	public List<ProjectStepDto> selectProjectStepTaskCnt(String projectId);

	public int updateProjectDataEnabled(@Param("projectId") String projectId, @Param("projectUpdateMid") String projectUpdateMid);

	public List<IssueDto> selectProjectIssueList(String projectId);

	public List<MemberDto> selectProjectMember(String projectId);

	public List<ProjectMemberDto> selectProjectMemberManage(String projectId);

	public int updateProjectMemberManageEnabled(ProjectMemberDto projectMemberDto);

	public ProjectDto selectMyProjectStatsById(@Param("projectId") String projectId, @Param("memberId") String memberId);

	public List<ProjectStepDto> selectProjectStepStats(String projectId);

	public IssueDto selectIssueStats(String projectId);

	public List<MemberDto> selectProjectMemberTaskStats(String projectId);

	public ProjectDto selectProjectTaskStats(String projectId);

	public int updateProjectPlanState();
}
