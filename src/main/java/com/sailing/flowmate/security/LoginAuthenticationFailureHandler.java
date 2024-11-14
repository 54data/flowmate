package com.sailing.flowmate.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {

        String errorMessage = "";
        String memberId = request.getParameter("memberId");
        log.info("로그인실패핸들러 : " + memberId);
        
        HttpSession session = request.getSession();
        session.setAttribute("memberId", memberId);
        
        if (exception instanceof BadCredentialsException) {
            errorMessage = "아이디와 비밀번호를 정확히 입력해주세요.";
        }

        session.setAttribute("errorMessage", errorMessage);
        
        String redirectUrl = "/account/loginForm";
        getRedirectStrategy().sendRedirect(request, response, redirectUrl);
	
	}
}
