package com.dealim.controller;


import com.dealim.domain.Announcement;
import com.dealim.dto.EditAnnounceDto;
import com.dealim.service.AnnouncementService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Slf4j
@Controller

public class AnnouncementController {
    @Autowired
    AnnouncementService announcementService;

    @GetMapping("/announceList")
    public String getAnnounceList(Model model) {

        List<Announcement> announceList = announcementService.getAnnounceList();
        model.addAttribute("announceList", announceList);
        return "announcement/announcement";
    }

    @Secured({"ROLE_ADMIN"})
    @GetMapping("/writeAnnounce")
    public String formWriteAnnounce() {

        return "announcement/announcementWrite";
    }

    @Secured({"ROLE_ADMIN"})
    @PostMapping("/writeAnnounce")
    public String writeInsertAnnounce(Announcement announcement) {

        announcementService.insertAnnounce(announcement);
        return "redirect:/announceList";
    }


    @GetMapping("/detailAnnounce")
    public String detailAnnounce(@RequestParam("id") Long id, Model model) {

        Announcement announcement = announcementService.detailAnnounce(id);
        model.addAttribute("announcement", announcement);
        return "announcement/announcementDetail";
    }

    @Secured({"ROLE_ADMIN"})
    @GetMapping("/editAnnounce")
    public String getEditForm(@RequestParam("id") Long id, Model model) {

        Announcement announcement = announcementService.detailAnnounce(id);
        model.addAttribute("announcement", announcement);
        return "announcement/announcementEdit";
    }

    @Secured({"ROLE_ADMIN"})
    @PostMapping("/editAnnounce")
    public String editAnnounce(EditAnnounceDto editAnnounceDto) {

        announcementService.editAnnounce(editAnnounceDto);
        return "redirect:/detailAnnounce?id=" + editAnnounceDto.getId();
    }

    @Secured({"ROLE_ADMIN"})
    @PostMapping("/deleteAnnounce")
    public String deleteAnnounce(@RequestParam("id") Long announceId) {

        announcementService.deleteAnnounce(announceId);
        return "redirect:/announceList";
    }

}