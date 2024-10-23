package com.sailing.flowmate.dao;
import org.apache.ibatis.annotations.Mapper;

import com.sailing.flowmate.dto.MemberDto;

@Mapper
public interface MemberDao {

	public MemberDto selectByMemberId(String username);

	public int updateMemberEnabled(MemberDto member);

	public int insert(MemberDto member);
}
