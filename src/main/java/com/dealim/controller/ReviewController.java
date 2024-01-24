package com.dealim.controller;

import com.dealim.domain.Review;
import com.dealim.service.MovieService;
import com.dealim.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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

}
