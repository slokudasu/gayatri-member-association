package com.gayatri.member.association.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.gayatri.member.association.entity.GayatriMaintenance;

public interface GayatriMaintenanceRepo extends JpaRepository<GayatriMaintenance,Long>{
	public List<GayatriMaintenance> findByMemberId(Long memberId);
	public List<GayatriMaintenance> findByMemberIdAndYear(Long memberId, String year);


}
