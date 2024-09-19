package com.modal.complaintManagementSystem.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.modal.complaintManagementSystem.entity.DepartmentLogin;


@Repository
public interface DepartmentLoginRepository extends JpaRepository<DepartmentLogin, Integer> {

	boolean existsByDepartmentLoginEmail(String departmentLoginEmail);
	
	
	DepartmentLogin findByDepartmentLoginEmail(String departmentLoginEmail);
}
