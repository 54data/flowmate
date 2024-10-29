package com.sailing.flowmate.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sailing.flowmate.dao.MemberDao;
import com.sailing.flowmate.dto.MemberDto;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberService {
	public enum JoinResult {
		SUCCESS,
		FAIL_DUPLICATED_USERID
	}

	public enum LoginResult {
		SUCCESS,
		FAIL_MID,
		FAIL_MPASSWORD,
		FAIL_ENABLED
	}
	
	@Autowired
	private MemberDao memberDao;
			
	public JoinResult join(MemberDto member) {
		boolean exist = isMid(member.getMemberId());
		
		if(exist){
			return JoinResult.FAIL_DUPLICATED_USERID;
		}
		
		memberDao.insert(member);
		log.info("실행" + member.toString());
		return JoinResult.SUCCESS;
	}
	
	public boolean isMid(String mid) {
		MemberDto member = memberDao.selectByMemberId(mid);
		
		if(member == null) {
			return false;
		} else {
			return true;
		}
	}
	
	public LoginResult login(MemberDto member){
		MemberDto dbmember = memberDao.selectByMemberId(member.getMemberId());
	
		if(dbmember == null){
			return LoginResult.FAIL_MID;
		}
		
		if(!dbmember.isMemberEnabled()){
			return LoginResult.FAIL_ENABLED;
		}
		
		if(!dbmember.getMemberPw().equals(member.getMemberPw())){
			return LoginResult.FAIL_MPASSWORD;
		}
		
		return LoginResult.SUCCESS;
	}

	public List<MemberDto> getMembers() {
		List<MemberDto> memberList = memberDao.getProjectMembers();
		return memberList;
	}

	public MemberDto getMember(String userId) {
		MemberDto member = memberDao.getMember(userId);
		return member;
	}

	public void updateInfo(MemberDto member) {
		memberDao.updateInfo(member);
	}

}
