package com.gayatri.member.association.serviceImpl;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gayatri.member.association.dao.MemberServiceDao;
import com.gayatri.member.association.entity.Member;
import com.gayatri.member.association.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	MemberServiceDao dao;

	@Override
	public Member save(Member member) {
		/*
		 * if(member.isMemberShipFlag()) { member.setMemberShipAmount(3000.00); } else {
		 * member.setMemberShipAmount(0); }
		 */
		member.setCreationDateTime(Date.valueOf(LocalDate.now()));
		return dao.save(member);
		
	}

	@Override
	public List<Member> fetchMembers() {
		return dao.findAll();
	}

	@Override
	public String deleteMember(Long memberId) {
		dao.deleteById(memberId);		
		return "Member Deleted Successfully";
	}

	@Override
	public Optional<Member> edit(Long memberId) {
		return dao.findById(memberId);
	}

	@Override
	public List<Member> findByMemberShipFlag(Boolean memberShipFlag) {		
		return dao.findByMemberShipFlag(memberShipFlag);
	}

	

}
