package com.dealim.domain;

import jakarta.persistence.*;
import lombok.Data;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;

@Entity
@Data
@SequenceGenerator(name = "theater_SEQ", sequenceName = "theater_SEQ", allocationSize = 1)
@EntityListeners(AuditingEntityListener.class)
public class Theater {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "theater_SEQ")
    private Long theaterId;
    private Long regionId;
    private String theaterName;
    @CreatedDate
    private LocalDateTime createdAt;
    @LastModifiedDate
    private LocalDateTime modifiedAt;
    private LocalDateTime withdrawnAt;
    @Column(columnDefinition = "CHAR(1) default 'N'")
    private Character isWithdrawn;
}
