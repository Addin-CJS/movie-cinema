//package com.dealim.security.config;
//
//import com.dealim.security.handler.PreLoginInterceptor;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
//import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
//
//@Configuration
//public class WebMvcConfig implements WebMvcConfigurer {
//    @Autowired
//    private PreLoginInterceptor preLoginInterceptor;
//
//    @Override
//    public void addInterceptors(InterceptorRegistry registry) {
//        registry.addInterceptor(preLoginInterceptor)
//                .addPathPatterns("/**")
//                .excludePathPatterns("/member/login", "/resources/**"); // 로그인 페이지와 리소스 요청은 제외
//    }
//}
