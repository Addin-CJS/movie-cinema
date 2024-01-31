package com.dealim.service;

import com.dealim.domain.Member;
import com.dealim.domain.Ticket;
import com.dealim.dto.PaidTicket;
import com.dealim.repository.TicketRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@Slf4j
public class TicketService {

    @Autowired
    private TicketRepository ticketRepository;
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
}
