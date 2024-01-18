package com.dealim.domain.model;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import lombok.Data;

import java.time.LocalDateTime;

@Entity
@Data
public class Movie {
    @Id
    @GeneratedValue
    private Long movieId;
    private String mvTitle;
    private String mvGenre;
    private String mvDescription;
    private String availablePeriod;
    private String availableTheater;
    private LocalDateTime createdAt;
    private LocalDateTime modifiedAt;
    private LocalDateTime withdrawnAt;
    private Character isWithdrawn;
    private byte[] mvImg;
}
