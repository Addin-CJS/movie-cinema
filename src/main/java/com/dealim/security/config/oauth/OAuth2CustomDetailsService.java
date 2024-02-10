package com.dealim.security.config.oauth;

import com.dealim.domain.Member;
import com.dealim.repository.MemberRepository;
import com.dealim.security.custom.CustomUserDetails;
import lombok.RequiredArgsConstructor;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.util.Map;
import java.util.Optional;

@RequiredArgsConstructor
@Service
public class OAuth2CustomDetailsService extends DefaultOAuth2UserService {
    private final MemberRepository memberRepository;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest request) throws OAuth2AuthenticationException {
        OAuth2User oAuth2User = super.loadUser(request);
        String provider = request.getClientRegistration().getRegistrationId();
        String providerId = null;
        String username = null;
        String name = null;
        String email = null;

        if(provider.equals("google")) {
            providerId = oAuth2User.getAttribute("sub");
            name = oAuth2User.getAttribute("name");
            email = oAuth2User.getAttribute("email");
        } else if (provider.equals("kakao")) {
            providerId = oAuth2User.getAttribute("id").toString();
            Map<String, Object> kakaoAccount = oAuth2User.getAttribute("kakao_account");
            if (kakaoAccount != null) {
                username = (String) kakaoAccount.get("nickname");
            }
        }

        username = provider + "_" + providerId;
        Optional<Member> optionalMember = memberRepository.findByUsername(username);
        Member member;

        if(optionalMember.isEmpty()) {
            member = Member.builder()
                    .username(username)
                    .name(name)
                    .email(email)
                    .provider(provider)
                    .providerId(providerId)
                    .build();
            memberRepository.save(member);
        } else {
            member = optionalMember.get();
        }
        return new CustomUserDetails(member, oAuth2User.getAttributes());
    }
}
