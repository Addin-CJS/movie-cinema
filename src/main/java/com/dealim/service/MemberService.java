package com.dealim.service;

import com.dealim.domain.Member;
import com.dealim.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;


@Service
public class MemberService {
    @Autowired
    MemberRepository memberRepository;


    public Member insertMember(Member member) {

        Member insertMember = memberRepository.save(member);

        return insertMember;
    }

    public boolean idCheck(String username) {

        return memberRepository.existsByUsername(username);

    }

    public Optional<Member> selectMemberByUsername(Member member) {

        return memberRepository.findByUsername(member.getUsername());
    }

    public Member updateMember(Member member) {
        return memberRepository.save(member);
    }

    public String findIdByNameAndPhoneNumber(String name, String phoneNumber) {
        return memberRepository.findByNameAndPhoneNumber(name, phoneNumber);
    }

    public Member findIdByUserNameAndNameAndPhoneNumber(String username, String name, String phoneNumber) {
        Member findMemberForRestPw = memberRepository.findByUserNameAndNameAndPhoneNumber(username, name, phoneNumber);
        return findMemberForRestPw;
    }

}
