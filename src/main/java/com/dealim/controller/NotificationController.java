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





}
