package com.sailing.flowmate.security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.sailing.flowmate.dao.MemberDao;
import com.sailing.flowmate.dto.MemberDto;

@Service
public class CustomUserDetailsService implements UserDetailsService {
	@Autowired
	private MemberDao memberDao;
	
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberDto member = memberDao.selectByUserId(username);
		if (member == null) {
			throw new UsernameNotFoundException("Bad username");
		}
		
	    if (!member.isMemberEnabled()) {
	    	member.setMemberEnabled(true);
	    	memberDao.updateMemberEnabled(member);
	    }
		
		List<GrantedAuthority> authorities = new ArrayList<>();
		authorities.add(new SimpleGrantedAuthority("ROLE_" + member.getCodeName())); 
		
		UserDetails userDetails = new CustomUserDetails(member, authorities);
		return userDetails;
	}
}
