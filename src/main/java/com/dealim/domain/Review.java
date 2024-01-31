package com.dealim.domain;

import jakarta.persistence.*;
import lombok.Data;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;

@Entity
@Data
@EntityListeners(AuditingEntityListener.class)
@SequenceGenerator(name="review_SEQ", sequenceName = "review_SEQ", allocationSize = 1)
public class Review {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "review_SEQ")
    private Long reviewId;
    private String reviewContent;
    private int movieNo;
    private String reviewWriter;

    @Column(nullable = true, columnDefinition = "integer default 0")
    private Integer likeCount;

    @Column(nullable = false, columnDefinition = "NUMBER(1) default 0")
    private int starRating;

    @CreatedDate
    @Column(name="createDate")
    private LocalDateTime createReviewDate;
    @LastModifiedDate
    @Column(name="updateDate")
    private LocalDateTime updateReviewDate;
}
