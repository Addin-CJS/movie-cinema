package com.dealim.service;

import com.dealim.domain.Review;
import com.dealim.repository.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReviewService {
    @Autowired
    ReviewRepository reviewRepository;
    public Review reviewInsert(Review review) {
        return reviewRepository.save(review);
    }

    public List<Review> selectReviewByMovieNo(Long movieId) {

        return reviewRepository.findAllByMovieNo(movieId);
    }
}
