package com.dealim.domain;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Entity
@Data
@SequenceGenerator(name = "ticket_SEQ", sequenceName = "ticket_SEQ", allocationSize = 1)
public class Ticket {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "ticket_SEQ")
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
