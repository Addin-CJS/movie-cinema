package com.dealim.service;

import com.dealim.domain.Member;
import com.dealim.domain.Movie;
import com.dealim.domain.Ticket;
import com.dealim.dto.PaidTicket;
import com.dealim.repository.MemberRepository;
import com.dealim.repository.MovieRepository;
import com.dealim.repository.TicketRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@Service
@Slf4j
public class TicketService {

    @Autowired
    private TicketRepository ticketRepository;

    @Autowired
    private MovieRepository movieRepository;

    @Autowired
    private MemberRepository memberRepository;

    public Ticket saveTicket(PaidTicket paidTicket, Member loginUser) {

        // 날짜 형식에 맞는 정규 표현식 패턴
        Pattern pattern = Pattern.compile("(\\d+)월 (\\d+)일");
        Matcher matcher = pattern.matcher(paidTicket.getSelectedDate());

        LocalDateTime dateTime = null;
        if (matcher.find()) {
            // 연도는 현재 연도로 설정, 월과 일은 문자열에서 추출
            String year = String.valueOf(LocalDateTime.now().getYear());
            String month = matcher.group(1);
            String day = matcher.group(2);

            // 날짜와 시간을 결합
            String dateTimeStr = year + "-" + month + "-" + day + "T" + paidTicket.getSelectedTime();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-M-d'T'HH:mm");

            // 문자열을 LocalDateTime 객체로 파싱
            dateTime = LocalDateTime.parse(dateTimeStr, formatter);
        }

        Ticket ticket = Ticket.builder()
                .memberId(loginUser.getMemberId())
                .movieId(paidTicket.getMovieId())
                .ticketPrice(paidTicket.getTicketPrice())
                .ticketedDate(dateTime)
                .ticketedSeat(paidTicket.getTakenSeats())
                .build();

        return ticketRepository.save(ticket);
    }

    public Page<Ticket> getMyTickets(Long memberId, Pageable pageable, Model model) {
        Page<Ticket> myTicketList = ticketRepository.findAllByMemberId(memberId, pageable);

        //memberId로 username가져오기
        List<Long> memberIdsList = myTicketList.getContent().stream()
                                                            .map(Ticket::getMemberId)
                                                            .collect(Collectors.toList());
        List<Member> memberList = memberRepository.findByMemberIdIn(memberIdsList);
        Map<Long, String> username = memberList.stream()
                                               .collect(Collectors.toMap(Member::getMemberId, Member::getUsername));

        // movieId로 mvTitle 가져오기
        List<Long> movieIdsList = myTicketList.getContent().stream()
                                                           .map(Ticket::getMovieId)
                                                           .collect(Collectors.toList());
        List<Movie> movieList = movieRepository.findByMovieIdIn(movieIdsList);
        Map<Long, String> movieTitle = movieList.stream()
                                                .collect(Collectors.toMap(Movie::getMovieId, Movie::getMvTitle));

        // movieId로 runtime 가져오기
        Map<Long, Integer> movieRuntimes = movieList.stream()
                                                    .collect(Collectors.toMap(Movie::getMovieId, Movie::getMvRuntime));

        Map<Long, String> movieImgs = movieList.stream()
                                               .collect(Collectors.toMap(Movie::getMovieId, Movie::getMvImg));

        int nowPage = myTicketList.getPageable().getPageNumber();
        int totalPages = myTicketList.getTotalPages();
        int pageGroupSize = 5;
        int currentPageGroup = nowPage / pageGroupSize;
        int startPage = currentPageGroup * pageGroupSize;
        int endPage = (totalPages > 0) ? Math.min(startPage + pageGroupSize - 1, totalPages - 1) : 0;

        model.addAttribute("myTicketList", myTicketList.getContent());
        model.addAttribute("username", username);
        model.addAttribute("movieImgs", movieImgs);
        model.addAttribute("movieTitle", movieTitle);
        model.addAttribute("movieRuntimes", movieRuntimes);
        model.addAttribute("nowPage", nowPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalPages", totalPages);

        return myTicketList;
    }

    public void deleteTicket(Long ticketId) {
        ticketRepository.deleteById(ticketId);
    }
}
