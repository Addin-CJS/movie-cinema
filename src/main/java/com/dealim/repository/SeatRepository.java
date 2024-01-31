package com.dealim.repository;

import com.dealim.domain.Seat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SeatRepository extends JpaRepository<Seat, Long> {
    boolean existsByMovieIdAndTheaterIdAndSeatNumber(Long movieId, Long theaterId, Integer seatNumber);

}
