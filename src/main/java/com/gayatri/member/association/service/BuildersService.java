package com.gayatri.member.association.service;

import java.util.List;

import com.gayatri.member.association.entity.Builder;

public interface BuildersService {
	public Builder save(Builder member);
	List<Builder> fetch();
	public String delete(Long id);
	public List<Builder> findByStatus(String status);

}
