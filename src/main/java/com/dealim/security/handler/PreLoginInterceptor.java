//package com.dealim.security.handler;
//
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import org.springframework.stereotype.Component;
//import org.springframework.web.servlet.HandlerInterceptor;
//
//@Component
//public class PreLoginInterceptor implements HandlerInterceptor {
//
//    @Override
//    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//        // 현재 요청의 전체 URL 구성
//        String currentUrl = request.getRequestURL().toString();
//        if (request.getQueryString() != null) {
//            currentUrl += "?" + request.getQueryString();
//        }
//
//        // 로그인 페이지로 리다이렉트되기 직전의 URL을 세션에 저장
//        // 로그인 페이지나 리소스 요청을 제외하고 저장
//        if (!currentUrl.contains("/member/login") && !currentUrl.contains("/resources")) {
//            request.getSession().setAttribute("PREVIOUS_URL", currentUrl);
//        }
//
//        return true;
//    }
//}
