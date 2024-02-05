package com.dealim.service;

import com.dealim.domain.InterestMovie;
import com.dealim.domain.Movie;
import com.dealim.dto.MoviePopularity;
import com.dealim.repository.InterestMovieRepository;
import com.dealim.repository.MovieRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Slf4j
@Service
public class InterestMovieService {


    @Autowired
    private InterestMovieRepository interestMovieRepository;

    @Autowired
    private MovieRepository movieRepository;


    public boolean addInterestMovie(InterestMovie interestMovie) {
        try {
            if (!interestMovieRepository.existsByMovieIdAndUserName(interestMovie.getMovieId(), interestMovie.getUserName())) {
                interestMovieRepository.save(interestMovie);
                return true;
            }
            return false;
        } catch (Exception e) {
            log.error("관심 영화 추가 중 오류 발생", e);
            return false;
        }
    }

    public boolean removeInterestMovie(Long movieId, String userName) {
        try {
            Optional<InterestMovie> interestMovie = interestMovieRepository.findByMovieIdAndUserName(movieId, userName);
            if (interestMovie.isPresent()) {
                interestMovieRepository.delete(interestMovie.get());
                return true;
            }
            return false;
        } catch (Exception e) {
            log.error("관심 영화 삭제 중 오류 발생", e);
            return false;
        }
    }

    public boolean getMovieInterestedByUser(Long movieId, String userName) {
        try {
            return interestMovieRepository.existsByMovieIdAndUserName(movieId, userName);
        } catch (Exception e) {
            log.error("사용자의 영화 관심 여부 확인 중 오류 발생", e);

            return false;
        }
    }


    public List<MoviePopularity> getTop5MoviesByPopularity(Model model) {
        Page<Object[]> page = interestMovieRepository.findMovieIdAndCountByPopularity(PageRequest.of(0, 5));
        List<MoviePopularity> moviePopularityList = page.getContent().stream()
                .map(result -> new MoviePopularity((Long) result[0], (Long) result[1]))
                .collect(Collectors.toList());

        // movieId로 movie 정보 가져오기
        List<Long> movieIds = moviePopularityList.stream()
                .map(MoviePopularity::getMovieId)
                .collect(Collectors.toList());

        List<Movie> movies = movieRepository.findByMovieIdIn(movieIds);
        Map<Long, Movie> moviesInfo = movies.stream()
                        .collect(Collectors.toMap(Movie::getMovieId, Movie -> Movie));

        model.addAttribute("moviesInfo", moviesInfo);

        return moviePopularityList;
    }
}




