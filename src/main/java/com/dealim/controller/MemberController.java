package com.dealim.controller;

import com.dealim.domain.Member;
import com.dealim.domain.Review;
import com.dealim.dto.MyPageMember;
import com.dealim.service.MemberService;
import com.dealim.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Optional;

@Controller
@Slf4j
public class MemberController {
    @Autowired
    MemberService memberService;

    @Autowired
    ReviewService reviewService;

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

        if (session.getAttribute("loginUser") instanceof Member) {
            Member loginUser = (Member) session.getAttribute("loginUser");
        }
        return "member/myPage";
    }
    @GetMapping("/member/myInfo")
    public String showMyPageInfo(HttpSession session, Model model) {
        if (session.getAttribute("loginUser") instanceof Member) {
            Member loginUser = (Member) session.getAttribute("loginUser");
            model.addAttribute("loginUser", loginUser);
        }
        return "member/myInfo";
    }

    @GetMapping("/member/myPageEdit")
    public String myPageEdit(HttpSession session, Model model) {
        if (session.getAttribute("loginUser") instanceof Member) {
            Member loginUser = (Member) session.getAttribute("loginUser");
            model.addAttribute("loginUser", loginUser);
        }
        return "member/myPageEdit";
    }

    @PostMapping("member/myPageEdit")
    public String EditMyPage(MyPageMember myPageMember, HttpSession session) {

        String enPass = pEncoder.encode(myPageMember.getPassword());
        myPageMember.setPassword(pEncoder.encode(myPageMember.getPassword()));

        Member loginUser = (Member)session.getAttribute("loginUser");
        Member updatedMember = memberService.updateMember(myPageMember, loginUser);

        session.setAttribute("loginUser", updatedMember);

        return "member/myPage";
    }

    @GetMapping("/member/resetMyPw")
    public String resetMyPw(HttpSession session, Model model) {
        if (session.getAttribute("loginUser") instanceof Member) {
            Member loginUser = (Member) session.getAttribute("loginUser");
            model.addAttribute("loginUser", loginUser);
        }
        return "member/resetMyPw";
    }

    @PostMapping("member/resetMyPw")
    public String resetMyPw(Member member) {
        String enPass = pEncoder.encode(member.getPassword());
        member.setPassword(pEncoder.encode(member.getPassword()));

        Member resetPw = memberService.insertMember(member);
        return "member/myPage";
    }


    @GetMapping("member/findId")
    public String findId() {
        return "member/findId";
    }

    @PostMapping("member/findId")
    @ResponseBody
    public Member findUserID(@RequestParam("name") String name, @RequestParam("phoneNumber") String phoneNumber) {
            Member findId = memberService.findIdByNameAndPhoneNumber(name, phoneNumber);
        System.out.println("Found Member: " + findId);
        return findId;
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

    @GetMapping("member/myReviews")
    public String getMyReviews(HttpSession session, Model model,
                                @PageableDefault(page = 0, size = 10, sort = "createReviewDate",
                                        direction = Sort.Direction.DESC) Pageable pageable) {

        Member loginUser = (Member) session.getAttribute("loginUser");
        if (loginUser != null) {
            Page<Review> myReviews = reviewService.getMyReviews(loginUser.getUsername(),pageable, model);
            return "member/myReviews";
        } else {
            return "redirect:/login";
        }
    }
}