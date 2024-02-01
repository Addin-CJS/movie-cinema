package com.dealim.service;

import com.dealim.domain.Review;
import com.dealim.repository.ReviewRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.Set;

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



//
//    public Page<Review> selectReviewListByMovieNo(Long movieId, Pageable pageable) {
//        return reviewRepository.findAllByMovieId(movieId, pageable);
//    }

    public Page<Review> selectReviewListByMovieNo(Long movieId, Pageable pageable, String sortType) {
        Sort sort;
        if ("likes".equals(sortType)) {
            sort = Sort.by(Sort.Direction.DESC, "likeCount");
        } else {
            sort = Sort.by(Sort.Direction.DESC, "reviewId");
        }

        pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        System.out.println("Pageable Sort: " + pageable.getSort().toString());
        return reviewRepository.findAllByMovieId(movieId, pageable);
    }



    public void deleteReview(Long reviewId) {
        reviewRepository.deleteById(reviewId);
    }

    public Review updateReview(Review review) {
       return reviewRepository.save(review);
    }




    //좋아요 증가 or 감소 시키는 메서드

    public void updateLikeCount(Long reviewId, boolean isLike) {
        Review review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("리뷰를 찾지못했습니다"));

        Integer currentLikeCount = review.getLikeCount();
        if (currentLikeCount == null) {
            currentLikeCount = 0;
        }

        review.setLikeCount(isLike ? currentLikeCount + 1 : Math.max(0, currentLikeCount - 1));
        reviewRepository.save(review);
    }

        //좋아요 상태를 바꾸는 메서드 (컨트롤러에서 사용)
        @Transactional
    public void  changeLikeStatus(Long reviewId, String likeAction, Set<Long> likedReviews) {
        if ("like".equals(likeAction)) {
            updateLikeCount(reviewId, true);//참이면 +1 증가
            likedReviews.add(reviewId);
        } else if ("unlike".equals(likeAction)) {
            updateLikeCount(reviewId, false);//거짓이면 -1 감소
            likedReviews.remove(reviewId);
        }
    }






}
