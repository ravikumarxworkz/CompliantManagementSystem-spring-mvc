package com.modal.complaintManagementSystem.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.modal.complaintManagementSystem.dto.DashboardDataDto;
import com.modal.complaintManagementSystem.dto.DepartmentDto;
import com.modal.complaintManagementSystem.dto.DepartmentLoginDto;
import com.modal.complaintManagementSystem.dto.DepartmentResponse;
import com.modal.complaintManagementSystem.exception.PasswordMismatchException;
import com.modal.complaintManagementSystem.exception.UserNotFoundException;
import com.modal.complaintManagementSystem.dto.DepartmentNames;

public interface DepartmentService {

	boolean registerDepartment(DepartmentDto departmentDto);

	boolean registerDepartmentLogin(DepartmentLoginDto departmentLoginDto);

	List<DepartmentResponse> getAllDepartments();
	
	List<DepartmentNames> getAllDepartmentNames();

	DepartmentDto getDepartmentById(int id);

	boolean updateDepartment(int id, DepartmentDto department);
	
	DepartmentLoginDto DepartmentLogin(String email, String password) throws UserNotFoundException ,PasswordMismatchException;
	
	 DashboardDataDto getDashboardDataForDepartment(int departmentId);
        
	 Page<DepartmentResponse> findDepartments(int page, int size, String search);
	 
}
