package com.dealim.repository;

import com.dealim.domain.Movie;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface MovieRepository extends JpaRepository<Movie, Long> {

    @Query("SELECT m FROM Movie m WHERE LOWER(m.mvTitle) LIKE LOWER(CONCAT('%', :searchKeyword, '%'))")
    Page<Movie> findByMvTitleIgnoreCase(@Param("searchKeyword") String searchKeyword, Pageable pageable);

    Page<Movie> findByMvGenre(String mvGenre, Pageable pageable);

    List<Movie> findByMovieIdIn(List<Long> movieIdsList);

    @Query("SELECT m FROM Movie m WHERE YEAR(m.mvReleaseDate) BETWEEN ?1 AND ?2")
    Page<Movie> findByMvReleaseYear(int yearStart, int yearEnd, Pageable pageable);

    Page<Movie> findByMvReleaseDateAfter(LocalDate date, Pageable pageable);

    @Query("SELECT m FROM Movie m ORDER BY m.mvPopularity desc ")
    List<Movie> findAllByMvPopularity();

}