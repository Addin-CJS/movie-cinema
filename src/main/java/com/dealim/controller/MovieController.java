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

import java.text.DecimalFormat;
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
        movieList = movieService.getFilteredMovieList(pageable, searchKeyword, category);

        movieService.addMovieListAttributesToModel(model, movieList, searchKeyword, category);


        return "movie/movieHome";
    }






    @GetMapping("/showDetail")
    public String showDetail(@RequestParam("movieId") Long movieId, Model model) {
        Optional <Movie> movie = movieService.selectMovieDetailById(movieId);

        if(movie.isPresent()) {
            model.addAttribute("movie", movie.get());
        } else {
            model.addAttribute("movie", null);
        }

        //영화 평점 start
        Float popularityValue = movie.get().getMvPopularity();
        Float minPopularity = 0.0f;
        Float maxPopularity = 10.0f;
        Float minRating = 0.0f;
        Float maxRating = 5.0f;

        if (popularityValue == null) {
            popularityValue = 0.0f;
        }
        Float rating = ((popularityValue - minPopularity) / (maxPopularity - minPopularity)) * (maxRating - minRating) + minRating;

        DecimalFormat df = new DecimalFormat("0.0");
        String formattedRating = df.format(rating);

        String finalRating = formattedRating + "/100";

        model.addAttribute("movieRating", finalRating);
        //영화 평점  end



        return "movie/detail";
    }
//
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
