package com.dealim.service;

import com.dealim.domain.Member;
import com.dealim.dto.MyPageMember;
import com.dealim.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;


@Service
public class MemberService {
    @Autowired
    MemberRepository memberRepository;

    @Autowired
    PasswordEncoder pEncoder;


    public Member insertMember(Member member) {

        return memberRepository.save(member);
    }

    public boolean idCheck(String username) {

        return memberRepository.existsByUsername(username);

    }

    public Optional<Member> selectMemberByUsername(Member member) {

        return memberRepository.findByUsername(member.getUsername());
    }

    public Member updateMember(MyPageMember myPageMember, Member loginUser) {
        Member member = memberRepository.findById(loginUser.getMemberId()).orElse(null);

        if (member != null) {
            member.setMemberId(loginUser.getMemberId());
            member.setUsername(myPageMember.getUsername());
            member.setPassword(loginUser.getPassword());
            member.setName(myPageMember.getName());
            member.setEmail(myPageMember.getEmail());
            member.setPhoneNumber(myPageMember.getPhoneNumber());
            member.setHomeAddress(myPageMember.getHomeAddress());

            memberRepository.save(member);
        }
        return member;
    }

    public Member findIdByNameAndPhoneNumber(String name, String phoneNumber) {
        Member findId = memberRepository.findByNameAndPhoneNumber(name, phoneNumber);
        return findId;
    }

    public Member findIdByUserNameAndNameAndPhoneNumber(String username, String name, String phoneNumber) {
        Member findMemberForRestPw = memberRepository.findByUserNameAndNameAndPhoneNumber(username, name, phoneNumber);
        return findMemberForRestPw;
    }

    public boolean findMemberForWithdraw(String username, String name, String password) {
        Member findMemberForWithdraw = memberRepository.findMember(username, name);
        if (findMemberForWithdraw != null) {
            // 비밀번호 검증
            boolean matches = pEncoder.matches(password, findMemberForWithdraw.getPassword());
            return matches;
        }
        return false;
    }

    public boolean withdrawMemberOk(String username, String password) {
        Optional<Member> optionalMember = memberRepository.findByUsername(username);
        System.out.println("옵셔널멤버" + optionalMember);
        if (optionalMember.isPresent()) {
            Member member = optionalMember.get();

            boolean matches = pEncoder.matches(password, member.getPassword());

            if (matches) {
                member.setIsWithdrawn('Y');
                member.setMemberId(member.getMemberId());
                member.setUsername(member.getUsername());
                member.setName(member.getName());
                member.setEmail(member.getEmail());
                member.setPhoneNumber(member.getPhoneNumber());
                member.setHomeAddress(member.getHomeAddress());
                memberRepository.save(member);
                return true;
            }
        }
        return false;
    }
}