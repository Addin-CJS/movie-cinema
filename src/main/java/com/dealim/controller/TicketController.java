package com.dealim.controller;

import com.dealim.domain.Member;
import com.dealim.domain.Movie;
import com.dealim.domain.Ticket;
import com.dealim.dto.PaidTicket;
import com.dealim.security.custom.CustomUserDetails;
import com.dealim.service.MovieService;
import com.dealim.service.SeatService;
import com.dealim.service.TicketService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@Controller
@Slf4j
@RequestMapping("/ticketing")
public class TicketController {
    @Autowired
    private MovieService movieService;
    @Autowired
    private TicketService ticketService;
    @Autowired
    private SeatService seatService;

    @GetMapping("")
    public String ticketing(@RequestParam("movieId") Long movieId, Model model) {
        Movie selectedMovie = movieService.selectMovieDetailById(movieId).orElseThrow(() -> new RuntimeException("해당 id를 가진 영화가 없습니다"));
        model.addAttribute("movie", selectedMovie);
        return "movie/ticketing";
    }

    @PostMapping("")
    public String payTicket(PaidTicket paidTicket, @AuthenticationPrincipal CustomUserDetails customUserDetails) {
        Member loginUser = customUserDetails.getMember();
        Ticket savedTicket = ticketService.saveTicket(paidTicket, loginUser);
        seatService.saveSeats(savedTicket, loginUser);

        return "movie/ticketing";
    }

    @GetMapping("/success")
    public String success() {
        return "movie/ticketingSuccess";
    }

    @DeleteMapping("/delete")
    @ResponseBody
    public ResponseEntity<?> deleteTicket(@RequestParam("ticketId") Long ticketId) {
        try {
            ticketService.deleteTicket(ticketId);
            seatService.deleteByTicketId(ticketId);
            return ResponseEntity.status(HttpStatus.OK).body(Map.of("status", "success", "message", "티켓이 성공적으로 삭제되었습니다."));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(Map.of("status", "failure", "message", "티켓 삭제 중 오류가 발생했습니다."));
        }
    }
}