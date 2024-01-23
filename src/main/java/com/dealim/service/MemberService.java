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

<<<<<<< HEAD
=======
    public Optional<Member> selectMemberById(Member member) {
        Optional<Member> loginUser = memberRepository.findByUsername(member.getUsername());
>>>>>>> 00d9431d25a797d81840357dcf209d5a35570791

    public boolean idCheck(String username) {

        return memberRepository.existsByUsername(username);

    }

        public Optional<Member> selectMemberById (Member member){
            Optional<Member> loginUser = memberRepository.findById(member.getMemberId());

            if (loginUser.isPresent()) {
                return loginUser;
            } else {
                return null;
            }
        }
    }
