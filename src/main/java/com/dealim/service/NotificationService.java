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
                String message = likerUsername + "님이 당신의 " + review.getReviewId() + "번 영화후기 에 좋아요를 눌렀습니다.";
                Notification notification = createNotificationForReviewLiked(reviewWriterUsername, reviewId, message);

                sseEmitterService.sendNotification(reviewWriterUsername, formatNotificationJson(notification,  message));
                updateAndSendUnreadNotificationCountByUsername(reviewWriterUsername);  // 미확인 알림 메서드 안하면  실시간으로 반영안되고 새로고침해야함
            }
        } catch (Exception e) {
            log.error("좋아요 알림 전송 중 오류 발생", e);
        }
    }

    public void sendMovieStartNotification(Long memberId, Ticket ticket) {
        try {
            Movie movie = movieRepository.findById(ticket.getMovieId()).orElseThrow(() -> new RuntimeException("영화 정보를 찾을 수 없습니다."));
            Member member = getMemberOrThrow(memberId);

            String message = member.getUsername() + "님, 티켓 번호 " + ticket.getTicketId() + ", 영화 '" + movie.getMvTitle() + "'의 상영 시간이 한 시간 남았습니다.";
            Notification notification = createNotificationForMovieStart(member.getUsername(), ticket, message);

            sseEmitterService.sendNotification(member.getUsername(), formatNotificationJson(notification, message));
            updateAndSendUnreadNotificationCount(memberId); // 미확인 알림 메서드 안하면  실시간으로 반영안되고 새로고침해야함
        } catch (Exception e) {
            log.error("영화 시작 알림 전송 중 오류 발생", e);
        }
    }

    //읽지않은 알림 카운트 업데이트및 보내주는 메서드  memberId로
    public void updateAndSendUnreadNotificationCount(Long memberId) {
        Member member = getMemberOrThrow(memberId);
        updateAndSendUnreadNotificationCountByUsername(member.getUsername());
    }
    //읽지않은 알림 카운트 업데이트및 보내주는 메서드 username으로
    private void updateAndSendUnreadNotificationCountByUsername(String username) {
        long unreadCount = notificationRepository.countByUsernameAndIsReadFalse(username);
        String notificationCountJson = String.format("{\"type\": \"UNREAD_NOTIFICATION_COUNT\", \"count\": %d}", unreadCount);
        sseEmitterService.sendNotification(username, notificationCountJson);
    }

    // getUnreadNotificationCount 컨트롤러에서 사용하는 메서드 알림수를 위한
    public long getUnreadNotificationCount(String username) {
        return notificationRepository.countByUsernameAndIsReadFalse(username);
    }


    //좋아요 알림을 생성하는 객체 메서드
    private Notification createNotificationForReviewLiked(String username, Long reviewId ,String message) {
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
    //영화시작 알림을 생성하는 객체 메서드
    private Notification createNotificationForMovieStart(String username, Ticket ticket ,String message ) {
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

    //알림 id, 메시지, 타입 내용등
    private String formatNotificationJson(Notification notification, String message) {
        return String.format("{\"id\": \"%d\", \"message\": \"%s\", \"type\": \"%s\"}",
                notification.getId(), message, notification.getType().toString());
    }

    //예외처리 하는거 메서드
    private Member getMemberOrThrow(Long memberId) {
        return memberRepository.findById(memberId).orElseThrow(() -> new RuntimeException("회원 정보를 찾을 수 없습니다. Member ID: " + memberId));
    }

    //알림 목록
    public List<Notification> getUserNotifications(String username) {
       // List<Notification> notifications =
        return  notificationRepository.findByUsernameAndIsReadFalse(username);
    }



    public Notification readNotification(Long notificationId) {
        Optional<Notification> optionalNotification = notificationRepository.findById(notificationId);
        if (optionalNotification.isPresent()) {
            Notification notification = optionalNotification.get();
            notification.setRead(true);
            return notificationRepository.save(notification);
        } else {

            throw new RuntimeException("해당알림이 존재하지않거나 오류입니다: " + notificationId);
        }
    }
}



