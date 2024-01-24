package com.dealim.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.cglib.core.Local;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@SequenceGenerator(name = "movie_SEQ", sequenceName = "movie_SEQ", allocationSize = 1)
@EntityListeners(AuditingEntityListener.class)
public class Movie {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "movie_SEQ")
    private Long movieId;
    private String mvTitle;
    private String mvGenre;
    private String mvDescription;
    private String availablePeriod;
    private String availableTheater;
    @CreatedDate
    private LocalDateTime createdAt;
    @LastModifiedDate
    private LocalDateTime modifiedAt;
    private LocalDateTime withdrawnAt;
    private Character isWithdrawn;
    private String mvImg;
    private LocalDate mvReleaseDate;
    private Integer mvRuntime;
    private Float mvPopularity;
    private Character isAdult;
    private String mvVideo;
}
