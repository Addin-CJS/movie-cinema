package com.dealim.domain;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;
import java.util.List;

@Entity
@Data
@SequenceGenerator(name = "member_SEQ", sequenceName = "member_SEQ", allocationSize = 1)
@EntityListeners(AuditingEntityListener.class)
@Builder
@AllArgsConstructor
@NoArgsConstructor
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
    @Column
    private Character isWithdrawn = 'N';
    private String provider;
    private String providerId;
    @OneToMany(mappedBy = "member", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JsonIgnore
    private List<MemberRole> roles;
}