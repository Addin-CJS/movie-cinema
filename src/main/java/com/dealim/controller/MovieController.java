package com.dealim.controller;

import com.dealim.domain.model.Movie;
import com.dealim.domain.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Optional;

@Controller
public class MovieController {

    @Autowired
    MovieService movieService;

    @RequestMapping("/show")
    public String index(Model model) {
        List<Movie> movie = movieService.selectNowMovie();

        model.addAttribute("movies", movie);

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
