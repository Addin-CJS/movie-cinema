package com.dealim.controller;

import com.dealim.domain.Member;
import com.dealim.service.MemberService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Optional;

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
    public String login(Member member, HttpSession session, Model model) {
        Optional<Member> optionalLoginUser = memberService.selectMemberByUsername(member);

        if (optionalLoginUser.isPresent()) {
            Member loginUser = optionalLoginUser.get();
            if (pEncoder.matches(member.getPassword(), loginUser.getPassword())) {
                session.setAttribute("loginUser", loginUser);
                return "redirect:/";
            }else {
                model.addAttribute("loginError", "로그인 정보가 올바르지 않습니다.");
                return "member/login";
            }
        }
        model.addAttribute("loginError", "로그인 정보가 올바르지 않습니다.");
        return "member/login";
    }

    @GetMapping("/member/register")
    public String registerForm() {
        return "member/register";
    }

    @PostMapping("/member/register")
    public String insertMember(Member member) {
        String enPass = pEncoder.encode(member.getPassword());    // 사용자가 입력한 패스워드 암호화해서 변수에 넣기
        member.setPassword(enPass);
        Member insert = memberService.insertMember(member);
        return "redirect:login";
    }

    @GetMapping("/member/idCheck")
    @ResponseBody
    public String checkId(@RequestParam("id") String username){
        boolean checkId = memberService.idCheck(username);

        return String.valueOf(checkId);
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/member/login";
    }

    @GetMapping("/member/myPage")
    public String showMyPage(HttpSession session) {

        Member loginUser = (Member)session.getAttribute("loginUser");

        return "member/myPage";
    }

    @GetMapping("/member/myPageEdit")
    public String MyPageEdit(HttpSession session) {

        Member loginUser = (Member)session.getAttribute("loginUser");

        return "member/myPageEdit";
    }

    @PostMapping("member/myPageEdit")
    public String EditMyPage(Member member, HttpSession session) {
        String enPass = pEncoder.encode(member.getPassword());	// 사용자가 입력한 패스워드 암호화해서 변수에 넣기
        member.setPassword(pEncoder.encode(member.getPassword()));

        session.setAttribute("loginUser", memberService.updateMember(member));

        return "redirect:myPage";

    }

    @GetMapping("member/findId")
    public String findId() {
        return "member/findId";
    }

    @PostMapping("member/findId")
    @ResponseBody
    public String findUserID(@RequestParam("name") String name, @RequestParam("phoneNumber") String phoneNumber) {
            String findId = memberService.findIdByNameAndPhoneNumber(name, phoneNumber);
        System.out.println("Found Member: " + findId);
        return String.valueOf(findId);
    }

    @GetMapping("member/resetPw")
    public String resetPw() {
        return "member/resetPw";
    }

    @PostMapping("member/checkForResetPw")
    @ResponseBody
    public Member checkForResetPw(@RequestParam("username") String username,
                                  @RequestParam("name") String name,
                                  @RequestParam("phoneNumber") String phoneNumber) {
        Member findMemberForPw = memberService.findIdByUserNameAndNameAndPhoneNumber(username,name, phoneNumber);
        System.out.println("Found Member: " + findMemberForPw);
        return findMemberForPw;
    }

    @PostMapping("member/resetPw")
    public String resetPw(Member member) {
        String enPass = pEncoder.encode(member.getPassword());	// 사용자가 입력한 패스워드 암호화해서 변수에 넣기
        member.setPassword(pEncoder.encode(member.getPassword()));

        Member resetPw = memberService.insertMember(member);
        System.out.println("UPDATE Member: " + memberService.insertMember(member));
        return "redirect:login";
    }
}