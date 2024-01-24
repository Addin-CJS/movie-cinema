package com.dealim.controller;

import com.dealim.domain.Review;
import com.dealim.service.MovieService;
import com.dealim.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class ReviewController {
    @Autowired
    ReviewService reviewService;

    @PostMapping("/reviewInsert")
    @ResponseBody
    public String insertReview(Review review) {

        reviewService.reviewInsert(review);
        return "review";
    }

    @GetMapping("/reviewList")
    @ResponseBody
    public String getReviewsByMovieId(@RequestParam("movieNo") Long movieId, Model model) {
        List<Review> reviews = reviewService.selectReviewByMovieNo(movieId);
        model.addAttribute("reviews", reviews);

        System.out.println(reviews);
        return "movie/reviews";
    }
}