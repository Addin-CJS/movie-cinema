package com.dealim.controller;

import com.dealim.service.OpenApiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class OpenApiController {
    @Autowired
    private OpenApiService openApiService;

    @GetMapping("/getMovies")
    public ResponseEntity<?> getMovies(){
        openApiService.insertMovies();
        return ResponseEntity.ok("200");
    }
}