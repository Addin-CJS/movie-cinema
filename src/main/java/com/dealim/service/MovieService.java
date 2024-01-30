package com.dealim.service;

import com.dealim.domain.Movie;
import com.dealim.repository.MovieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.text.DecimalFormat;
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


        return movieRepository.findByMvTitleIgnoreCase(searchKeyword, pageable);

    }

    public Page<Movie> findMoviesByGenre(String mvGenre, Pageable pageable) {
        return movieRepository.findByMvGenre(mvGenre, pageable);

    }

    //movieHomeController 비즈니스 로직
    public void getMovieHome(Pageable pageable, String searchKeyword, String category, Model model) {
        Page<Movie> movieList;

        //사용자 요청에따라서 목록 조회해오는
        if (category != null && !category.trim().isEmpty()) {
            movieList = findMoviesByGenre(category, pageable);
        } else if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            movieList = findMoviesByKeyword(searchKeyword, pageable);
        } else {
            movieList = movieList(pageable);
        }

        int nowPage = movieList.getPageable().getPageNumber();
        int totalPages = movieList.getTotalPages();
        int pageGroupSize = 5;
        int currentPageGroup = nowPage / pageGroupSize;
        int startPage = currentPageGroup * pageGroupSize;
        int endPage = (totalPages > 0) ? Math.min(startPage + pageGroupSize - 1, totalPages - 1) : 0;

        model.addAttribute("movieList", movieList);
        model.addAttribute("nowPage", nowPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("searchKeyword", searchKeyword);
        model.addAttribute("selectedCategory", category);
    }

    //영화 상세보기 비즈니스 로직
    public void getShowDetail(Long movieId, Model model) {
        //영화 상세보기 메서드
        Optional<Movie> movie = selectMovieDetailById(movieId);

        model.addAttribute("movie", movie.orElse(null));
        if (movie.isPresent()) {
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
        } else {
            model.addAttribute("movieRating", null);
        }
    }





}
