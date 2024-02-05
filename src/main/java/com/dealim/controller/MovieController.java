package com.dealim.controller;

import com.dealim.domain.InterestMovie;
import com.dealim.domain.Member;
import com.dealim.domain.Movie;
import com.dealim.security.custom.CustomUserDetails;
import com.dealim.service.InterestMovieService;
import com.dealim.service.MovieService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

@Controller
@Slf4j
public class MovieController {

    @Autowired
    private MovieService movieService;

   @Autowired
   private InterestMovieService interestMovieService;

    @RequestMapping("/movieHome")
    public String movieHome(Model model,
                            @PageableDefault(page = 0, size = 8, sort = "movieId", direction = Sort.Direction.DESC) Pageable pageable,
                            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                            @RequestParam(value = "category", required = false) String category) {

        movieService.getMovieHome(pageable, searchKeyword, category, model);

        return "movie/movieHome";
    }

    @GetMapping("/showDetail")
    public String showDetail(@RequestParam("movieId") Long movieId, Model model, Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated() && !(authentication.getPrincipal() instanceof String)) {

            CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
            Member member = userDetails.getMember();


            boolean isInterested = interestMovieService.getMovieInterestedByUser(movieId, member.getUsername());
            model.addAttribute("isInterested", isInterested);//상태를 jsp로 보내주는거
        } else {
            model.addAttribute("isInterested", false);
        }


        movieService.getShowDetail(movieId, model);
        return "movie/detail";
    }

    @GetMapping("/movieSeats")
    public String movieSeats(@RequestParam("movieId") Long movieId, Model model) {

        Optional <Movie> movie = movieService.selectMovieDetailById(movieId);

        if(movie.isPresent()) {
            model.addAttribute("movie", movie.get());
        } else {
            model.addAttribute("movie", null);
        }
        return "movie/movieSeats";
    }


    @PostMapping("/interestMovie")
    public String addInterestMovie(InterestMovie interestMovie, Authentication authentication, RedirectAttributes redirectAttributes) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/member/login";
        }

        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        Member member = userDetails.getMember();
        interestMovie.setUserName(member.getUsername());

        boolean added = interestMovieService.addInterestMovie(interestMovie);
        if (added) {
            redirectAttributes.addFlashAttribute("successMessage", "관심 영화가 성공적으로 추가되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "이미 관심 영화로 등록되어 있습니다.");
        }
        return "redirect:/showDetail?movieId=" + interestMovie.getMovieId();
    }
    @PostMapping("/removeInterestMovie")
    public String removeInterestMovie(@RequestParam("movieId") Long movieId, Authentication authentication, RedirectAttributes redirectAttributes) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/member/login";
        }

        CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
        Member member = userDetails.getMember();

        boolean removed = interestMovieService.removeInterestMovie(movieId, member.getUsername());
        if (removed) {
            redirectAttributes.addFlashAttribute("successMessage", "관심 영화가 성공적으로 취소되었습니다.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "관심 영화 취소에 실패했습니다.");
        }
        return "redirect:/showDetail?movieId=" + movieId;
    }




    }






