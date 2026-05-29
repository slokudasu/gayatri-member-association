package com.gayatri.member.association.controller;

import java.io.ByteArrayInputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.data.jpa.domain.Specification;
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

import com.gayatri.member.association.dao.GayatriMaintenanceRepo;
import com.gayatri.member.association.dao.MaintenanceExcelServiceDao;
import com.gayatri.member.association.dto.MaintenanceSearchRequest;
import com.gayatri.member.association.entity.GayatriMaintenance;
import com.gayatri.member.association.entity.Maintenance;
import com.gayatri.member.association.entity.Member;
import com.gayatri.member.association.service.MaintenanceExcelService;
import com.gayatri.member.association.service.MaintenanceService;
import com.gayatri.member.association.service.MaintenanceSpecification;
import com.gayatri.member.association.service.MemberService;

@RestController
@RequestMapping("/maintenance")
@CrossOrigin

public class MaintenanceRestController {
	
	@Autowired
	MaintenanceService maintenanceService;
	
	@Autowired
	GayatriMaintenanceRepo gayatriMaintenanceRepo;
	
	@Autowired
	MaintenanceExcelService maintenanceExcelService;
	
	@Autowired
	MaintenanceExcelServiceDao maintenanceExcelServiceDao;
	
	@Autowired
	MemberService memberService;
	

	@PostMapping("/save")
	public Maintenance save(@RequestBody Maintenance maintenance) {
		return maintenanceService.save(maintenance);		
	}
	
	@GetMapping("/fetch")
	public List<Maintenance> fetch() {
		return maintenanceService.fetch();
		
	}
	
	@GetMapping("/fetchMaintenance")
	public List<GayatriMaintenance> fetchMaintenance() {
		return gayatriMaintenanceRepo.findAll();
		
	}
	
	@GetMapping("/delete/{id}")
	public String delete(@PathVariable Long id) {
		return maintenanceService.delete(id);
		
	}
	@GetMapping("/edit/{id}")
	public Optional<Maintenance> edit(@PathVariable Long id) {
		return maintenanceService.edit(id);
		
	}
	
	@GetMapping("/fetch/{memberId}")
	public List<Maintenance> findByMemberId(@PathVariable Long memberId) {
		return maintenanceService.findByMemberId(memberId);
		
	}
	
	@GetMapping("/fetch/{memberId}/{year}")
	public List<Maintenance> findByMemberIdAndYear(@PathVariable Long memberId,@PathVariable String year) {		
        return  maintenanceService.findByMemberIdAndYear(memberId , year);
		
	}

	@GetMapping("/search")
	public List<Maintenance> search(
			@RequestParam(required = false) Long memberId,
			@RequestParam(required = false) String year,
			@RequestParam(required = false) String month,
			@RequestParam(required = false) String status) {
		return resolveMaintenanceSearchData(memberId, year, month, status);
	}
	
	@GetMapping("/downloadExcel")
    public ResponseEntity<InputStreamResource> downloadExcel(@RequestParam(required = false) Long memberId,@RequestParam(required = false) String year,
     		@RequestParam(required = false) String month,
     		@RequestParam(required = false) String status) throws Exception {
        List<Maintenance> finalList = resolveMaintenanceSearchData(memberId, year, month, status);
		
		
		
		
		
		ByteArrayInputStream in = maintenanceExcelService.export(finalList);

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=maintenance.xlsx");
        return ResponseEntity.ok()
                .headers(headers)	
                .contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                 .body(new InputStreamResource(in));
         
         
         
    }

	private List<Maintenance> resolveMaintenanceSearchData(Long memberId, String year, String month, String status) {
		boolean hasYear = hasText(year);
		boolean hasMonth = hasText(month);
		boolean allMembersYearMonthView = hasYear && hasMonth;
		boolean allMembersYearView = hasYear && !hasMonth;
		if (allMembersYearMonthView) {
			return buildAllMembersMonthStatus(year, month, status);
		}
		if (allMembersYearView) {
			return buildAllMembersYearStatus(year, status);
		}
		if (memberId != null) {
			return fetchMaintenanceByFilters(memberId, year, month, status);
		}
		return fetchMaintenanceByFilters(null, year, month, status);
	}

	private List<Maintenance> buildAllMembersMonthStatus(String year, String month, String status) {
		List<Maintenance> monthRecords = fetchMaintenanceByFilters(null, year, month, null);
		Map<Long, Maintenance> monthMap = monthRecords.stream()
				.collect(Collectors.toMap(Maintenance::getMemberId, m -> m, this::pickPreferredMaintenance));

		List<Maintenance> allMemberStatus = new ArrayList<>();
		for (Member member : memberService.fetchMembers()) {
			Maintenance dto = new Maintenance();
			dto.setMemberId(member.getMemberId());
			String firstName = member.getFirstName() == null ? "" : member.getFirstName();
			String lastName = member.getLastName() == null ? "" : member.getLastName();
			dto.setMemberName((firstName + " " + lastName).trim());
			dto.setYear(year);
			dto.setMonth(month);

			Maintenance record = monthMap.get(member.getMemberId());
			if (record != null) {
				dto.setId(record.getId());
				dto.setCreationDateTime(record.getCreationDateTime());
				dto.setAmount(record.getAmount());
				dto.setStatus(hasText(record.getStatus()) ? record.getStatus() : "Unpaid");
			} else {
				dto.setAmount(0.0);
				dto.setStatus("Unpaid");
			}
			allMemberStatus.add(dto);
		}
		return applyStatusFilter(allMemberStatus, status);
	}

	private List<Maintenance> buildAllMembersYearStatus(String year, String status) {
		List<Maintenance> yearRecords = fetchMaintenanceByFilters(null, year, null, null);
		Map<Long, List<Maintenance>> recordsByMember = yearRecords.stream()
				.collect(Collectors.groupingBy(Maintenance::getMemberId));

		List<Maintenance> allMemberStatus = new ArrayList<>();
		for (Member member : memberService.fetchMembers()) {
			Maintenance dto = new Maintenance();
			dto.setMemberId(member.getMemberId());
			String firstName = member.getFirstName() == null ? "" : member.getFirstName();
			String lastName = member.getLastName() == null ? "" : member.getLastName();
			dto.setMemberName((firstName + " " + lastName).trim());
			dto.setYear(year);
			dto.setMonth("Year Summary");

			List<Maintenance> memberYearRecords = recordsByMember.get(member.getMemberId());
			if (memberYearRecords == null || memberYearRecords.isEmpty()) {
				dto.setAmount(0.0);
				dto.setStatus("Unpaid");
			} else {
				double paidAmount = memberYearRecords.stream()
						.filter(r -> "Paid".equalsIgnoreCase(r.getStatus()))
						.mapToDouble(Maintenance::getAmount)
						.sum();
				boolean isPaid = memberYearRecords.stream()
						.anyMatch(r -> "Paid".equalsIgnoreCase(r.getStatus()));
				dto.setAmount(paidAmount);
				dto.setStatus(isPaid ? "Paid" : "Unpaid");
			}
			allMemberStatus.add(dto);
		}
		return applyStatusFilter(allMemberStatus, status);
	}

	private List<Maintenance> applyStatusFilter(List<Maintenance> data, String status) {
		if (!hasText(status)) {
			return data;
		}
		return data.stream()
				.filter(m -> status.equalsIgnoreCase(m.getStatus()))
				.collect(Collectors.toList());
	}

	private List<Maintenance> fetchMaintenanceByFilters(Long memberId, String year, String month, String status) {
		MaintenanceSearchRequest maintenanceSearchRequest = new MaintenanceSearchRequest();
		maintenanceSearchRequest.setMemberId(memberId);
		maintenanceSearchRequest.setYear(year);
		maintenanceSearchRequest.setMonth(month);
		maintenanceSearchRequest.setStatus(status);
		Specification<Maintenance> spec = MaintenanceSpecification.filter(maintenanceSearchRequest);
		return maintenanceExcelServiceDao.findAll(spec);
	}

	private Maintenance pickPreferredMaintenance(Maintenance existing, Maintenance replacement) {
		if (replacement == null) {
			return existing;
		}
		if (existing == null) {
			return replacement;
		}
		if (replacement.getCreationDateTime() == null) {
			return existing;
		}
		if (existing.getCreationDateTime() == null || replacement.getCreationDateTime().after(existing.getCreationDateTime())) {
			return replacement;
		}
		return existing;
	}

	private boolean hasText(String value) {
		return value != null && !value.isBlank();
	}
	
}
