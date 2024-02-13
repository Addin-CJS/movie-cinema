package com.dealim.controller;


import com.dealim.service.NotificationService;
import com.dealim.service.SseEmitterService;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@Slf4j
@RestController
public class NotificationController {

    @Autowired
    private NotificationService notificationService;
    @Autowired
    private SseEmitterService sseEmitterService;

    private final ExecutorService executorService = Executors.newSingleThreadExecutor();

    @GetMapping(path = "/connect/{username}", produces = "text/event-stream")
    public SseEmitter connect(@PathVariable String username, HttpServletResponse response) {
        System.out.println(username + " 사용자 연결 요청");
        response.setCharacterEncoding("UTF-8");
        return sseEmitterService.createEmitterForUser(username);
    }
    // TODO: :알림 이모티콘 만들기 , 알림목록조회 , 읽었는지 안읽었는지 확인하기, sout 안쓰는거 삭제하기 ,서비스측에
    //  updateAndSendUnreadNotificationCount메서드 이거 undifind처리 티켓아이디도


    @GetMapping("/unread-count/{username}") // 페이지를 처음 실행할 때 또는 수동으로 새로고침할 때 읽지 않은 알림의 수를 조회에 필요합니당!
    public ResponseEntity<?> getUnreadNotificationCount(@PathVariable String username) {
        try {
            long count = notificationService.getUnreadNotificationCount(username);
            return ResponseEntity.ok().body(Map.of("count", count));
        } catch (Exception e) {
            log.error("읽지 않은 알림 수 조회 중 오류 발생", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("error", "읽지 않은 알림 수를 가져올 수 없습니다요"));
        }
    }
}
