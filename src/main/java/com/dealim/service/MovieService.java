package com.dealim.service;

import com.dealim.domain.Movie;
import com.dealim.repository.MovieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class MovieService {

    @Autowired
    MovieRepository movieRepository;
    /*public List<Movie> selectNowMovie() {

        return movieRepository.findAll();
    }*/

    public Optional<Movie> selectMovieDetailById(Long movieId) {
        return movieRepository.findById(movieId);
    }

    public Page<Movie> movieList(Pageable pageable) {

        System.out.println( movieRepository.findAll(pageable));
        return  movieRepository.findAll(pageable);
    }


    public Page<Movie> findMoviesByKeyword(String searchKeyword, Pageable pageable) {

        System.out.println(movieRepository.findByMvTitleIgnoreCase(searchKeyword, pageable));
        return movieRepository.findByMvTitleIgnoreCase(searchKeyword, pageable);

    }
}
