package com.gayatri.member.association.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.gayatri.member.association.entity.Year;

public interface YearRepo extends JpaRepository<Year,Long>{
	
}
