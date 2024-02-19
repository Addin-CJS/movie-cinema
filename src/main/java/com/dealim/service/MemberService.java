package com.dealim.service;

import com.dealim.domain.Member;
import com.dealim.domain.MemberRole;
import com.dealim.dto.MyPageMember;
import com.dealim.repository.MemberRepository;
import com.dealim.repository.MemberRoleRepository;
import com.dealim.util.CopyBeanUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@Slf4j
public class MemberService {
    @Autowired
    MemberRepository memberRepository;
    @Autowired
    MemberRoleRepository memberRoleRepository;
    @Autowired
    PasswordEncoder pEncoder;

    public List<Member> getAllMembersNotWithdrawn() {
        return memberRepository.findAllByIsWithdrawn('N');
    }

    public Member insertMember(Member member) {
        return memberRepository.save(member);
    }

    public MemberRole setMemberRole(Member member, String role) {
        MemberRole memberRole = MemberRole.builder()
                .member(member)
                .roleName(role)
                .build();
        return memberRoleRepository.save(memberRole);
    }

    public boolean idCheck(String username) {
        return memberRepository.existsByUsername(username);
    }

    public Optional<Member> selectMemberByUsername(Member member) {
        return memberRepository.findByUsername(member.getUsername());
    }

    public Member findById(Long memberId) {
        return memberRepository.findById(memberId).orElseGet(() -> null);
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

    public Member modifyMember(Member repositoryMember, Member updatedMember) throws IllegalAccessException {

        CopyBeanUtil.copyNonNullProperties(repositoryMember, updatedMember);

        return memberRepository.save(updatedMember);
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
            boolean matches = pEncoder.matches(password, findMemberForWithdraw.getPassword());
            return matches;
        }
        return false;
    }

    public boolean withdrawMemberOk(String username, String password) {
        Optional<Member> optionalMember = memberRepository.findByUsername(username);
        if (optionalMember.isPresent()) {
            Member member = optionalMember.get();

            boolean matches = pEncoder.matches(password, member.getPassword());

            if (matches) {
                LocalDateTime nowDate = LocalDateTime.now();

                member.setIsWithdrawn('Y');
                member.setWithdrawnAt(nowDate);
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

    public Member deleteMember(Long memberId) throws Exception {
        Member deleteMember = memberRepository.findById(memberId).orElseThrow(() -> new Exception("삭제할 멤버를 찾을 수 없습니다."));
        deleteMember.setIsWithdrawn('Y');
        deleteMember.setWithdrawnAt(LocalDateTime.now());
        return memberRepository.save(deleteMember);
    }

    public Long findMemberIdByUsername(String username) {
        return memberRepository.findMemberMemberIdByUsername(username);
    }
}