package com.dealim.domain;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class MovieTheater {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "movie_id")
    private Long movieId;

    @Column(name = "theater_id")
    private Long theaterId;

    public MovieTheater(Long movieId, Long theaterId) {
        this.movieId = movieId;
        this.theaterId = theaterId;
    }
}