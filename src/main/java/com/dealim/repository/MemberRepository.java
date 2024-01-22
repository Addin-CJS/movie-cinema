package com.dealim.repository;

import com.dealim.domain.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface MemberRepository  extends JpaRepository<Member, Long>{
    Optional<Member> findByUsername(String username);
}
