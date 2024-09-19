package com.modal.complaintManagementSystem.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.modal.complaintManagementSystem.entity.AdminEntity;

@Repository
public interface AdminRepository  extends JpaRepository<AdminEntity, Integer>{
      
	
	AdminEntity findByEmail(String email);
}
