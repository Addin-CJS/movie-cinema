package com.dealim.domain;

import jakarta.persistence.*;
import lombok.Data;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;

@Entity
@Data
@SequenceGenerator(name = "member_SEQ", sequenceName = "member_SEQ", allocationSize = 1)
@EntityListeners(AuditingEntityListener.class)
public class Member {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "member_SEQ")
    private Long memberId;
    @Column(unique = true)
    private String username;
    private String password;
    private String name;
    private String email;
    private String phoneNumber;
    private String homeAddress;
    @CreatedDate
    @LastModifiedDate
    private LocalDateTime createdAt;
    private LocalDateTime modifiedAt;
    private LocalDateTime withdrawnAt;
    @Column(columnDefinition = "CHAR(1) default 'N'")
    private Character isWithdrawn;
}
