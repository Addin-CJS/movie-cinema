package com.dealim.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;



@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Notification {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "user_name")
    private String username;
    @Enumerated(EnumType.STRING)
    private NotificationType type;
    private boolean isRead = false;
    private boolean isSent = false;

    private LocalDateTime createdDateTime = LocalDateTime.now();
    private Long movieId;
    @Column(name = "review_id")
    private Long reviewId;

    public enum NotificationType {
        INTEREST_MOVIE_ADDED,
        LIKE_NOTIFICATION,
        MOVIE_BOOKED
    }

}



