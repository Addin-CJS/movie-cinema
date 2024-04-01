package com.dealim.controller;

import com.dealim.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class TheaterController {
    @Autowired
    private MovieService movieService;

    @PostMapping("/theaters")
    public ResponseEntity<?> getTheater(@RequestParam("movieId") Long movieId) {
        return ResponseEntity.ok(movieService.getTheaterListByMovieId(movieId));
    }
}

