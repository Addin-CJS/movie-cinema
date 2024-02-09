package com.dealim.repository;

import com.dealim.domain.Notification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, Long> {

    boolean existsByUsernameAndTypeAndMovieId(String username, Notification.NotificationType type, Long movieId);

    boolean existsByUsernameAndTypeAndReviewId(String username, Notification.NotificationType type, Long reviewId);
    }