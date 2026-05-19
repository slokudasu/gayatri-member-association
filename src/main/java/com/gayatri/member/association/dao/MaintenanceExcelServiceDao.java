package com.gayatri.member.association.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

import com.gayatri.member.association.entity.Maintenance;

public interface MaintenanceExcelServiceDao 
extends JpaRepository<Maintenance, Long>, JpaSpecificationExecutor<Maintenance> {
}
