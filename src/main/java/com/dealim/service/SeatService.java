package com.dealim.service;

import com.dealim.domain.Member;
import com.dealim.domain.Seat;
import com.dealim.dto.PaidTicket;
import com.dealim.repository.SeatRepository;
import jakarta.transaction.Transactional;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class SeatService {
    @Autowired
    private SeatRepository seatRepository;

    public void saveSeats(PaidTicket paidTicket, Member loginUser) {
        String takenSeats = paidTicket.getTakenSeats();
        JSONArray jsonArray = new JSONArray(takenSeats);

        for (int i = 0; i < jsonArray.length(); i++) {
            int seat = jsonArray.getInt(i);
            seatRepository.save(Seat.builder()
                    .seatNumber(seat)
                    .theaterId(Long.valueOf(paidTicket.getTheaterId()))
                    .movieId(paidTicket.getMovieId())
                    .memberId(Long.parseLong(paidTicket.getMemberId()))
                    .ticketId(paidTicket.getTicketId())
                    .build());
        }
    }

    public Boolean isTakenSeats(Long movieId, Long theaterId, Integer seatNumber) {
        return seatRepository.existsByMovieIdAndTheaterIdAndSeatNumber(movieId, theaterId, seatNumber);
    }

    public List<Integer> getTakenSeats(Long movieId, Long theaterId) {
        return seatRepository.getTakenSeats(movieId, theaterId);
    }

    @Transactional
    public void deleteByTicketId(Long ticketId) {
        seatRepository.deleteByTicketId(ticketId);
    }
}
