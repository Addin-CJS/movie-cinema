package com.dealim.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
@Slf4j
@Service
public class SseEmitterService {
    private final Map<String, SseEmitter> userEmitters = new ConcurrentHashMap<>();

    public void addUserEmitter(String username, SseEmitter emitter) {
        this.userEmitters.put(username, emitter);
    }

    public void removeEmitter(String username) {
        this.userEmitters.remove(username);
    }

    public SseEmitter createEmitterForUser(String username) {
       // SseEmitter emitter = new SseEmitter(Long.MAX_VALUE);
        SseEmitter emitter = new SseEmitter(300_000L); //5분
      // SseEmitter emitter = new SseEmitter(60000L); // 1분
        this.userEmitters.put(username, emitter);

        emitter.onCompletion(() -> {
            this.userEmitters.remove(username);
            log.info("{} 연결 완료", username);
        });

        emitter.onTimeout(() -> {
            emitter.complete();
            this.userEmitters.remove(username);
            log.info("{} 연결 타임아웃", username);
        });

        emitter.onError((e) -> {
            emitter.completeWithError(e);
            this.userEmitters.remove(username);
            log.error("{} 연결 오류: {}", username, e.getMessage());
        });

        return emitter;
    }

    public void sendNotification(String username, String notificationJson) {
        SseEmitter emitter = userEmitters.get(username);
        if (emitter != null) {
            try {
                emitter.send(SseEmitter.event().name("notification").data(notificationJson));
                log.info("알림 sendNotification -> {}: {}", username, notificationJson);
            } catch (IOException e) {
                emitter.completeWithError(e);
                userEmitters.remove(username);
                log.error("오류 sending notification x {}: {}", username, e.getMessage());
            }
        }
    }
}