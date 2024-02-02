package com.dealim.controller;


import com.dealim.repository.MovieTheaterRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Slf4j
public class HomeController {
    @Autowired
    private MovieTheaterRepository movieTheaterRepository;


    @RequestMapping("/")
    public String home() {
        return "index";
    }
}