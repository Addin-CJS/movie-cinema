package com.dealim.controller;

import com.dealim.service.SeatService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@Slf4j
@RequestMapping("/api/seats")
public class SeatController {
    @Autowired
    private SeatService seatService;

    @GetMapping("/isTaken")
    public Boolean isTaken(@RequestParam Long movieId, @RequestParam Long theaterId, @RequestParam Integer seatNumber) {
        return seatService.isTakenSeats(movieId, theaterId, seatNumber);
    }

    @GetMapping("/getTakenSeats")
    public List<Integer> getTakenSeats(@RequestParam Long movieId, @RequestParam Long theaterId, @RequestParam String selectedDate, @RequestParam String selectedTime) {
        LocalDateTime tickectedDate = LocalDateTime.parse(selectedDate + "T" + selectedTime);
        return seatService.getTakenSeats(movieId, theaterId, tickectedDate);
    }

    @GetMapping("/getTakenSeatsNumber")
    public Integer getTakenSeatsNumber(@RequestParam Long movieId, @RequestParam Long theaterId, @RequestParam String selectedDate, @RequestParam String selectedTime) {
        LocalDateTime tickectedDate = LocalDateTime.parse(selectedDate + "T" + selectedTime);
        return seatService.getTakenSeatsNumber(movieId, theaterId, tickectedDate);
    }
}
