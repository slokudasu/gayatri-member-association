package com.gayatri.member.association.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.gayatri.member.association.entity.Transactions;

public interface TransactionsServiceDao extends JpaRepository<Transactions,Long>{
	public List<Transactions> findByTransactionType(String transactionType);

}
