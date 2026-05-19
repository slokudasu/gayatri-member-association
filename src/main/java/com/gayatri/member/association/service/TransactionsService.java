package com.gayatri.member.association.service;

import java.util.List;
import java.util.Optional;

import com.gayatri.member.association.entity.Transactions;

public interface TransactionsService {
	public Transactions save(Transactions transactions);
	public List<Transactions> fetch();
	public String delete(Long id);
	public Optional<Transactions> edit(Long id);
	public List<Transactions> findByTransactionType(String transactionType);

	

}
