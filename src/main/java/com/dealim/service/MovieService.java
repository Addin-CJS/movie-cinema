package com.dealim.service;

import com.dealim.domain.Movie;
import com.dealim.domain.Theater;
import com.dealim.repository.MovieRepository;
import com.dealim.repository.MovieTheaterRepository;
import com.dealim.repository.ReviewRepository;
import com.dealim.repository.TheaterRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.text.DecimalFormat;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class MovieService {

    @Autowired
    private MovieRepository movieRepository;

    @Autowired
    private MovieTheaterRepository movieTheaterRepository;

    @Autowired
    private TheaterRepository theaterRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    public Optional<Movie> selectMovieDetailById(Long movieId) {
        return movieRepository.findById(movieId);
    }

    public Page<Movie> movieList(Pageable pageable) {
        return  movieRepository.findAll(pageable);
    }


    public Page<Movie> findMoviesByKeyword(String searchKeyword, Pageable pageable) {
        return movieRepository.findByMvTitleIgnoreCase(searchKeyword, pageable);
    }

    public Page<Movie> findMoviesByGenre(String mvGenre, Pageable pageable) {
        return movieRepository.findByMvGenre(mvGenre, pageable);
    }

    private Page<Movie> findMoviesByReleaseYear(String releaseDate, Pageable pageable) {
        String releaseYear = releaseDate.substring(0, 4);
        int year = Integer.parseInt(releaseYear);

        int yearStart = (year / 10) * 10;
        int yearEnd = yearStart + 9;

        return movieRepository.findByMvReleaseYear(yearStart, yearEnd, pageable);
    }

    private Page<Movie> findMoviesByReleaseDateAfterToday(Pageable pageable) {
        LocalDate today = LocalDate.now();
        return movieRepository.findByMvReleaseDateAfter(today, pageable);
    }

    public void getMovieHome(Pageable pageable, String searchKeyword, String category, String releaseDate, String comingSoon, Model model) {
        Page<Movie> movieList;
        if (category != null && !category.trim().isEmpty()) {
            movieList = findMoviesByGenre(category, pageable);
        } else if (releaseDate != null && !releaseDate.trim().isEmpty()) {
            movieList = findMoviesByReleaseYear(releaseDate, pageable);
        } else if (comingSoon != null) {
            movieList = findMoviesByReleaseDateAfterToday(pageable);
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
        model.addAttribute("selectedReleaseDate", releaseDate);
        model.addAttribute("comingSoon", comingSoon);
    }

    public void getShowDetail(Long movieId, Model model) {
        Optional<Movie> movie = selectMovieDetailById(movieId);
        model.addAttribute("movie", movie.orElse(null));
        if (movie.isPresent()) {
            Float popularityValue = movie.get().getMvPopularity();

            if (popularityValue == null) {
                popularityValue = 0.0f;
            }
            DecimalFormat df = new DecimalFormat("0");
            String formattedPopularity = df.format(popularityValue);

            String finalPopularity = formattedPopularity;
            model.addAttribute("movieRating", finalPopularity);
        } else {
            model.addAttribute("movieRating", null);
        }
    }

    public List<Theater> getTheaterListByMovieId(Long movieId) {
        List<Long> theaterIdList = movieTheaterRepository.findTheaterIdByMovieId(movieId);
        List<Theater> theaterList = theaterRepository.findByTheaterIdIn(theaterIdList);
        return theaterList;
    }

    public List<Movie> getMovieListByPopularity() {
        List<Movie> movieListByPopularity = movieRepository.findAllByMvPopularity();
        return movieListByPopularity;
    }

}