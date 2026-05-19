package com.gayatri.member.association.serviceImpl;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gayatri.member.association.dao.BuilderServiceDao;
import com.gayatri.member.association.entity.Builder;
import com.gayatri.member.association.service.BuildersService;

@Service
public class BuilderServiceImpl implements BuildersService{
	
	@Autowired
	BuilderServiceDao dao;

	@Override
	public Builder save(Builder builder) {		
		builder.setCreationDateTime(Date.valueOf(LocalDate.now()));
		return dao.save(builder);	
	}
	
	@Override
	public List<Builder> fetch() {
		return dao.findAll();
	}

	@Override
	public String delete(Long id) {
		dao.deleteById(id);		
		return "Member Deleted Successfully";
	}

	@Override
	public List<Builder> findByStatus(String status) {
		return dao.findByStatus(status);
	}

	
	
	

}
