package com.dealim.controller;

import com.dealim.domain.Review;
import com.dealim.security.custom.CustomUserDetails;
import com.dealim.service.ReviewService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashSet;
import java.util.Set;

@Controller
public class ReviewController {
    @Autowired
    ReviewService reviewService;


    @PostMapping("/reviewInsert")
    @ResponseBody
    public String insertReview(Review review, Authentication authentication) {
        // Authentication 객체를 통해 로그인 상태 확인
        if (authentication == null || !authentication.isAuthenticated()) {
            return "fail";
        }

        // 현재 로그인한 사용자 정보를 Review 객체에 설정
        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        review.setReviewWriter(userDetails.getUsername());

        reviewService.reviewInsert(review);
        return "success";
    }

    @GetMapping("/reviewList")
    @ResponseBody
    public ResponseEntity<Page<Review>> getReviewsByMovieId(
            @RequestParam("movieNo") Long movieId,
            @RequestParam(value = "sortType", defaultValue = "latest") String sortType,
            @PageableDefault(page = 0, size = 10, sort = "reviewId", direction = Sort.Direction.DESC) Pageable pageable,
            Model model) {


        Page<Review> reviewList = reviewService.selectReviewListByMovieNo(movieId, pageable, sortType);

        return ResponseEntity.ok(reviewList);
    }


    @PostMapping("/updateReview")
    @ResponseBody
    public String updateReview(Review review, Authentication authentication) {

        if (authentication == null || !authentication.isAuthenticated()) {
            return "fail";
        }



        reviewService.updateReview(review);
        return "success";
    }

    @GetMapping("/deleteReview")
    @ResponseBody
    public String deleteReview(Long reviewId) {
        reviewService.deleteReview(reviewId);
        return "success";
    }

    @PostMapping("/like")
    @ResponseBody
    public String likeReview(@RequestParam Long reviewId, @RequestParam String likeAction, HttpServletRequest request) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (!(authentication.getPrincipal() instanceof CustomUserDetails)) {
            return "fail";
        }


        HttpSession session = request.getSession();
        Set<Long> likedReviews = (Set<Long>) session.getAttribute("likedReviews");
        if (likedReviews == null) {
            likedReviews = new HashSet<>();
        }

        reviewService.changeLikeStatus(reviewId, likeAction, likedReviews);


        if ("like".equals(likeAction)) {
            likedReviews.add(reviewId);
        } else if ("unlike".equals(likeAction)) {
            likedReviews.remove(reviewId);
        }


        session.setAttribute("likedReviews", likedReviews);

        return "success";
    }

    @GetMapping("/getUserLikes")
    @ResponseBody
    public ResponseEntity<Set<Long>> getUserLikes(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Set<Long> likedReviews = (Set<Long>) session.getAttribute("likedReviews");
        if (likedReviews == null) {
            likedReviews = new HashSet<>();
        }

        return ResponseEntity.ok(likedReviews);
    }


    }