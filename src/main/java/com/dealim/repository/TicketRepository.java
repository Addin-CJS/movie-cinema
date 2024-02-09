package com.dealim.repository;

import com.dealim.domain.Ticket;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface TicketRepository extends JpaRepository<Ticket, Long> {
    @Query("SELECT t FROM Ticket t WHERE t.memberId = :memberId ORDER BY t.ticketedDate DESC")
    Page<Ticket> findAllByMemberId(@Param("memberId") Long memberId, Pageable pageable);
}