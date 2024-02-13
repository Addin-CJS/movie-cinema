package com.dealim.controller;

import com.dealim.domain.Member;
import com.dealim.service.MemberService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
@Slf4j
public class MemberApiController {
    @Autowired
    private MemberService memberservice;
    @GetMapping("/members")
    @Secured({"ROLE_ADMIN"})
    public ResponseEntity<?> getAllMembers() {
        log.info("====멤버 리스트 전부 받는중====");
        List<Member> memberList = memberservice.getAllMembersNotWithdrawn();
        return ResponseEntity.ok(memberList);
    }

    @GetMapping("/member/delete")
    @Secured({"ROLE_ADMIN"})
    public ResponseEntity<?> deleteMember(@RequestParam("memberId") Long memberId) throws Exception {
        memberservice.deleteMember(memberId);
        return ResponseEntity.ok("회원을 탈퇴 시켰습니다");
    }
}