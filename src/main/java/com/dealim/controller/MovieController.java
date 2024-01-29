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



    @RequestMapping("/movieHome")
    public String movieHome(Model model,
                            @PageableDefault(page = 0, size = 8, sort = "movieId", direction = Sort.Direction.DESC) Pageable pageable,
                            @RequestParam(value = "searchKeyword", required = false) String searchKeyword,
                            @RequestParam(value = "category", required = false) String category) {

        Page<Movie> movieList;

       //페이징, 검색, 전체목록 , 카테고리 별
        movieService.getMovieHome(pageable, searchKeyword, category, model);

        return "movie/movieHome";
    }



    @GetMapping("/showDetail")
    public String showDetail(@RequestParam("movieId") Long movieId, Model model) {
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
    //TODO:영화 예매해야지
    @GetMapping("/ticketing")
    public String ticketing () {
        return "movie/ticketing";
    }

}
