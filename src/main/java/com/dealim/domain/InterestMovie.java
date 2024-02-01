package com.dealim.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class InterestMovie {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long interestMovieId;


    @Column(name = "movie_no")
    private Long movieNo;

    @Column(name = "user_name")
    private String username;

}
