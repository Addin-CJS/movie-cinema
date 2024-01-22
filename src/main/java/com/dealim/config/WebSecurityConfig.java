package com.dealim.config;

import jakarta.servlet.DispatcherType;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class WebSecurityConfig {
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf((csrf) -> csrf.disable())
                .cors((cors) -> cors.disable())
                .authorizeHttpRequests(request -> request
                        .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
                        .requestMatchers("/**").permitAll() // 개발동안에만
                        .requestMatchers("/layouts/**").permitAll()
                        .requestMatchers("/css/**","/js/**","/img/**").permitAll()
                        .requestMatchers("/member/**").hasAnyRole("USER","ADMIN")
                        .requestMatchers("/admin/**").hasAnyRole("ADMIN")
                        .anyRequest().authenticated()
                );

        http.formLogin((formLogin)->
                formLogin
                        .loginPage("/member/login")
                        .successForwardUrl("/")
                        .permitAll());

//        http.formLogin((formLogin)->
//                formLogin
//                        .loginPage("/loginForm")
//                        .loginProcessingUrl("/loginProc")
//                        .usernameParameter("username")
//                        .passwordParameter("password")
//                        .permitAll());

        http.logout((logout)->
                logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/")
                        .permitAll());

        return http.build();
    }

    @Bean
    public UserDetailsService users() {
        UserDetails user = User.builder()
                .username("USER")
                .password(pEncoder().encode("1234"))
                .roles("USER")
                .build();

        UserDetails admin = User.builder()
                .username("ADMIN")
                .password(pEncoder().encode("1234"))
                .roles("USER","ADMIN")
                .build();

        return new InMemoryUserDetailsManager(user, admin);
    }

    public PasswordEncoder pEncoder() {
        return PasswordEncoderFactories.createDelegatingPasswordEncoder();
    }

}
