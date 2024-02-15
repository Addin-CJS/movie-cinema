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
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

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

        if (!notificationRepository.existsByUsernameAndTypeAndMovieId(username, Notification.NotificationType.INTEREST_MOVIE_ADDED, movieId)) {

            Notification notification = Notification.builder()
                    .username(username)
                    .type(Notification.NotificationType.INTEREST_MOVIE_ADDED)
                    .movieId(movieId)
                    .isRead(false)
                    .isSent(true)
                    .createdDateTime(LocalDateTime.now())
                    .build();
            Notification savedNotification = notificationRepository.save(notification);

            String notificationJson = String.format("{\"id\": \"%d\", \"message\": \"안녕하세요, %s님. 관심 영화 '%d'가 추가되었습니다.\", \"type\": \"INTEREST_MOVIE_ADDED\"}",
                    savedNotification.getId(),
                    username,
                    movieId);
            System.out.println("json~~~~~~" + notificationJson);

            sseEmitterService.sendNotification(username, notificationJson);

        }
    }

    public void sendLikeNotification(Long reviewId, String likerUsername) {
        try {
            Review review = reviewRepository.findById(reviewId).orElseThrow(() -> new RuntimeException("리뷰를 찾을 수 없습니다."));
            String reviewWriterUsername = review.getReviewWriter();

            if (!notificationRepository.existsByUsernameAndTypeAndReviewId(reviewWriterUsername, Notification.NotificationType.LIKE_NOTIFICATION, reviewId)) {
                String message = likerUsername + "님이 당신의 " + review.getReviewId() + "번 영화후기 에 좋아요를 눌렀습니다.";
                Notification notification = createNotificationForReviewLiked(reviewWriterUsername, reviewId, message);

                sseEmitterService.sendNotification(reviewWriterUsername, formatNotificationJson(notification, message, null));
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
            boolean notificationExists = notificationRepository.existsByUsernameAndTypeAndTicketId(member.getUsername(), Notification.NotificationType.MOVIE_BOOKED, ticket.getTicketId());

            if (!notificationExists) {
                LocalDateTime showtime = ticket.getTicketedDate();
                String showtimeFormatted = showtime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));

                String message = String.format("%s님의 예매내역, <br>티켓 번호: %d, <br>영화 제목: '%s', <br>좌석 번호: '%s', <br>상영 시간: %s",
                        member.getUsername(), ticket.getTicketId(), movie.getMvTitle(), ticket.getTicketedSeat(), showtimeFormatted);

                Notification notification = createNotificationForMovieStart(member.getUsername(), ticket, movie, message);

                sseEmitterService.sendNotification(member.getUsername(), formatNotificationJson(notification, message, showtime));

                updateAndSendUnreadNotificationCount(memberId);
            }
        } catch (Exception e) {
            log.error("영화 시작 알림 전송 중 오류 발생", e);
        }
    }

    private Notification createNotificationForReviewLiked(String username, Long reviewId, String message) {
        Notification notification = Notification.builder()
                .username(username)
                .type(Notification.NotificationType.LIKE_NOTIFICATION)
                .reviewId(reviewId)
                .isRead(false)
                .isSent(true)
                .createdDateTime(LocalDateTime.now())
                .message(message)
                .build();
        return notificationRepository.save(notification);
    }

    private Notification createNotificationForMovieStart(String username, Ticket ticket, Movie movie, String message) {
        Notification notification = Notification.builder()
                .username(username)
                .type(Notification.NotificationType.MOVIE_BOOKED)
                .movieId(ticket.getMovieId())
                .ticketId(ticket.getTicketId())
                .isRead(false)
                .isSent(true)
                .createdDateTime(LocalDateTime.now())
                .message(message)
                .build();

        return notificationRepository.save(notification);
    }

    private String formatNotificationJson(Notification notification, String message, LocalDateTime showtime) {
        StringBuilder jsonBuilder = new StringBuilder();

        jsonBuilder.append(String.format("{\"id\": \"%d\", \"message\": \"%s\"", notification.getId(), message));

        if (showtime != null) {
            String showtimeFormatted = showtime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
            jsonBuilder.append(String.format(", \"showtime\": \"%s\"", showtimeFormatted));
        }

        jsonBuilder.append(String.format(", \"type\": \"%s\"}", notification.getType().toString()));

        return jsonBuilder.toString();
    }

    public void setNotificationAsRead(Long notificationId) {
        Optional<Notification> optionalNotification = notificationRepository.findById(notificationId);
        if (optionalNotification.isPresent()) {
            Notification notification = optionalNotification.get();
            notification.setRead(true);
           notificationRepository.save(notification);
        } else {
            throw new RuntimeException("해당알림이 존재하지않거나 오류입니다: " + notificationId);
        }
    }

    public void setAllNotificationAsRead(){
        List<Notification> notifications = notificationRepository.findAllByIsReadFalse();
        for (Notification notification :notifications) {
            notification.setRead(true);
        }
        notificationRepository.saveAll(notifications);
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

    //알림 목록
    public List<Notification> getUserNotifications(String username) {
        return notificationRepository.findByUsernameAndIsReadFalse(username);
    }
}



