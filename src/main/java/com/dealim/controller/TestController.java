package com.dealim.controller;

import com.dealim.domain.repository.MovieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestController {
    @Autowired
    private MovieRepository movieRepository;
    @GetMapping("/test")
    public String test(Model model){
        model.addAttribute("movies",movieRepository.findAll());
        return "test";
    }
    @RequestMapping("/")
    public String index() {
        return "index";
    }
    @RequestMapping("/logout")
    public String logout() {
        return "index";
    }
}
