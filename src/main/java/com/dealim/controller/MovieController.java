package com.dealim.controller;

import com.dealim.domain.Movie;
import com.dealim.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Controller
public class MovieController {

    @Autowired
    MovieService movieService;

    @RequestMapping("/")
    public String index(Model model,
                        @PageableDefault(page=0, size=8, sort="movieId", direction= Sort.Direction.DESC) Pageable pageable,
                        String searchKeyword) {
        Page<Movie> movieList = null;

        if(searchKeyword == null) {
            movieList = movieService.movieList(pageable);
        }

        int nowPage = movieList.getPageable().getPageNumber();
        int pageGroupSize = 5;  // 한 페이지 그룹에서 보여줄 페이지 수
        int totalPageGroups = (int)Math.ceil((double)movieList .getTotalPages() / pageGroupSize);    // 전체 페이지 그룹 수
        int currentPageGroup = (nowPage -1) / pageGroupSize;    // 현재 페이지가 속한 페이지 그룹
        int startPage = currentPageGroup * pageGroupSize + 1; // 현재 페이지
        int endPage = Math.min(startPage + pageGroupSize - 1, movieList.getTotalPages()); // 현재 페이지 그룹의 마지막 페이지


        model.addAttribute("movieList", movieList);
        model.addAttribute("nowPage", nowPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);

        return "index";
    }

    @GetMapping("/showDetail")
    public String showDetail(@RequestParam("movieId") Long movieId, Model model) {
           Optional <Movie> movie = movieService.selectMovieDetailById(movieId);

           if(movie.isPresent()) {
               model.addAttribute("movie", movie.get());
           } else {
               model.addAttribute("movie", null);
           }

        return "detail";
    }

    @GetMapping("/movieSeats")
    public String movieSeats(@RequestParam("movieId") Long movieId, Model model) {

        Optional <Movie> movie = movieService.selectMovieDetailById(movieId);

        if(movie.isPresent()) {
            model.addAttribute("movie", movie.get());
        } else {
            model.addAttribute("movie", null);
        }
        return "movieSeats";
    }

}
