package com.dealim.repository;

import com.dealim.domain.InterestMovie;
import com.dealim.domain.Movie;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface InterestMovieRepository extends JpaRepository<InterestMovie, Long> {
    boolean existsByMovieIdAndUserName(Long movieId, String userName);


    Optional<InterestMovie> findByMovieIdAndUserName(Long movieId, String userName);

    Page<InterestMovie> findAllByUserName(String userName, Pageable pageable);

    List<Movie> findByMovieIdIn(List<Long> movieIdsList);

    @Query("SELECT im.movieId, COUNT(im) as count FROM InterestMovie im GROUP BY im.movieId ORDER BY COUNT(im) DESC")
    Page<Object[]> findMovieIdAndCountByPopularity(Pageable pageable);
}
