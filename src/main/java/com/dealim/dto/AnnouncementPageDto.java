package com.dealim.dto;

import com.dealim.domain.Announcement;
import lombok.Data;

import java.util.List;

@Data
public class AnnouncementPageDto {
    private List<Announcement> announcements;
    private int nowPage;
    private int startPage;
    private int endPage;
    private int totalPage;
}
