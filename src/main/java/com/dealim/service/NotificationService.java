package com.dealim.service;

import com.dealim.domain.Notification;
import com.dealim.domain.Review;
import com.dealim.repository.NotificationRepository;
import com.dealim.repository.ReviewRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class NotificationService {

    @Autowired
    private NotificationRepository notificationRepository;

    @Autowired
    private SseEmitterService sseEmitterService;

    @Autowired
    private ReviewRepository reviewRepository;

    public void sendInterestMovieAddedNotification(String username, Long movieId) {
        System.out.println("sendInterestMovieAddedNotification called with username: " + username + ", movieId: " + movieId); // 로그 추가
        // 알림이 이미 존재하는지 확인 코드임
        if (!notificationRepository.existsByUsernameAndTypeAndMovieId(username, Notification.NotificationType.INTEREST_MOVIE_ADDED, movieId)) {
            // 새로운 알림 객체 생성 및 저장 코드임
            Notification notification = Notification.builder()
                    .username(username)
                    .type(Notification.NotificationType.INTEREST_MOVIE_ADDED)
                    .movieId(movieId)
                    .isRead(false)
                    .isSent(true)
                    .createdDateTime(LocalDateTime.now())
                    .build();
            Notification savedNotification = notificationRepository.save(notification);

            // 고유 ID를 포함한 알림 JSON 생성는 코드임
            String notificationJson = String.format("{\"id\": \"%d\", \"message\": \"안녕하세요, %s님. 관심 영화 '%d'가 추가되었습니다.\", \"type\": \"INTEREST_MOVIE_ADDED\"}", savedNotification.getId(), username, movieId);
            System.out.println("json~~~~~~" + notificationJson);
            // SseEmitterService를 사용하여 특정 사용자에게 알림 전송 코드임
            sseEmitterService.sendNotification(username, notificationJson);

        }
    }

    public void sendLikeNotification(Long reviewId, String likerUsername) {
        Review review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("리뷰를 찾을 수 없습니다."));
        String ownerUsername = review.getReviewWriter(); // 리뷰 작성자의 사용자명

        // "좋아요" 알림이 이미 존재하는지 확인
        if (!notificationRepository.existsByUsernameAndTypeAndReviewId(ownerUsername, Notification.NotificationType.LIKE_NOTIFICATION, reviewId)) {
            // 새로운 "좋아요" 알림 객체 생성 및 저장
            Notification notification = Notification.builder()
                    .username(ownerUsername)
                    .type(Notification.NotificationType.LIKE_NOTIFICATION)
                    .reviewId(reviewId)
                    .isRead(false)
                    .isSent(true)
                    .createdDateTime(LocalDateTime.now())
                    .build();
            Notification savedNotification = notificationRepository.save(notification);

            // 알림 JSON 생성
            String notificationJson = String.format("{\"id\": \"%d\", \"message\": \"%s님이 당신의 리뷰 %d에 좋아요를 눌렀습니다.\", \"type\": \"LIKE_NOTIFICATION\"}", savedNotification.getId(), likerUsername, reviewId);

            // 특정 사용자에게 알림 전송
            sseEmitterService.sendNotification(ownerUsername, notificationJson);
        }
    }
}