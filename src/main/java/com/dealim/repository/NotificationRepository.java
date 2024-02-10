package com.dealim.repository;

import com.dealim.domain.Notification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, Long> {

    boolean existsByUsernameAndTypeAndMovieId(String username, Notification.NotificationType type, Long movieId);

    boolean existsByUsernameAndTypeAndReviewId(String username, Notification.NotificationType type, Long reviewId);

    @Query("SELECT COUNT(n) FROM Notification n WHERE n.movieId = :movieId AND n.type = :type AND n.createdDateTime BETWEEN :start AND :end")
    long countByMovieIdAndTypeAndCreatedDateTimeBetween(@Param("movieId") Long movieId, @Param("type") Notification.NotificationType type, @Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    }


