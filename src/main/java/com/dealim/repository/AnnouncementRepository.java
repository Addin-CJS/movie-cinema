package com.dealim.repository;

import com.dealim.domain.Announcement;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository

public interface AnnouncementRepository  extends JpaRepository<Announcement, Long>{
    List<Announcement> findAllByOrderByIdDesc();
}
