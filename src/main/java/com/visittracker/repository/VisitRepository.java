package com.visittracker.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.visittracker.entity.Visit;

public interface VisitRepository extends JpaRepository<Visit, Long> {
}