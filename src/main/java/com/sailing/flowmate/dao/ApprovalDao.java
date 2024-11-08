package com.sailing.flowmate.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sailing.flowmate.dto.ApprovalDto;

@Mapper
public interface ApprovalDao {

	public int selectApprNewNo();

	public void insertApprData(ApprovalDto apprData);

	public List<ApprovalDto> getApprovalList(String projectId);

	public void updateApprRespResult(Map<String, Object> params);

	public List<ApprovalDto> getConfirmedApprovalList(String projectId);

	public List<ApprovalDto> getWaitingApprovalList(String projectId);

	public List<ApprovalDto> getapprRespResult(String taskId);

}
