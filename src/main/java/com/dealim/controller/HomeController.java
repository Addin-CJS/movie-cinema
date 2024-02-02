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
//        Random random = new Random();
//        Set<String> existingCombinations = new HashSet<>(); // 중복 체크를 위한 셋
//
//        for (long movieId = 362; movieId <= 456; movieId++) {
//            int numberOfTheaters = random.nextInt(5) + 1; // 한 영화당 1 ~ 5개의 영화관
//            for (int i = 0; i < numberOfTheaters; i++) {
//                long theaterId;
//                String combination;
//                do {
//                    theaterId = random.nextInt(13) + 1; // 1부터 13 사이의 랜덤한 영화관 ID
//                    combination = movieId + "-" + theaterId; // 조합을 문자열로 변환
//                } while (!existingCombinations.add(combination)); // 중복 체크
//
//                MovieTheater movieTheater = new MovieTheater(movieId, theaterId);
//                movieTheaterRepository.save(movieTheater);
//            }
//        }
        return "index";
    }
}