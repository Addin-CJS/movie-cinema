package com.dealim.dto;

import lombok.Data;

@Data
public class PaidTicket {
    private Long ticketId;
    private Long movieId;
    private Double ticketPrice;
    private String selectedDate;
    private String selectedTime;
    private String takenSeats;
    private String theaterId;
    private String memberId;
}