package com.visittracker.controller;

import java.net.InetAddress;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.visittracker.entity.Visit;
import com.visittracker.repository.VisitRepository;

@RestController
public class VisitController {
	
	private final VisitRepository repo;

	public VisitController(VisitRepository repo) {
		this.repo = repo;
	}

	@GetMapping("/")
	public Map<String, Object> hello() throws Exception {
		String hostname = InetAddress.getLocalHost().getHostName();
		Map<String, Object> out = new LinkedHashMap<>();
		out.put("message", "Hello from Docker!");
		out.put("container_id", hostname);
		out.put("visit_count", repo.count());
		return out;
	}

	@PostMapping("/visits")
	public Visit create(@RequestParam(defaultValue = "no message") String message) {
		return repo.save(new Visit(message));
	}

	@GetMapping("/visits")
	public List<Visit> all() {
		return repo.findAll();
	}

	@GetMapping("/health")
	public Map<String, String> health() {
		return Map.of("status", "healthy");
	}
}
