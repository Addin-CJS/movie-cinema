package com.dealim.service;

import com.dealim.domain.*;
import com.dealim.repository.MemberRepository;
import com.dealim.repository.MovieRepository;
import com.dealim.repository.NotificationRepository;
import com.dealim.repository.ReviewRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Slf4j
@Service
public class NotificationService {

    @Autowired
    private NotificationRepository notificationRepository;

    @Autowired
    private SseEmitterService sseEmitterService;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private MovieRepository movieRepository;


    @Autowired
    private MemberRepository memberRepository;

    public void sendInterestMovieAddedNotification(String username, Long movieId) {
        System.out.println("sendInterestMovieAddedNotification called with username: " + username + ", movieId: " + movieId);

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

            // 알림 json 생성 코드임  키:값
            String notificationJson = String.format("{\"id\": \"%d\", \"message\": \"안녕하세요, %s님. 관심 영화 '%d'가 추가되었습니다.\", \"type\": \"INTEREST_MOVIE_ADDED\"}",
                    savedNotification.getId(),
                    username,
                    movieId);
            System.out.println("json~~~~~~" + notificationJson);
            // 특정 사용자에게 알림 전송 코드임
            sseEmitterService.sendNotification(username, notificationJson);

        }
    }

    public void sendLikeNotification(Long reviewId, String likerUsername) {
        try {
            Review review = reviewRepository.findById(reviewId).orElseThrow(() -> new RuntimeException("리뷰를 찾을 수 없습니다."));
            String reviewWriterUsername = review.getReviewWriter();
            if (!notificationRepository.existsByUsernameAndTypeAndReviewId(reviewWriterUsername, Notification.NotificationType.LIKE_NOTIFICATION, reviewId)) {
                Notification notification = createNotificationForReviewLiked(reviewWriterUsername, reviewId, likerUsername);
                sseEmitterService.sendNotification(reviewWriterUsername, formatNotificationJson(notification, likerUsername + "님이 당신의 리뷰에 좋아요를 눌렀습니다."));
                updateAndSendUnreadNotificationCountByUsername(reviewWriterUsername);
            }
        } catch (Exception e) {
            log.error("좋아요 알림 전송 중 오류 발생", e);
        }
    }

    public void sendMovieStartNotification(Long memberId, Ticket ticket) {
        try {
            Movie movie = movieRepository.findById(ticket.getMovieId()).orElseThrow(() -> new RuntimeException("영화 정보를 찾을 수 없습니다."));
            Member member = getMemberOrThrow(memberId);
            Notification notification = createNotificationForMovieStart(member.getUsername(), ticket, movie);

            String message = String.format("%s님, 티켓 번호: %s, 영화: '%s', 좌석: %s, 상영 시간이 한 시간 남았습니다.",
                    member.getUsername(), ticket.getTicketId(), movie.getMvTitle(), ticket.getTicketedSeat());


            sseEmitterService.sendNotification(member.getUsername(), formatNotificationJson(notification, message));
            updateAndSendUnreadNotificationCount(memberId);
        } catch (Exception e) {
            log.error("영화 시작 알림 전송 중 오류 발생", e);
        }
    }

    public void updateAndSendUnreadNotificationCount(Long memberId) {
        Member member = getMemberOrThrow(memberId);
        updateAndSendUnreadNotificationCountByUsername(member.getUsername());
    }

    private void updateAndSendUnreadNotificationCountByUsername(String username) {
        long unreadCount = notificationRepository.countByUsernameAndIsReadFalse(username);
        String notificationCountJson = String.format("{\"type\": \"UNREAD_NOTIFICATION_COUNT\", \"count\": %d}", unreadCount);
        sseEmitterService.sendNotification(username, notificationCountJson);
    }

    public long getUnreadNotificationCount(String username) {
        return notificationRepository.countByUsernameAndIsReadFalse(username);
    }

    private Member getMemberOrThrow(Long memberId) {
        return memberRepository.findById(memberId).orElseThrow(() -> new RuntimeException("회원 정보를 찾을 수 없습니다. Member ID: " + memberId));
    }

    private Notification createNotificationForReviewLiked(String username, Long reviewId, String likerUsername) {
        Notification notification = Notification.builder()
                .username(username)
                .type(Notification.NotificationType.LIKE_NOTIFICATION)
                .reviewId(reviewId)
                .isRead(false)
                .isSent(true)
                .createdDateTime(LocalDateTime.now())
                .build();
        return notificationRepository.save(notification);
    }

    private Notification createNotificationForMovieStart(String username, Ticket ticket, Movie movie) {
        Notification notification = Notification.builder()
                .username(username)
                .type(Notification.NotificationType.MOVIE_BOOKED)
                .movieId(ticket.getMovieId())
                .ticketId(ticket.getTicketId())
                .isRead(false)
                .isSent(true)
                .createdDateTime(LocalDateTime.now())
                .build();
        return notificationRepository.save(notification);
    }

    private String formatNotificationJson(Notification notification, String message) {
        return String.format("{\"id\": \"%d\", \"message\": \"%s\", \"type\": \"%s\"}",
                notification.getId(), message, notification.getType().toString());
    }
}



