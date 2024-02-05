package com.dealim.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class MoviePopularity {
    private Long movieId;
    private Long count;
}
