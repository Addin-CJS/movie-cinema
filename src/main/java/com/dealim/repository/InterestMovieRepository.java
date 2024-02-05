package com.dealim.repository;

import com.dealim.domain.InterestMovie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface InterestMovieRepository extends JpaRepository<InterestMovie, Long> {
    boolean existsByMovieIdAndUserName(Long movieId, String userName);

    Optional<InterestMovie> findByMovieIdAndUserName(Long movieId, String userName);
}
