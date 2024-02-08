package com.dealim.domain;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@SequenceGenerator(name = "role_SEQ", sequenceName = "role_SEQ", allocationSize = 1)
public class MemberRole {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "role_SEQ")
    private Long roleId;
    private String roleName;
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "memberId")
    private Member member;
}
