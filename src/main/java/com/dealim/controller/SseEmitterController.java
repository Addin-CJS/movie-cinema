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
public class SseEmitterController {

    @Autowired
    private NotificationService notificationService;
    @Autowired
    private SseEmitterService sseEmitterService;

    private final ExecutorService executorService = Executors.newSingleThreadExecutor();

    @GetMapping(path = "/connect/{username}", produces = "text/event-stream")
    public SseEmitter connectSseEmitter(@PathVariable String username, HttpServletResponse response) {
        log.info(username + " 사용자 연결 요청");
        response.setCharacterEncoding("UTF-8");
        return sseEmitterService.createEmitterForUser(username);
    }


    @GetMapping("/unread-count/{username}")
    public ResponseEntity<?> getUnreadNotificationCountConnect(@PathVariable String username) {
        try {
            long count = notificationService.getUnreadNotificationCount(username);
            return ResponseEntity.ok().body(Map.of("count", count));
        } catch (Exception e) {
            log.error("읽지 않은 알림 수 조회 중 오류 발생", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("error", "읽지 않은 알림 수를 가져올 수 없습니다요"));
        }
    }
}