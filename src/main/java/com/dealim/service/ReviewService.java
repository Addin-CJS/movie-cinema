package com.dealim.service;

import com.dealim.domain.Review;
import com.dealim.repository.ReviewRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class ReviewService {
    @Autowired
    ReviewRepository reviewRepository;
    public Review reviewInsert(Review review) {
        return reviewRepository.save(review);
    }

    /*public List<Review> selectReviewByMovieNo(Long movieId) {

        return reviewRepository.findAllByMovieNo(movieId);
    }*/

    public Page<Review> selectReviewListByMovieNo(Long movieId, Pageable pageable) {
        return reviewRepository.findAllByMovieId(movieId, pageable);
    }

    public void deleteReview(Long reviewId) {
        reviewRepository.deleteById(reviewId);
    }

    public Review updateReview(Review review) {
       return reviewRepository.save(review);
    }





    @Transactional
    public void updateLikeCount(Long reviewId, boolean isLike) {
        Review review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("Review not found"));

        Integer currentLikeCount = review.getLikeCount();
        if (currentLikeCount == null) {
            currentLikeCount = 0;
        }

        review.setLikeCount(isLike ? currentLikeCount + 1 : Math.max(0, currentLikeCount - 1));
        reviewRepository.save(review);
    }

}
