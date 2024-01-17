package com.dealim.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test")
public class TestController {
    @RequestMapping("/")
    public String index() {
        return "index";
    }
    @RequestMapping("/logout")
    public String logout() {
        return "index";
    }
}
