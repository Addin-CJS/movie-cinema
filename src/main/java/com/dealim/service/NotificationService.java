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
import java.util.Optional;
@Slf4j
@Service
public class NotificationService {

    @Autowired
    private NotificationRepository notificationRepository;

    @Autowired
    private  SseEmitterService sseEmitterService;

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
            System.out.println("json~~~~~~"+notificationJson);
            // 특정 사용자에게 알림 전송 코드임
            sseEmitterService.sendNotification(username, notificationJson);

        }
    }
    public void sendLikeNotification(Long reviewId, String likerUsername) {
        Review review = reviewRepository.findById(reviewId)
                .orElseThrow(() -> new RuntimeException("리뷰를 찾을 수 없습니다."));
        String  reviewWriterUsername = review.getReviewWriter(); // 리뷰 작성자의 사용자명

        // 좋아요 알림이 이미 존재하는지 확인 코드임
        if (!notificationRepository.existsByUsernameAndTypeAndReviewId(reviewWriterUsername, Notification.NotificationType.LIKE_NOTIFICATION, reviewId)) {
            // 새로운 좋아요 알림 객체 생성 및 저장 코드임
            Notification notification = Notification.builder()
                    .username(reviewWriterUsername)
                    .type(Notification.NotificationType.LIKE_NOTIFICATION)
                    .reviewId(reviewId)
                    .isRead(false)
                    .isSent(true)
                    .createdDateTime(LocalDateTime.now())
                    .build();
            Notification savedNotification = notificationRepository.save(notification);

            // 알림 json 생성 코드임  키:값
            String notificationJson = String.format("{\"id\": \"%d\", \"message\": \"%s님이 당신의 리뷰 %d에 좋아요를 눌렀습니다.\", \"type\": \"LIKE_NOTIFICATION\"}",
                                                savedNotification.getId(),
                                                likerUsername,
                                                reviewId);

            // 특정 사용자에게 알림 전송하는 코드 코드임
            sseEmitterService.sendNotification(reviewWriterUsername, notificationJson);
        }
    }

    public void sendMovieStartNotification(Long memberId, Ticket ticket) {
        try {
            // 영화 정보 조회
            Optional<Movie> movieOpt = movieRepository.findById(ticket.getMovieId());
            if (!movieOpt.isPresent()) {
                log.error("영화 정보를 찾을 수 없습니다. Movie ID: {}", ticket.getMovieId());
                return;
            }
            Movie movie = movieOpt.get();

            // 회원 정보 조회 코드임
            Optional<Member> memberOpt = memberRepository.findById(memberId);
            if (!memberOpt.isPresent()) {
                log.error("회원 정보를 찾을 수 없습니다. Member ID: {}", memberId);
                return;
            }
            Member member = memberOpt.get();

            // 알림 객체 생성 및 저장 코드임
            Notification notification = Notification.builder()
                    .username(member.getUsername())
                    .type(Notification.NotificationType.MOVIE_BOOKED)
                    .movieId(ticket.getMovieId())
                    .isRead(false)
                    .isSent(true)
                    .createdDateTime(LocalDateTime.now())
                    .build();
            Notification savedNotification = notificationRepository.save(notification);

            // 알림 json 생성 코드임  키:값
            String notificationJson = String.format(
                    "{\"id\": %d, \"message\": \"안녕하세요, 영화 '%s' 상영 시간이 한 시간 남았습니다! 상영시간: %s, 좌석: %s\", \"type\": \"MOVIE_BOOKED\"}",
                    savedNotification.getId(),
                    movie.getMvTitle(),
                    ticket.getTicketedDate().toString(),
                    ticket.getTicketedSeat());

            log.info("영화 알림을 보냅니다 - {}", notificationJson);

            //알림 전송하는 코드 코드임
            sseEmitterService.sendNotification(member.getUsername(), notificationJson);
        } catch (Exception e) {
            log.error("영화 시작 알림 전송 중 오류 발생", e);
        }
    }
}




