package com.dealim.repository;

import com.dealim.domain.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface MemberRepository  extends JpaRepository<Member, Long>{
<<<<<<< HEAD


    @Query ("SELECT COUNT(m) > 0 FROM Member m WHERE m.username = :username")
    boolean existsByUsername(@Param("username") String username);



=======
    Optional<Member> findByUsername(String username);
>>>>>>> 00d9431d25a797d81840357dcf209d5a35570791
}
