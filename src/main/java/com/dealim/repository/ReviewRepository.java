package com.dealim.repository;

import com.dealim.domain.Review;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {
    /*@Query("SELECT r FROM Review r WHERE r.movieNo = :movieId ORDER BY r.createReviewDate DESC")
    List<Review> findAllByMovieNo(@Param("movieId") Long movieId);*/
    @Query("SELECT r FROM Review r WHERE r.movieNo = :movieId ORDER BY r.createReviewDate DESC")
    Page<Review> findAllByMovieId(@Param("movieId") Long movieId, Pageable pageable);
}
