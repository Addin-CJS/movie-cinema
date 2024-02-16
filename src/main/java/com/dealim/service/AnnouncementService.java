package com.dealim.service;


import com.dealim.domain.Announcement;
import com.dealim.dto.AnnouncementPageDTO;
import com.dealim.dto.EditAnnounceDto;
import com.dealim.repository.AnnouncementRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@Slf4j
public class AnnouncementService {
    @Autowired
    AnnouncementRepository announcementRepository;

    public Announcement insertAnnounce(Announcement announcement) {

        return announcementRepository.save(announcement);

    }
    public List<Announcement> getAnnounceList() {
        return announcementRepository.findAllByOrderByIdDesc();

    }


    public AnnouncementPageDTO getAnnouncePagedList(Pageable pageable) {
        Page<Announcement> announcementsPagedList = announcementRepository.findAllByOrderByIdDesc(pageable);

        int nowPage = announcementsPagedList.getNumber();
        int totalPages = announcementsPagedList.getTotalPages();
        int pageGroupSize = 5;
        int startPage = (nowPage / pageGroupSize) * pageGroupSize +1 ;
        int endPage =  Math.min(startPage + pageGroupSize - 1, totalPages);

        AnnouncementPageDTO dto = new AnnouncementPageDTO();
        dto.setAnnouncements(announcementsPagedList.getContent());
        dto.setNowPage(nowPage +1);
        dto.setStartPage(startPage);
        dto.setEndPage(endPage);
        dto.setTotalPage(totalPages);
        return dto;
    }

    public Announcement editAnnounce(EditAnnounceDto editAnnounceDto) {
        try {

            Optional<Announcement> optionalAnnouncement = announcementRepository.findById(editAnnounceDto.getId());

            if (optionalAnnouncement.isPresent()) {

                Announcement announcement = optionalAnnouncement.get();

                announcement.setTitle(editAnnounceDto.getTitle());
                announcement.setContent(editAnnounceDto.getContent());

                return announcementRepository.save(announcement);
            } else {

                throw new NotFoundException("공지사항 아디 없음 : " + editAnnounceDto.getId());
            }
        } catch (NotFoundException ex) {

            throw ex;
        } catch (Exception ex) {

            log.error("공지사항 아이디없음", ex);
            return null;
        }


    }

    public void deleteAnnounce(Long announceId) {
        try {
            Optional<Announcement> optionalAnnouncement = announcementRepository.findById(announceId);

            if (optionalAnnouncement.isPresent()) {

                Announcement announcement = optionalAnnouncement.get();
                announcementRepository.delete(announcement);
            } else {

                throw new NotFoundException("해당 ID의 공지사항 삭제를 실패했습니다: " + announceId);
            }
        } catch (Exception ex) {

            log.error("해당 ID의 공지사항 삭제를 실패했습니다: " + announceId, ex);
            throw ex;
        }
    }


    public Announcement detailAnnounce(Long id) {
        return announcementRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("해당글을 찾을수없습니다: " + id));
    }



}
