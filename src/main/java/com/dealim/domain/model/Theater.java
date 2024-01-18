package com.dealim.domain.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Entity
@Data
@SequenceGenerator(name = "theater_SEQ", sequenceName = "theater_SEQ", allocationSize = 1)
public class Theater {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "theater_SEQ")
    private Long theaterId;
    private int theaterSeats;
    private Long regionId;
    private LocalDateTime createdAt;
    private LocalDateTime modifiedAt;
    private LocalDateTime withdrawnAt;
    private Character isWithdrawn;
}
