package com.dealim.repository;

import com.dealim.domain.Member;
import io.micrometer.observation.ObservationFilter;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface MemberRepository  extends JpaRepository<Member, Long>{
    @Query ("SELECT COUNT(m) > 0 FROM Member m WHERE m.username = :username")
    boolean existsByUsername(@Param("username") String username);
    Optional<Member> findByUsername(String username);

    @Query("SELECT m FROM Member m WHERE m.name = :name AND m.phoneNumber = :phoneNumber")
    Member findByNameAndPhoneNumber(@Param("name") String name, @Param("phoneNumber") String phoneNumber);

    @Query("SELECT m FROM Member m WHERE m.username = :username AND m.name = :name AND m.phoneNumber = :phoneNumber")
    Member findByUserNameAndNameAndPhoneNumber(String username, String name, String phoneNumber);

    List<Member> findByMemberIdIn(List<Long> memberIdsList);

    ObservationFilter findByEmail(String email);

    @Query("SELECT m FROM Member m WHERE m.username = :username AND m.name = :name")
    Member findMember(@Param("username") String username, @Param("name") String name);

    @EntityGraph(attributePaths = {"roles"})
    Optional<Member> findWithRolesByUsername(String username);
}
