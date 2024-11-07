package com.sailing.flowmate.service;

import java.util.List;

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
}
