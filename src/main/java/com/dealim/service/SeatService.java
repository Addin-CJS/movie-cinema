package com.dealim.service;

import com.dealim.domain.Seat;
import com.dealim.repository.SeatRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SeatService {
    @Autowired
    private SeatRepository seatRepository;

    public Seat saveSeats(Long movieId, Long theaterId, Integer seatNumber) {
        return seatRepository.save(Seat.builder()
                .movieId(movieId)
                .theaterId(theaterId)
                .seatNumber(seatNumber)
                .build());
    }

    public Boolean isTakenSeats(Long movieId, Long theaterId, Integer seatNumber) {
        return seatRepository.existsByMovieIdAndTheaterIdAndSeatNumber(movieId, theaterId, seatNumber);
    }
}
