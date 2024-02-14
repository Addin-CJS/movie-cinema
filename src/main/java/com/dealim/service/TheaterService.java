package com.dealim.service;

import com.dealim.domain.Theater;
import com.dealim.repository.TheaterRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TheaterService {
    @Autowired
    TheaterRepository theaterRepository;

    public List<Theater> getTheaterByRegionId(Long regionId) {
        return theaterRepository.findByRegionId(regionId);
    }
}
