package com.dealim.controller;


import com.dealim.domain.Announcement;
import com.dealim.domain.Movie;
import com.dealim.domain.Review;
import com.dealim.dto.MovieInterest;
import com.dealim.service.AnnouncementService;
import com.dealim.service.InterestMovieService;
import com.dealim.service.MovieService;
import com.dealim.service.ReviewService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
    @Autowired
    private MovieService movieService;

    @RequestMapping("/")
    public String home(Model model) {
        List<MovieInterest> top5Movies = interestMovieService.getTop5MoviesByInterest(model);
        List<Movie> movieListForPopularity = movieService.getMovieListByPopularity();

        List<Review> bestReviews = reviewService.getBestReviewByLikeCount();
        List<Announcement> announcements = announcementService.getAnnounceList();

        model.addAttribute("top5Movies", top5Movies);
        model.addAttribute("bestReviews", bestReviews);
        model.addAttribute("announcements", announcements);
        model.addAttribute("movieListForPopularity", movieListForPopularity);
        return "index";
    }

    @GetMapping("/test")
    public String test(Model model) {
        return "test";
    }
}