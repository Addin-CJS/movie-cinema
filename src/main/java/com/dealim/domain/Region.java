package com.dealim.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Region {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "region_seq_generator")
    @SequenceGenerator(name = "region_seq_generator", sequenceName = "REGION_SEQ", allocationSize = 1)
    private Long regionId;

    @Column(length = 255)
    private String regionName;

    @Column(columnDefinition = "CHAR")
    private char isWithdrawn;

    @Column
    private LocalDateTime createdAt;

    @Column
    private LocalDateTime modifiedAt;

    @Column
    private LocalDateTime withdrawnAt;
}