package com.dealim.controller;

import com.dealim.domain.Review;
import com.dealim.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.ResponseEntity;
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
    public String insertReview(Review review, HttpSession session) {

        if(session.getAttribute("loginUser") == null) {
            return "fail";
        }
        reviewService.reviewInsert(review);
        return "success";
    }

    @GetMapping("/reviewList")
    @ResponseBody
    public ResponseEntity<Page<Review>> getReviewsByMovieId
                        (@RequestParam("movieNo") Long movieId,
                         @PageableDefault(page=0, size=10, sort="reviewId", direction= Sort.Direction.DESC) Pageable pageable,
                         Model model) {

        Page<Review> reviewList = reviewService.selectReviewListByMovieNo(movieId, pageable);

        return ResponseEntity.ok(reviewList);
    }

    @PostMapping("/updateReview")
    @ResponseBody
    public String updateReview(Review review) {
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
    public String likeReview(@RequestParam Long reviewId, @RequestParam String likeAction ,HttpSession session) {
        // 로그인 상태 확인
        if (session.getAttribute("loginUser") == null) {
            return "fail";
        }

        Set<Long> likedReviews = (Set<Long>) session.getAttribute("likedReviews");
        if (likedReviews == null) {
            likedReviews = new HashSet<>();
        }

        reviewService.changeLikeStatus(reviewId, likeAction, likedReviews);

        session.setAttribute("likedReviews", likedReviews);
        return "success";
    }


    @GetMapping("/getUserLikes")
    @ResponseBody
    public ResponseEntity<Set<Long>> getUserLikes(HttpSession session) {
        Set<Long> likedReviews = (Set<Long>) session.getAttribute("likedReviews");
        if (likedReviews == null) {
            likedReviews = new HashSet<>();
        }
        return ResponseEntity.ok(likedReviews);
    }





    }