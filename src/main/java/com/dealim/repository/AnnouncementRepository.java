package com.dealim.repository;

import com.dealim.domain.Announcement;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository

public interface AnnouncementRepository  extends JpaRepository<Announcement, Long>{
    Page<Announcement> findAllByOrderByIdDesc(Pageable pageable);

    List<Announcement> findAllByOrderByIdDesc();
}
