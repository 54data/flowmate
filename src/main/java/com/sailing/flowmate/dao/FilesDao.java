package com.sailing.flowmate.dao;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sailing.flowmate.dto.FilesDto;
import com.sailing.flowmate.dto.NoticeDto;
import com.sailing.flowmate.dto.TaskDto;

@Mapper
public interface FilesDao {

	public int insertFiles(FilesDto filesDto);

	public int insertTaskAttach(TaskDto taskDto);

	public List<FilesDto> selectTaskAttach(String relatedId);

	public int deleteTaskAttach(String fileId);
	
	public int deleteProjectFileData(@Param("projectId") String projectId, @Param("fileIdList") List<String> fileIdList);
	
	public List<FilesDto> getNoticeFiles(String relatedId);

	public FilesDto downTaskFile(String fileId);
}
