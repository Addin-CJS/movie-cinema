package com.dealim.dto;

import com.dealim.domain.Announcement;
import lombok.Data;

import java.util.List;

@Data
public class AnnouncementPageDTO {
    private List<Announcement> announcements;
    private int nowPage;
    private int startPage;
    private int endPage;
    private int totalPage;
}
