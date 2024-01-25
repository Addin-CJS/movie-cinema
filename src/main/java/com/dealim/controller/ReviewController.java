package com.dealim.controller;

import com.dealim.domain.Review;
import com.dealim.service.MovieService;
import com.dealim.service.ReviewService;
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
    public ResponseEntity<Page<Review>> getReviewsByMovieId
                        (@RequestParam("movieNo") Long movieId,
                         @PageableDefault(page=0, size=10, sort="reviewId", direction= Sort.Direction.DESC) Pageable pageable,
                         Model model) {

        Page<Review> reviewList = reviewService.selectReviewListByMovieNo(movieId, pageable);

        int nowPage = reviewList.getPageable().getPageNumber();
        int pageGroupSize = 5;
        int totalPageGroups = (int)Math.ceil((double)reviewList.getTotalPages() / pageGroupSize);
        int currentPageGroup = (nowPage-1) / pageGroupSize;
        int startPage = currentPageGroup * pageGroupSize + 1;
        int endPage = Math.min(startPage + pageGroupSize -1, reviewList.getTotalPages());


        model.addAttribute("nowPage", nowPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        return ResponseEntity.ok(reviewList);


        /*List<Review> reviews = reviewService.selectReviewByMovieNo(movieId);

        return ResponseEntity.ok(reviews);*/
    }
}