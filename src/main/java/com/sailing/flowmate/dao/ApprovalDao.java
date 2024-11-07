package com.sailing.flowmate.dao;

import org.apache.ibatis.annotations.Mapper;

import com.sailing.flowmate.dto.ApprovalDto;

@Mapper
public interface ApprovalDao {

	public int selectApprNewNo();

	public void insertApprData(ApprovalDto apprData);

}
