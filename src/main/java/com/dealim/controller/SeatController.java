package com.dealim.controller;


import com.dealim.service.SeatService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@Slf4j
@RequestMapping("/api/seats")
public class SeatController {
    @Autowired
    private SeatService seatService;

    // TODO: 좌석에 있는지 확인하고 결과를 반환
    @GetMapping("/isTaken")
    public Boolean isTaken(@RequestParam Long movieId, @RequestParam Long theaterId, @RequestParam Integer seatNumber) {
        return seatService.isTakenSeats(movieId, theaterId, seatNumber);
    }

    @GetMapping("/getTakenSeats")
    public List<Integer> getTakenSeats(@RequestParam Long movieId, @RequestParam Long theaterId) {
        log.warn(seatService.getTakenSeats(movieId, theaterId).toString());
        return seatService.getTakenSeats(movieId, theaterId);
    }
}
