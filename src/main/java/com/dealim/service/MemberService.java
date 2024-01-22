package com.dealim.service;

import com.dealim.domain.Member;
import com.dealim.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class MemberService {
    @Autowired
    MemberRepository memberRepository;


    public Member insertMember(Member member) {

        Member insertMember = memberRepository.save(member);

        return insertMember;
    }

    public boolean idCheck(Long userId) {
        boolean checkId = memberRepository.existsById(userId);

        return  checkId;
    }
}
