package com.dealim.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

@Entity
@Data
@SequenceGenerator(name = "seats_SEQ", sequenceName = "seats_SEQ", allocationSize = 1)
@EntityListeners(AuditingEntityListener.class)
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Seat {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seats_SEQ")
    private Long seatId;
    private Long movieId;
    private Long theaterId;
    private Integer seatNumber;
    private Long memberId;
    private Long ticketId;
}
