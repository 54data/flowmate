package com.sailing.flowmate.dao;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sailing.flowmate.dto.MemberDto;

@Mapper
public interface MemberDao {

	public MemberDto selectByMemberId(String username);

	public int updateMemberEnabled(MemberDto member);

	public int insert(MemberDto member);

	public List<MemberDto> getProjectMembers();

	public MemberDto getMember(String userId);

	public void updateInfo(MemberDto member);

	public int updatePwd(MemberDto member);

	public void deactiveMember(String memberId);

	public void updateMemberStatus(MemberDto member);

	public List<MemberDto> getMembersByStatus(int statusNum);
}
