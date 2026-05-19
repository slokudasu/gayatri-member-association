package com.gayatri.member.association.restaurent.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.gayatri.member.association.entity.restaurent.SubscriptionDetail;

public interface SubscriptionDetailRepository extends JpaRepository<SubscriptionDetail, Long> {

    List<SubscriptionDetail> findAllByOrderByPaymentDateDesc();
}
