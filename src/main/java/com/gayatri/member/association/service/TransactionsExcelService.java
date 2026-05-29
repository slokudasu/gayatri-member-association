package com.gayatri.member.association.service;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import com.gayatri.member.association.entity.Transactions;

@Service
public class TransactionsExcelService {

	private static String safeString(String value) {
		return value == null ? "" : value;
	}

	public ByteArrayInputStream export(List<Transactions> transactions) throws IOException {
		String[] columns = {"Transaction Type", "Amount", "Purpose Of Transaction", "Transaction Date"};

		try (Workbook workbook = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
			Sheet sheet = workbook.createSheet("Transactions");

			Row headerRow = sheet.createRow(0);
			for (int i = 0; i < columns.length; i++) {
				Cell cell = headerRow.createCell(i);
				cell.setCellValue(columns[i]);
			}

			int rowIdx = 1;
			for (Transactions transaction : transactions) {
				Row row = sheet.createRow(rowIdx++);
				row.createCell(0).setCellValue(safeString(transaction.getTransactionType()));
				row.createCell(1).setCellValue(transaction.getAmount());
				row.createCell(2).setCellValue(safeString(transaction.getPurposeOfTransaction()));
				row.createCell(3).setCellValue(transaction.getCreationDateTime() == null ? "" : transaction.getCreationDateTime().toString());
			}

			workbook.write(out);
			return new ByteArrayInputStream(out.toByteArray());
		}
	}
}
