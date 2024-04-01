package com.dealim.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class MovieInterest {
    private Long movieId;
    private Long count;
}