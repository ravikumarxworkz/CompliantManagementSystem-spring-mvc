package com.modal.complaintManagementSystem.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.modal.complaintManagementSystem.entity.EmailValidationEntity;

@Repository
public interface EmailIdValidationRepo extends JpaRepository<EmailValidationEntity, Integer> {

	 Optional<EmailValidationEntity> findFirstByEmailOrderByCreatedAtDesc(String email);
	    void deleteByEmail(String email);
	
}
