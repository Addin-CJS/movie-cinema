package com.dealim.dto;

import lombok.Data;

@Data
public class PaidTicket {
    private String selectedDate;
    private String selectedTime;
    private String takenSeats;
}
