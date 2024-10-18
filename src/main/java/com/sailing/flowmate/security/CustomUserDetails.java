package com.sailing.flowmate.security;

import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.sailing.flowmate.dto.MemberDto;

public class CustomUserDetails extends User {
	private MemberDto member;
	
	public CustomUserDetails(MemberDto member, List<GrantedAuthority> authorities) {
		super(member.getMemberId(), member.getMemberPw(), member.isMemberEnabled(), true, true, true, authorities);
		this.member = member;
	}
	
	public MemberDto getMember() {
		return member;
	}
	
    public String getPassword() {
        return super.getPassword();
    }
}
