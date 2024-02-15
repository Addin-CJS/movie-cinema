package com.dealim.controller;


import com.dealim.domain.Announcement;
import com.dealim.domain.Member;
import com.dealim.dto.EditAnnounceDto;
import com.dealim.security.custom.CustomUserDetails;
import com.dealim.service.AnnouncementService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
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
    public String getAnnounceList(Model model){

        List<Announcement> announceList = announcementService.getAnnounceList();


        model.addAttribute("announceList", announceList);
        return "announcement/announcement";
    }

    @GetMapping("/writeAnnounce")
    public  String goToInsertAnnounce(){

        return "announcement/announcementWrite";
    }

    @PostMapping("/writeAnnounce")
    public String insertAnnounce(Announcement announcement){

        announcementService.insertAnnounce(announcement);

        return "redirect:/announceList";
    }


    @GetMapping("/detailAnnounce")
    public String detailAnnounce(@RequestParam("id") Long id, Model model){
        Announcement announcement = announcementService.detailAnnounce(id);
        model.addAttribute("announcement", announcement);

        return "announcement/announcementDetail";
    }

    @GetMapping("/editAnnounce")
    public  String getEditForm(@RequestParam("id") Long id,Model model){
        Announcement announcement = announcementService.detailAnnounce(id);
        model.addAttribute("announcement", announcement);

        return "announcement/announcementEdit";
    }

    @PostMapping("/editAnnounce")
    public String editAnnounce(EditAnnounceDto editAnnounceDto , Authentication authentication){
        Member admin = ((CustomUserDetails) authentication.getPrincipal()).getMember();

        announcementService.editAnnounce(editAnnounceDto);

        return "redirect:/detailAnnounce?id=" + editAnnounceDto.getId();
    }

    @PostMapping("/deleteAnnounce")
    public  String deleteAnnounce(@RequestParam("id") Long announceId ){

            announcementService.deleteAnnounce(announceId);
        return "redirect:/announceList";
    }


}
