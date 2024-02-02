package com.dealim.service;

import com.dealim.domain.InterestMovie;
import com.dealim.repository.InterestMovieRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;
@Slf4j
@Service
public class InterestMovieService {


    @Autowired
    private InterestMovieRepository interestMovieRepository;


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


}




