package com.modal.complaintManagementSystem.service;

import java.io.IOException;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.web.multipart.MultipartFile;

import com.modal.complaintManagementSystem.dto.ChangePasswordDto;
import com.modal.complaintManagementSystem.dto.DashboardDataDto;
import com.modal.complaintManagementSystem.dto.EmployeeDto;
import com.modal.complaintManagementSystem.dto.EmployeeNames;
import com.modal.complaintManagementSystem.exception.InvalidPasswordException;
import com.modal.complaintManagementSystem.exception.InvalideEmailException;
import com.modal.complaintManagementSystem.exception.PasswordMismatchException;
import com.modal.complaintManagementSystem.exception.UserNotFoundException;
import com.modal.complaintManagementSystem.response.EmployeeResponse;

public interface EmployeeService {

	List<EmployeeDto> getEmployeesByDepartmentId(int id);

	boolean createEmployee(EmployeeDto employeeDto);

	Page<EmployeeDto> getSortedEmployeesByDepartmentId(int departmentId, String query, int page, int size);

	Page<EmployeeDto> searchEmployeesByEmail(int departmentId, String email, int page, int size);

	EmployeeDto getEmployeeById(int employeeId);

	EmployeeDto loginEmployee(String email, String password) throws InvalideEmailException, InvalidPasswordException;

	boolean deleteEmployee(int employeeId);

	boolean updateEmployeeStatus(int employeeId, String employeeStatus);

	List<EmployeeNames> getEmployeeNamesByDepartmentId(int departmentId);

	EmployeeResponse getAllEmployees(int page, int size, String query);

	DashboardDataDto dashboardDataOfEmployee(int employeeId);
	
	boolean checkEmployeeByDepartmentId(int complaintId, int departmentId);

	EmployeeDto changeEmployeePassword(ChangePasswordDto changePasswordDto)
			throws PasswordMismatchException, InvalidPasswordException, UserNotFoundException;

	 String updateEmployeeImage(MultipartFile imageFile, int employeeId) throws IOException ;

}
