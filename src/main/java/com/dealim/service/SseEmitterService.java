package com.dealim.service;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

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
        SseEmitter emitter = new SseEmitter(Long.MAX_VALUE);
        this.userEmitters.put(username, emitter);

        emitter.onCompletion(() -> {
            this.userEmitters.remove(username);
            System.out.println(username + " 연결 완료");
        });

        emitter.onTimeout(() -> {
            emitter.complete();
            this.userEmitters.remove(username);
            System.out.println(username + " 연결 타임아웃");
        });

        emitter.onError((e) -> {
            emitter.completeWithError(e);
            this.userEmitters.remove(username);
            System.out.println(username + " 연결 오류: " + e.getMessage());
        });

        return emitter;
    }

    public void sendNotification(String username, String notificationJson) {
        SseEmitter emitter = userEmitters.get(username);
        System.out.println("Sending notification if 들어가기전 see서비스 부분: " + notificationJson); // 로그 추가
        System.out.println("Sending notification if 들어가기전 see서비스 부분: " +  username); // 로그 추가
        if (emitter != null) {
            try {
                System.out.println("Sending notification if 들어간후: " + notificationJson); // 로그 추가
                emitter.send(SseEmitter.event().name("notification").data(notificationJson));
            } catch (IOException e) {
                emitter.completeWithError(e);
                userEmitters.remove(username);
            }
        }
    }
}