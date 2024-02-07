package com.dealim.service;

import com.dealim.domain.Notification;
import com.dealim.repository.NotificationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
public class NotificationService {

    @Autowired
    private NotificationRepository notificationRepository;

    @Autowired
    private  SseEmitterService sseEmitterService;

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
            System.out.println("json~~~~~~"+notificationJson);
            // SseEmitterService를 사용하여 특정 사용자에게 알림 전송 코드임
            sseEmitterService.sendNotification(username, notificationJson);

        }
    }




//    public void createNotification(String username, String message, Notification.NotificationType type) {
//        Notification notification = new Notification();
//        notification.setUsername(username);
//        notification.setType(type);
//        notification.setRead(false);
//        notification.setCreatedDateTime(LocalDateTime.now());
//        notificationRepository.save(notification);
//    }
//    public void sendInterestMovieAddedNotification(String username, Long movieId) {
//
//        boolean alreadyExists = notificationRepository.existsByUsernameAndTypeAndMovieId(username, Notification.NotificationType.INTEREST_MOVIE_ADDED, movieId);
//        if (!alreadyExists) {
//            Notification notification = new Notification();
//            notification.setUsername(username);
//            notification.setType(Notification.NotificationType.INTEREST_MOVIE_ADDED);
//            notification.setMovieId(movieId);
//            notification.setRead(false);
//            notification.setSent(true);
//            notification.setCreatedDateTime(LocalDateTime.now());
//            Notification savedNotification = notificationRepository.save(notification);
//
//            // 고유 ID를 포함한 알림 데이터 생성
//            String notificationJson = String.format("{\"id\": \"%d\", \"message\": \"안녕하세요, %s님. 관심 영화 '%d'가 추가되었습니다.\", \"type\": \"INTEREST_MOVIE_ADDED\"}", savedNotification.getId(), username, movieId);
//
//        }
//    }

}
