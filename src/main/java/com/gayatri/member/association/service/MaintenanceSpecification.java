package com.gayatri.member.association.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.jpa.domain.Specification;

import com.gayatri.member.association.dto.MaintenanceSearchRequest;
import com.gayatri.member.association.entity.Maintenance;

import jakarta.persistence.criteria.Predicate;

public class MaintenanceSpecification {

    public static Specification<Maintenance> filter(MaintenanceSearchRequest req) {
        return (root, query, cb) -> {

            List<Predicate> list = new ArrayList<>();

            if (req.getMemberId() != null) {
                list.add(cb.equal(root.get("memberId"), req.getMemberId()));
            }
            

            if (req.getYear() != null && !req.getYear().isBlank()) {
                list.add(cb.equal(root.get("year"), req.getYear()));
            }

            if (req.getMonth() != null && !req.getMonth().isBlank()) {
                list.add(cb.equal(root.get("month"), req.getMonth()));
            }

            if (req.getStatus() != null && !req.getStatus().isBlank()) {
                list.add(cb.equal(root.get("status"), req.getStatus()));
            }

           
            return cb.and(list.toArray(new Predicate[0]));
        };
    }
}