package com.gayatri.member.association.controller;

import java.io.ByteArrayInputStream;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.gayatri.member.association.entity.Transactions;
import com.gayatri.member.association.service.TransactionsExcelService;
import com.gayatri.member.association.service.TransactionsService;

@RestController
@RequestMapping("/transactions")
@CrossOrigin

public class TransactionsRestController {
	
	@Autowired
	TransactionsService transactionsService;

	@Autowired
	TransactionsExcelService transactionsExcelService;
	

	@PostMapping("/save")
	public Transactions save(@RequestBody Transactions transactions) {
		return transactionsService.save(transactions);		
	}
	
	@GetMapping("/fetch")
	public List<Transactions> fetch() {
		return transactionsService.fetch();
		
	}
	@GetMapping("/fetch/{transactionType}")
	public List<Transactions> fetch(@PathVariable String transactionType) {
		return transactionsService.findByTransactionType(transactionType);
		
	}
	
	@GetMapping("/delete/{id}")
	public String delete(@PathVariable Long id) {
		return transactionsService.delete(id);
		
	}
	@GetMapping("/edit/{id}")
	public Optional<Transactions> edit(@PathVariable Long id) {
		return transactionsService.edit(id);
		
	}

	@GetMapping("/downloadExcel")
	public ResponseEntity<InputStreamResource> downloadExcel(@RequestParam(required = false) String transactionType) throws Exception {
		List<Transactions> transactionsList;
		if (transactionType != null && !transactionType.isBlank()) {
			transactionsList = transactionsService.findByTransactionType(transactionType);
		} else {
			transactionsList = transactionsService.fetch();
		}

		ByteArrayInputStream in = transactionsExcelService.export(transactionsList);

		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Disposition", "attachment; filename=transactions.xlsx");
		return ResponseEntity.ok()
				.headers(headers)
				.contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
				.body(new InputStreamResource(in));
	}
	
	
	
	
}
