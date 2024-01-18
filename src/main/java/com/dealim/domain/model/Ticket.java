package com.dealim.domain.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import lombok.Data;

import java.time.LocalDateTime;

@Entity
@Data
public class Ticket {
    @Id
    @GeneratedValue
    private Long ticketId;
    private Long memberId;
    private Long movieId;
    private Long theaterId;
    private Double ticketPrice;
    private LocalDateTime ticketedDate;
    private String ticketedTheater;
    private String ticketedSeat;
    private LocalDateTime createdAt;
    private LocalDateTime modifiedAt;
    private LocalDateTime withdrawnAt;
    private Character isWithdrawn;
}
