package com.dealim.domain.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Entity
@Data
@SequenceGenerator(name = "movie_SEQ", sequenceName = "movie_SEQ", allocationSize = 1)
public class Movie {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "movie_SEQ")
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
