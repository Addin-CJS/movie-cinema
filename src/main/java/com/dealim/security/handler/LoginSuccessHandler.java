package com.dealim.security.handler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import java.io.IOException;

@Slf4j
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

    private RequestCache requestCache = new HttpSessionRequestCache();
    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
        SavedRequest savedRequest = requestCache.getRequest(request, response);

        log.info("{}", request.getSession().getAttribute("PREVIOUS_URL"));
        // savedRequest가 null인 경우, 세션에서 이전 페이지 URL 검색
        if (savedRequest == null) {
            String fallbackUrl = "/";
            // 세션에서 이전 페이지 URL을 가져옴
            String previousPage = (String) request.getSession().getAttribute("PREVIOUS_URL");
            if (previousPage != null) {
                // 이전 페이지가 존재하면 리다이렉트
                redirectStrategy.sendRedirect(request, response, previousPage);
            } else {
                // 이전 페이지가 없으면 기본 페이지로 리다이렉트
                redirectStrategy.sendRedirect(request, response, fallbackUrl);
            }
        } else {
            // 사용자가 처음 요청했던 페이지로 리다이렉트
            String targetUrl = savedRequest.getRedirectUrl();
            redirectStrategy.sendRedirect(request, response, targetUrl);
        }
    }
}

