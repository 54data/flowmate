package com.sailing.flowmate.dao;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sailing.flowmate.dto.MemberDto;

@Mapper
public interface MemberDao {

	public MemberDto selectByMemberId(String username);

	public int updateMemberEnabled(MemberDto member);

	public int insert(MemberDto member);

	public List<MemberDto> selectActiveMembers(String memberId);

	public MemberDto getMember(String userId);

	public void updateInfo(MemberDto member);

	public int updatePwd(MemberDto member);

	public void deactiveMember(String memberId);

	public void updateMemberByAdmin(MemberDto member);

	public List<MemberDto> getMembersForAdmin(@Param("memberStatus")boolean memberStatus, @Param("memberEnabled")boolean memberEnabled);

	public MemberDto getMemberWithCode(String memberId);

	public void deleteMember(String memberId);
}
