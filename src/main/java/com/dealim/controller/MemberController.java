package com.dealim.controller;

import com.dealim.domain.Member;
import com.dealim.security.UserDetailsImpl;
import com.dealim.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MemberController {
@Autowired
 MemberService memberService;

@Autowired
PasswordEncoder pEncoder;


    @GetMapping("/member/login")
    public String loginForm() {

        return "member/login";
    }

    @PostMapping("/member/login")
    public String login(Member member, Model model, @AuthenticationPrincipal UserDetailsImpl userDetails) {
        Member loginUser = memberService.selectMemberById(member).get();
        if(loginUser != null && pEncoder.matches(member.getPassword(), loginUser.getPassword())) {
            model.addAttribute("loginUser", loginUser);
        }
        return "redirect:index";
    }

    @GetMapping("/member/register")
    public String registerForm() {

        return "member/register";
    }

    @PostMapping("/member/register")
    public  String insertMember(Member member){

        String enPass = pEncoder.encode(member.getPassword());	// 사용자가 입력한 패스워드 암호화해서 변수에 넣기
        member.setPassword(enPass);

        Member insert = memberService.insertMember(member);
        return "redirect:login";
    }


    @GetMapping("/member/idCheck")
    @ResponseBody
    public boolean checkId(@RequestParam("id") String username){
        boolean checkId = memberService.idCheck(username);

        return checkId;

    }



}

