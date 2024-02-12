package com.dealim.controller;


import com.dealim.domain.Notification;
import com.dealim.service.NotificationService;
import com.dealim.service.SseEmitterService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
@Slf4j
@Controller
public class NotificationController {
    @Autowired
    private NotificationService notificationService;
    @Autowired
    private SseEmitterService sseEmitterService;


    @GetMapping("/notifications/{username}")
    public String getUserNotifications(@PathVariable String username, Model model) {
        List<Notification> notifications = notificationService.getUserNotifications(username);
        model.addAttribute("notifications", notifications);
        return "notification/notificationsList";
    }

    @PostMapping("/notifications/{notificationId}/readNotification")
    @ResponseBody
    public ResponseEntity<String> markNotificationAsRead(@PathVariable Long notificationId) {

        notificationService.readNotification(notificationId);

        return ResponseEntity.ok("Success");
    }

}
