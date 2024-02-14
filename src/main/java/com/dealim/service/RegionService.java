package com.dealim.service;

import com.dealim.domain.Region;
import com.dealim.repository.RegionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RegionService {
    @Autowired
    RegionRepository regionRepository;

    public List<Region> getAllRegions() {
        Sort sort = Sort.by(Sort.Direction.ASC, "RegionId");
        return regionRepository.findAll(sort);
    }
}
