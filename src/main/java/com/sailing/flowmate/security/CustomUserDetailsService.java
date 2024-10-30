package com.sailing.flowmate.security;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.DisabledException;
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
		MemberDto member = memberDao.selectByMemberId(username);
		if (member == null) {
			throw new UsernameNotFoundException("존재하지 않는 회원입니다.");
		}
				
	    if (!member.isMemberEnabled()) {
	        throw new DisabledException("비활성화된 회원입니다.");
	    }
	    
	    if (member.getMemberStatus()!=1) {
	        throw new DisabledException("승인 대기중입니다.");
	    }

	    if (member.getMemberStatus()==2) {
	        throw new DisabledException("가입 반려되었습니다.");
	    }

		List<GrantedAuthority> authorities = new ArrayList<>();
		authorities.add(new SimpleGrantedAuthority("ROLE_" + member.getCodeName())); 
		
		UserDetails userDetails = new CustomUserDetails(member, authorities);
		return userDetails;
	}
}
