package com.dealim.controller;

import com.dealim.domain.Member;
import com.dealim.domain.Movie;
import com.dealim.dto.PaidTicket;
import com.dealim.security.custom.CustomUserDetails;
import com.dealim.service.MovieService;
import com.dealim.service.SeatService;
import com.dealim.service.TicketService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
        ticketService.saveTicket(paidTicket, loginUser);

        seatService.saveSeats(paidTicket, loginUser);

        return "movie/ticketing";
    }

    @GetMapping("/success")
    public String success() {

        return "movie/ticketingSuccess";
    }
    // TODO: @ExceptionHandler or @ControllerAdvice를 통해 오류 처리할것
}
