package com.dealim.repository;

import com.dealim.domain.MovieTheater;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MovieTheaterRepository extends JpaRepository<MovieTheater, Long> {
    @Query("SELECT mt.theaterId FROM MovieTheater mt WHERE mt.movieId = :movieId")
    List<Long> findTheaterIdByMovieId(Long movieId);
}