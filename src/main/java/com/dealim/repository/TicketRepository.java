package com.dealim.repository;

import com.dealim.domain.Ticket;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface TicketRepository extends JpaRepository<Ticket, Long> {
    Page<Ticket> findAllByMemberId(@Param("memberId") Long memberId, Pageable pageable);

    @Query("SELECT t FROM Ticket t WHERE t.ticketedDate BETWEEN :start AND :end")
    List<Ticket> findByTicketedDateBetween(@Param("start") LocalDateTime start, @Param("end") LocalDateTime end);

    boolean existsByMovieIdAndMemberId(int movieNo, Long memberId);
}