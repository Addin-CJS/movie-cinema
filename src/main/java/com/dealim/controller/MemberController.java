package com.dealim.controller;

import com.dealim.domain.Member;
import com.dealim.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class MemberController {
@Autowired
 MemberService memberService;

    @GetMapping("/member/login")
    public String login() {
        return "member/login";
    }

    @GetMapping("/member/register")
    public String register() {
        return "member/register";
    }

    @PostMapping("/member/register")
    public  String insertMember(Member member){
        System.out.println("member");

            Member insert = memberService.insertMember(member);

        return "redirect:member/login";
    }
}