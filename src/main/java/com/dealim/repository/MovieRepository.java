package com.dealim.repository;

import com.dealim.domain.Movie;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface MovieRepository extends JpaRepository<Movie, Long> {

    @Query("SELECT m FROM Movie m WHERE m.mvTitle LIKE %:searchKeyword%")
    Page<Movie> findByMvTitleContaining(String searchKeyword, Pageable pageable);
}
