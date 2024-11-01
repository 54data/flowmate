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

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CustomUserDetailsService implements UserDetailsService {
	@Autowired
	private MemberDao memberDao;
	
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		MemberDto member = memberDao.selectByMemberId(username);
		if (member == null) {
			log.info("존재하지 않는 회원입니다.");
			throw new UsernameNotFoundException("존재하지 않는 회원입니다.");
		}
				
	    if (!member.isMemberEnabled()) {
			log.info("비활성화된 회원입니다.");
	        throw new DisabledException("비활성화된 회원입니다.");
	    }
	    
	    if (!member.isMemberStatus()) {
			log.info("승인 대기중입니다.");
	        throw new DisabledException("승인 대기중입니다.");
	    }

		List<GrantedAuthority> authorities = new ArrayList<>();
		authorities.add(new SimpleGrantedAuthority("ROLE_" + member.getCodeName())); 
		
		UserDetails userDetails = new CustomUserDetails(member, authorities);
		return userDetails;
	}
}
