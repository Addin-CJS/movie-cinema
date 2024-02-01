package com.dealim.dto;

import lombok.Data;

@Data
public class MyPageMember {
    private Long memberId;
    private String username;
    private String password;
    private String name;
    private String email;
    private String phoneNumber;
    private String homeAddress;
}
