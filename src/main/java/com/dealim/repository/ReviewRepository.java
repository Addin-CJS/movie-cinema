package com.dealim.repository;

import com.dealim.domain.Review;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {
    /*@Query("SELECT r FROM Review r WHERE r.movieNo = :movieId ORDER BY r.createReviewDate DESC")
    List<Review> findAllByMovieNo(@Param("movieId") Long movieId);*/
    @Query("SELECT r FROM Review r WHERE r.movieNo = :movieId")
    Page<Review> findAllByMovieId(@Param("movieId") Long movieId, Pageable pageable);
    @Query("SELECT r FROM Review r WHERE r.reviewWriter = :username ORDER BY r.createReviewDate DESC")
    Page<Review> findAllByUsername(@Param("username") String username, Pageable pageable);

    @Query("SELECT r FROM Review r ORDER BY r.likeCount DESC")
    Page<Review> findByOrderByLikeCountDesc(Pageable pageable);

}