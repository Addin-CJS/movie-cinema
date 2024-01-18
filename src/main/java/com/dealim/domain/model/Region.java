package com.dealim.domain.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;

@Entity
@Data
@SequenceGenerator(name = "region_SEQ", sequenceName = "region_SEQ", allocationSize = 1)
public class Region {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "region_SEQ")
    private Long regionId;
    private String regionName;
    private LocalDateTime createdAt;
    private LocalDateTime modifiedAt;
    private LocalDateTime withdrawnAt;
    private Character isWithdrawn;
}
