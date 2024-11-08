package com.sailing.flowmate.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sailing.flowmate.dao.ApprovalDao;
import com.sailing.flowmate.dao.TaskDao;
import com.sailing.flowmate.dto.ApprovalDto;
import com.sailing.flowmate.dto.TaskDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ApprovalService {
	
	@Autowired
	ApprovalDao approvaldao;
	
	@Autowired
	TaskDao taskdao;
	
	@Transactional
	public void insertApprInfo(ApprovalDto apprData) {
		int apprNewNo = approvaldao.selectApprNewNo();
		String approvalId = apprData.getTaskId() + "-APPR-" + apprNewNo;
		apprData.setApprovalId(approvalId);
		approvaldao.insertApprData(apprData);
	}

	public List<ApprovalDto> getApprovals(String projectId) {
		List<ApprovalDto> approvals = approvaldao.getApprovalList(projectId);
		return approvals;
	}
	
	public TaskDto getTaskInfoByAppr(String taskId) {
		TaskDto taskInfo = taskdao.getTaskByTaskId(taskId);
		return taskInfo;
	}

	public void updateApprResp(Map<String, Object> params) {
		approvaldao.updateApprRespResult(params);
	}

	public List<ApprovalDto> getConfirmedApprovals(String projectId) {
		List<ApprovalDto> approvals = approvaldao.getConfirmedApprovalList(projectId);
		return approvals;
	}

	public List<ApprovalDto> getWaitingApprovals(String projectId) {
		List<ApprovalDto> approvals = approvaldao.getWaitingApprovalList(projectId);
		return approvals;
	}

	public boolean chkApprRequested(String taskId) {
		List<ApprovalDto> approvalsResult = approvaldao.getapprRespResult(taskId);
		boolean result = true;
		for(ApprovalDto approval : approvalsResult) {
			if(approval.getApprovalResponseResult() == null) {
				result = false;
			}
		}
		return result;
	}
}
