package com.dealim.security.error;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import java.io.IOException;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
        String errorMessage;
        if (exception instanceof DisabledException) {
            errorMessage = "탈퇴한 계정입니다. 관리자에게 문의하세요.";
        } else {
            errorMessage = "로그인 실패. 아이디 또는 비밀번호를 확인하세요.";
        }

        request.getSession().setAttribute("SPRING_SECURITY_LAST_EXCEPTION", errorMessage);
        response.sendRedirect("/member/login?error=true");
    }
}