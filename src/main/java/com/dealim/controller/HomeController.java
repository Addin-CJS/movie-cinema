package com.dealim.controller;


import com.dealim.domain.Announcement;
import com.dealim.domain.Review;
import com.dealim.dto.MoviePopularity;
import com.dealim.service.AnnouncementService;
import com.dealim.service.InterestMovieService;
import com.dealim.service.ReviewService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
public class HomeController {

    @Autowired
    private InterestMovieService interestMovieService;
    @Autowired
    AnnouncementService announcementService;
    @Autowired
    private ReviewService reviewService;

    @RequestMapping("/")
    public String home(Model model) {
        List<MoviePopularity> top5Movies = interestMovieService.getTop5MoviesByPopularity(model);

        List<Review> bestReviews = reviewService.getBestReviewByLikeCount();
        List<Announcement> announcements = announcementService.getAnnounceList();

        model.addAttribute("top5Movies", top5Movies);
        model.addAttribute("bestReviews", bestReviews);
        model.addAttribute("announcements", announcements);
        return "index";
    }
}