package com.dealim.repository;

import com.dealim.domain.Notification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface NotificationRepository extends JpaRepository<Notification, Long> {

    boolean existsByUsernameAndTypeAndMovieId(String username, Notification.NotificationType type, Long movieId);

    boolean existsByUsernameAndTypeAndReviewId(String username, Notification.NotificationType type, Long reviewId);

    @Query("SELECT COUNT(n) FROM Notification n WHERE n.movieId = :movieId AND n.type = :type AND n.createdDateTime BETWEEN :start AND :end")
    long countByMovieIdAndTypeAndCreatedDateTimeBetween(@Param("movieId") Long movieId, @Param("type") Notification.NotificationType type, @Param("start") LocalDateTime start, @Param("end") LocalDateTime end);


    long countByUsernameAndIsReadFalse(String username);

    List<Notification> findByUsernameAndIsReadFalse(String username);

    List<Notification> findByUsernameAndCreatedDateTimeAfter(String username, LocalDateTime dateTime);

    boolean existsByUsernameAndTypeAndTicketId(String username, Notification.NotificationType notificationType, Long ticketId);

    boolean existsByTicketIdAndType(Long ticketId, Notification.NotificationType notificationType);
}


