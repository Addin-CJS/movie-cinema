package com.dealim.security.custom;

import com.dealim.domain.Member;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.oauth2.core.user.OAuth2User;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Getter
@Slf4j
public class CustomUserDetails implements UserDetails, OAuth2User {
    private Member member;
    private Map<String, Object> attributes;

    public CustomUserDetails(Member member){
        this.member = member;
    }

    public CustomUserDetails(Member member, Map<String, Object> attributes) {
        this.member = member;
        this.attributes = attributes;
    }
    // TODO: member의 roleList를 읽을때 하나의 트래잭션에서 일어나지 않기 때문에 LazyInitializationException이 발생, Lazy->Eager로 변경(@Transactional은 서비스에서 사용해야 하기 때문에 적용 불가)
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> authorities = member.getRoles().stream()
                .map(role -> new SimpleGrantedAuthority(role.getRoleName()))
                .collect(Collectors.toList());
        return authorities;
    }

    @Override
    public String getPassword() {
        return member.getPassword();
    }

    @Override
    public String getUsername() {
        return member.getUsername();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        Character isWithdrawn = member.getIsWithdrawn();
        Boolean result = true;

        if (isWithdrawn.equals('Y')) {
            result = false;
        }

        if (isWithdrawn.equals('N')){
            result = true;
        }

        return result;
    }

    @Override
    public String getName() {
        return (String) attributes.get("name");
    }

    @Override
    public Map<String, Object> getAttributes() {
        return attributes;
    }
}
