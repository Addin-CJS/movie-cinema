package com.dealim.controller;


import com.dealim.service.NotificationService;
import com.dealim.service.SseEmitterService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;


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
//
//    @GetMapping(path = "/notifications/{username}", produces = "text/event-stream")
//    public SseEmitter sendNotification(@PathVariable String username) {
//        final SseEmitter emitter = new SseEmitter();
//        executorService.execute(() -> {
//            try {
//
//                String notificationJson = String.format("{\"message\": \"안녕하세요, %s님. 새로운 알림이 있습니다ㅋㅋ.\", \"type\": \"NEW_MESSAGE\"}", username);
//                emitter.send(SseEmitter.event().name("notification").data(notificationJson));
//                emitter.complete();
//            } catch (Exception e) {
//                emitter.completeWithError(e);
//            }
//        });
//        return emitter;
//    }
















//    private ExecutorService executor = Executors.newCachedThreadPool();
//
//    @GetMapping(path = "/notifications/{username}", produces = "text/event-stream")
//    public SseEmitter handle(@PathVariable String username) {
//        SseEmitter emitter = new SseEmitter(); // 타임아웃을 무한으로 설정 // 지워야함 테스트 끝나고
//        executor.execute(() -> {
//            try {
//
//                    emitter.send(SseEmitter.event().name("notification")
//                        .data("notic."));
//                        emitter.complete();
//            } catch (Exception ex) {
//                emitter.completeWithError(ex);
//            }
//        });
//        return emitter;
//    }
}
