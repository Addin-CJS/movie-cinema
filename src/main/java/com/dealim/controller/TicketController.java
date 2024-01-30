package com.dealim.controller;

import com.dealim.domain.Member;
import com.dealim.domain.Movie;
import com.dealim.dto.PaidTicket;
import com.dealim.service.MovieService;
import com.dealim.service.TicketService;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@Slf4j
public class TicketController {
    @Autowired
    private MovieService movieService;
    @Autowired
    private TicketService ticketService;

    @GetMapping("/ticketing")
    public String ticketing(@RequestParam("movieId") Long movieId, Model model) {
        Movie selectedMovie = movieService.selectMovieDetailById(movieId).orElseThrow(() -> new RuntimeException("해당 id를 가진 영화가 없습니다"));
        model.addAttribute("movie", selectedMovie);
        return "movie/ticketing";
    }

    @PostMapping("/ticketing")
    public String payTicket(PaidTicket paidTicket, HttpSession session) {

        Member loginUser = (Member) session.getAttribute("loginUser");
        ticketService.saveTicket(paidTicket, loginUser);

        return "movie/ticketing";
    }
    // TODO: @ExceptionHandler or @ControllerAdvice를 통해 오류 처리할것
}
