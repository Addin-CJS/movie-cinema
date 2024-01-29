package com.dealim.service;

import com.dealim.domain.Movie;
import com.dealim.repository.MovieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

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

    //모델에 추가하는거
    public void addMovieListAttributesToModel(Model model, Page<Movie> movieList, String searchKeyword, String category) {
        int nowPage = movieList.getPageable().getPageNumber();
        int totalPages = movieList.getTotalPages();
        int pageGroupSize = 5;
        int currentPageGroup = nowPage / pageGroupSize;
        int startPage = currentPageGroup * pageGroupSize;
        int endPage = Math.min(startPage + pageGroupSize - 1, totalPages - 1);

        model.addAttribute("movieList", movieList);
        model.addAttribute("nowPage", nowPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("searchKeyword", searchKeyword);
        model.addAttribute("selectedCategory", category);
    }

    //사용자의 요청에 따라 보여지는 조회들
    public Page<Movie> getFilteredMovieList(Pageable pageable, String searchKeyword, String category) {
        if (category != null && !category.trim().isEmpty()) {
            return findMoviesByGenre(category, pageable);
        } else if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            return findMoviesByKeyword(searchKeyword, pageable);
        } else {
            return movieList(pageable);
        }
    }

}
