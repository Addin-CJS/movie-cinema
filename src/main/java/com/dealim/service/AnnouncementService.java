package com.dealim.service;


import com.dealim.domain.Announcement;
import com.dealim.dto.EditAnnounceDto;
import com.dealim.repository.AnnouncementRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
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
