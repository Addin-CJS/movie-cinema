package com.dealim.controller;

import com.dealim.domain.Member;
import com.dealim.domain.Review;
import com.dealim.domain.Ticket;
import com.dealim.dto.MyPageMember;
import com.dealim.security.custom.CustomUserDetails;
import com.dealim.service.InterestMovieService;
import com.dealim.service.MemberService;
import com.dealim.service.ReviewService;
import com.dealim.service.TicketService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@Slf4j
public class MemberController {
    @Autowired
    MemberService memberService;

    @Autowired
    ReviewService reviewService;

    @Autowired
    TicketService ticketService;

    @Autowired
    InterestMovieService interestMovieService;

    @Autowired
    PasswordEncoder pEncoder;

    @GetMapping("/member/login")
    public String loginForm() {
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

    @GetMapping("/member/myPage")
    public String showMyPage( ) {

        return "member/myPage";
    }

    @GetMapping("/member/myInfo")
    public String showMyPageInfo() {

        return "member/myInfo";
    }

    @GetMapping("/member/myPageEdit")
    public String myPageEdit() {

        return "member/myPageEdit";
    }

    @PostMapping("/member/myPageEdit")
    public String EditMyPage(MyPageMember myPageMember, Authentication authentication) {

        String enPass = pEncoder.encode(myPageMember.getPassword());
        myPageMember.setPassword(pEncoder.encode(myPageMember.getPassword()));

        Member loginUser = ((CustomUserDetails)authentication.getPrincipal()).getMember();
        Member updatedMember = memberService.updateMember(myPageMember, loginUser);

        CustomUserDetails updatedUserDetails = new CustomUserDetails(updatedMember);
        Authentication newAuth = new UsernamePasswordAuthenticationToken(updatedUserDetails, authentication.getCredentials(), updatedUserDetails.getAuthorities());
        SecurityContextHolder.getContext().setAuthentication(newAuth);
        return "member/myPage";
    }

    @GetMapping("/member/myReviews")
    public String getMyReviews(Authentication authentication, Model model,
                               @PageableDefault(page = 0, size = 7, sort = "createReviewDate",
                                       direction = Sort.Direction.DESC) Pageable pageable) {
        Member loginUser = ((CustomUserDetails)authentication.getPrincipal()).getMember();

        Page<Review> myReviews = reviewService.getMyReviews(loginUser.getUsername(),pageable, model);
        return "member/myReviews";
    }

    @GetMapping("/member/withdrawMember")
    public String withdraw () {
        return "member/withdrawMember";
    }
    @PostMapping("/member/withdrawMember")
    @ResponseBody
    public boolean withdraw (@RequestParam("password") String password,
                             @RequestParam("username") String username,
                             @RequestParam("name") String name) {
        boolean memberValid = memberService.findMemberForWithdraw(username, name, password);
        return memberValid;
    }

    @PostMapping("/member/confirmWithdraw")
    @ResponseBody
    public String confirmWithdraw(@ModelAttribute Member member) {
        boolean withdrawOk = memberService.withdrawMemberOk(member.getUsername(), member.getPassword());
        if (withdrawOk) {
            return "success";
        } else {
            return "fail";
        }
    }

    @GetMapping("/member/myTickets")
    public String getMyTickets(Authentication authentication, Model model,
                               @PageableDefault(page = 0, size = 3, sort = "ticketedDate",
                                       direction = Sort.Direction.DESC) Pageable pageable) {
        Member loginUser = ((CustomUserDetails)authentication.getPrincipal()).getMember();

        Page<Ticket> myTickets = ticketService.getMyTickets(loginUser.getMemberId(),pageable, model);
        return "member/myTickets";
    }

    @GetMapping("/member/resetMyPw")
    public String resetMyPw() {
        return "member/resetMyPw";
    }

    @PostMapping("/member/resetMyPw")
    public String resetMyPw(Member member) {
        String enPass = pEncoder.encode(member.getPassword());
        member.setPassword(pEncoder.encode(member.getPassword()));

        Member resetPw = memberService.insertMember(member);
        return "member/myPage";
    }

    @GetMapping("/member/findId")
    public String findId() {
        return "member/findId";
    }

    @PostMapping("/member/findId")
    @ResponseBody
    public Member findUserID(@RequestParam("name") String name, @RequestParam("phoneNumber") String phoneNumber) {
            Member findId = memberService.findIdByNameAndPhoneNumber(name, phoneNumber);
        return findId;
    }

    @GetMapping("/member/resetPw")
    public String resetPw() {
        return "member/resetPw";
    }

    @PostMapping("/member/checkForResetPw")
    @ResponseBody
    public Member checkForResetPw(@RequestParam("username") String username,
                                  @RequestParam("name") String name,
                                  @RequestParam("phoneNumber") String phoneNumber) {
        Member findMemberForPw = memberService.findIdByUserNameAndNameAndPhoneNumber(username,name, phoneNumber);
        return findMemberForPw;
    }

    @PostMapping("/member/resetPw")
    public String resetPw(Member member) {
        String enPass = pEncoder.encode(member.getPassword());	// 사용자가 입력한 패스워드 암호화해서 변수에 넣기
        member.setPassword(pEncoder.encode(member.getPassword()));

        Member resetPw = memberService.insertMember(member);
        return "redirect:login";
    }

    @GetMapping("/member/myInterestMovies")
    public String getMyInterestMovies(Authentication authentication, Model model,
                                      @PageableDefault(size = 2, sort = "interestMovieId", direction = Sort.Direction.DESC) Pageable pageable) {
        if (authentication == null) {
            return "redirect:/login";
        }

        String userName = ((CustomUserDetails)authentication.getPrincipal()).getUsername();
        interestMovieService.getMyInterestMoviesDetails(userName, pageable, model);

        return "member/myInterestMovies";
    }
}