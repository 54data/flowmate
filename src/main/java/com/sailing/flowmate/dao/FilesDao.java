package com.sailing.flowmate.dao;
import org.apache.ibatis.annotations.Mapper;

import com.sailing.flowmate.dto.FilesDto;

@Mapper
public interface FilesDao {

	public int insertFiles(FilesDto filesDto);

}
