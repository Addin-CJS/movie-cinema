package com.dealim.security.config;


import com.dealim.security.error.CustomAuthenticationFailureHandler;
import com.dealim.security.oauth.OAuth2CustomDetailsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
@Slf4j
@EnableGlobalMethodSecurity(securedEnabled = true)
public class SecurityConfig {

    private final OAuth2CustomDetailsService oAuth2CustomDetailsService;
    public SecurityConfig(OAuth2CustomDetailsService oAuth2CustomDetailsService) {
        this.oAuth2CustomDetailsService = oAuth2CustomDetailsService;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        return http
                .csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers(PathRequest.toStaticResources().atCommonLocations()).permitAll()
                        .requestMatchers("/**","/member/**").permitAll()
                        .anyRequest().authenticated())
                .formLogin((form) -> form
                        .loginPage("/member/login").permitAll()
                        .failureHandler(new CustomAuthenticationFailureHandler()) // 로그인 실패시 에러처리
                        .permitAll())
                .logout(logout -> logout
                        .logoutSuccessUrl("/member/login")
                        .invalidateHttpSession(true))
                .oauth2Login(oauth2 -> oauth2
                        .userInfoEndpoint(userInfoEndpoint -> userInfoEndpoint
                                .userService(oAuth2CustomDetailsService))
                        .defaultSuccessUrl("/", true))
                .build();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}