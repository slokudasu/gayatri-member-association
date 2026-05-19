package com.gayatri.member.association.restaurent.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.gayatri.member.association.entity.restaurent.SubscriptionAmountConfig;

public interface SubscriptionAmountConfigRepository extends JpaRepository<SubscriptionAmountConfig, Long> {

    List<SubscriptionAmountConfig> findAllByOrderByIdAsc();

    Optional<SubscriptionAmountConfig> findBySubscriptionPlan(String subscriptionPlan);

    boolean existsBySubscriptionPlan(String subscriptionPlan);

    boolean existsBySubscriptionPlanAndIdNot(String subscriptionPlan, Long id);
}
