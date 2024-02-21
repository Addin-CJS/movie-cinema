package com.dealim.service;

import com.dealim.domain.Review;
import com.dealim.repository.ReviewRepository;
import com.dealim.repository.TicketRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.util.List;
import java.util.Set;

@Service
public class ReviewService {
    @Autowired
    ReviewRepository reviewRepository;
    @Autowired
    NotificationService notificationService;
    @Autowired
    MemberService memberService;
    @Autowired
    TicketRepository ticketRepository;

    public String reviewInsert(Review review, String username) {
        Long memberId = memberService.findMemberIdByUsername(username);
        if (memberId == null) {
            return "userNotFound";
        }
        if (!ticketRepository.existsByMovieIdAndMemberId(review.getMovieNo(), memberId)) {
            return "notReserved";
        }
        review.setReviewWriter(username);
        reviewRepository.save(review);
        return "success";
    }

    public Page<Review> selectReviewListByMovieNo(Long movieId, Pageable pageable, String sortType) {
        Sort sort;
        if ("likes".equals(sortType)) {
            sort = Sort.by(Sort.Direction.DESC, "likeCount");
        } else {
            sort = Sort.by(Sort.Direction.DESC, "reviewId");
        }

        pageable = PageRequest.of(pageable.getPageNumber(), pageable.getPageSize(), sort);
        return reviewRepository.findAllByMovieId(movieId, pageable);
    }

    public void deleteReview(Long reviewId) {
        reviewRepository.deleteById(reviewId);
    }

    public Review updateReview(Review review) {
       return reviewRepository.save(review);
    }

    @Transactional
    public void  changeLikeStatus(Long reviewId, String likeAction, Set<Long> likedReviews, String likerUsername) {
        if ("like".equals(likeAction)) {
            updateLikeCount(reviewId, true);//참이면 +1 증가
            likedReviews.add(reviewId);
            // "좋아요" 알림 전송
            notificationService.sendLikeNotification(reviewId, likerUsername);
        } else if ("unlike".equals(likeAction)) {
            updateLikeCount(reviewId, false);//거짓이면 -1 감소
            likedReviews.remove(reviewId);
        }
    }

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

    public Page<Review> getMyReviews(String username, Pageable pageable, Model model) {
        Page<Review> myReviewList = reviewRepository.findAllByUsername(username, pageable);

        int nowPage = myReviewList.getPageable().getPageNumber();
        int totalPages = myReviewList.getTotalPages();
        int pageGroupSize = 5;
        int currentPageGroup = nowPage / pageGroupSize;
        int startPage = currentPageGroup * pageGroupSize;
        int endPage = (totalPages > 0) ? Math.min(startPage + pageGroupSize - 1, totalPages - 1) : 0;

        model.addAttribute("myReviewList", myReviewList.getContent());
        model.addAttribute("nowPage", nowPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalPages", totalPages);

        return myReviewList;
    }

    public List<Review> getBestReviewByLikeCount() {
        Page<Review> page = reviewRepository.findByOrderByLikeCountDesc(PageRequest.of(0, 10));
        return page.getContent();
    }
}