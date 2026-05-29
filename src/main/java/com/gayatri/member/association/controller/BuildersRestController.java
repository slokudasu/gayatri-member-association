package com.gayatri.member.association.controller;

import java.io.ByteArrayInputStream;
import java.util.List;

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

import com.gayatri.member.association.entity.Builder;
import com.gayatri.member.association.service.BuilderExcel;
import com.gayatri.member.association.service.BuildersService;

@RestController
@RequestMapping("/builder")
@CrossOrigin

public class BuildersRestController {
	
	@Autowired
	BuildersService buildersService;
	
	@Autowired
	BuilderExcel builderExcel;
	
	

	@PostMapping("/save")
	public Builder save(@RequestBody Builder maintenance) {
		return buildersService.save(maintenance);		
	}
	
	@GetMapping("/fetch")
	public List<Builder> fetch() {
		return buildersService.fetch();
		
	}
	
	@GetMapping("/delete/{id}")
	public String delete(@PathVariable Long id) {
		return buildersService.delete(id);
		
	}
	
	@GetMapping("/downloadExcel")
    public ResponseEntity<InputStreamResource> downloadExcel(@RequestParam(required = false) String status) throws Exception {
        List<Builder> buildetsData;
        if (status != null && !status.isBlank()) {
        	buildetsData = buildersService.findByStatus(status);
        } else {
        	buildetsData = buildersService.fetch();
        }

        ByteArrayInputStream in = builderExcel.export(buildetsData);

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=Builders.xlsx");
        return ResponseEntity.ok()
                .headers(headers)
                .contentType(MediaType.parseMediaType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"))
                .body(new InputStreamResource(in));
    }
	
	
}
