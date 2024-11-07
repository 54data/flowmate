package com.sailing.flowmate.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sailing.flowmate.dao.ApprovalDao;
import com.sailing.flowmate.dto.ApprovalDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ApprovalService {
	
	@Autowired
	ApprovalDao approvaldao;
	
	@Transactional
	public void insertApprInfo(ApprovalDto apprData) {
		int apprNewNo = approvaldao.selectApprNewNo();
		String approvalId = apprData.getTaskId() + "-APPR-" + apprNewNo;
		apprData.setApprovalId(approvalId);
		approvaldao.insertApprData(apprData);
	}

}
