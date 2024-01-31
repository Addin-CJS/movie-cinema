package com.dealim.service;

import com.dealim.domain.Member;
import com.dealim.dto.MyPageMember;
import com.dealim.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;


@Service
public class MemberService {
    @Autowired
    MemberRepository memberRepository;


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

}
