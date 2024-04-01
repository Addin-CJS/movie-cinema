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
@SequenceGenerator(name="announcement_SEQ", sequenceName = "announcement_SEQ", allocationSize = 1)
public class Announcement {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "announcement_SEQ")
    private Long id;
    private String username;
    private String title;

    private String content;
    @CreatedDate
    @Column(name = "createDate")
    private LocalDateTime createAnnouncementDate;
    @LastModifiedDate
    @Column(name = "updateDate")
    private LocalDateTime updateAnnouncementDate;

}
