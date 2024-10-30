package com.sailing.flowmate.security;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

public class LoginAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
        
        String errorMessage = "계정이 비활성화되어 있습니다.";
        if (exception instanceof DisabledException) {
            errorMessage = "계정이 비활성화되어 있습니다.";
        } else if (exception instanceof BadCredentialsException) {
            errorMessage = "아이디 또는 비밀번호가 일치하지 않습니다.";
        }

        String redirectUrl = "/account/loginForm?errorMessage=" + URLEncoder.encode(errorMessage, "UTF-8");
        getRedirectStrategy().sendRedirect(request, response, redirectUrl);
	}
}
