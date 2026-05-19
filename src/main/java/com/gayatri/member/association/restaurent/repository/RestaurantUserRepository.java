package com.gayatri.member.association.restaurent.repository;

import java.util.Optional;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.gayatri.member.association.entity.restaurent.RestaurantUser;

public interface RestaurantUserRepository extends JpaRepository<RestaurantUser, Long> {

    Optional<RestaurantUser> findByMobileNo(String mobileNo);

    boolean existsByMobileNo(String mobileNo);

    boolean existsByEmailIgnoreCase(String email);

    List<RestaurantUser> findAllByOrderByCreatedAtDesc();

    boolean existsByAdminUserTrue();

    Optional<RestaurantUser> findFirstByOrderByIdAsc();
}
