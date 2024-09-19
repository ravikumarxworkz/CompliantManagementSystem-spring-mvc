package com.modal.complaintManagementSystem.service.impl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.modal.complaintManagementSystem.dto.ChangePasswordDto;
import com.modal.complaintManagementSystem.dto.DashboardDataDto;
import com.modal.complaintManagementSystem.dto.EmployeeDto;
import com.modal.complaintManagementSystem.dto.EmployeeNames;
import com.modal.complaintManagementSystem.entity.Complaint;
import com.modal.complaintManagementSystem.entity.Department;
import com.modal.complaintManagementSystem.entity.Employee;
import com.modal.complaintManagementSystem.exception.EmployeeAlreadyExistsException;
import com.modal.complaintManagementSystem.exception.InvalidPasswordException;
import com.modal.complaintManagementSystem.exception.InvalideEmailException;
import com.modal.complaintManagementSystem.exception.PasswordMismatchException;
import com.modal.complaintManagementSystem.exception.ResourceNotFoundException;
import com.modal.complaintManagementSystem.exception.UserNotFoundException;
import com.modal.complaintManagementSystem.repository.ComplaintRepository;
import com.modal.complaintManagementSystem.repository.DepartmentRepository;
import com.modal.complaintManagementSystem.repository.EmployeeRepository;
import com.modal.complaintManagementSystem.response.EmployeeResponse;
import com.modal.complaintManagementSystem.service.EmployeeService;

@Service
@Transactional
public class EmployeeServiceImpl implements EmployeeService {

	@Autowired
	private EmployeeRepository employeeRepository;

	@Autowired
	private DepartmentRepository departmentRepository;

	@Autowired
	private ComplaintRepository complaintRepository;

	@Override
	public EmployeeDto getEmployeeById(int employeeId) {
		// Fetch the employee by ID
		Employee employee = this.employeeRepository.findById(employeeId)
				.orElseThrow(() -> new ResourceNotFoundException("Employee not found with ID: " + employeeId));

		// Map the employee to EmployeeDto
		EmployeeDto employeeDto = new EmployeeDto();
		BeanUtils.copyProperties(employee, employeeDto);
		employeeDto.setEmployeePassword(null); // Hide the password
		employeeDto.setDepartmentId(employee.getDepartment().getDepartmentId());
		employeeDto.setDepartmentName(employee.getDepartment().getDepartmentName());
		return employeeDto;
	}

	@Override
	public EmployeeDto loginEmployee(String email, String password)
			throws InvalideEmailException, InvalidPasswordException {
		if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
			throw new InvalideEmailException("Email Id and Password must not be empty");
		}

		Employee employee = this.employeeRepository.findByEmployeeEmail(email);
		if (employee == null) {
			throw new InvalideEmailException("Email Id does not exist");
		}

		if (!employee.getEmployeePassword().equals(password)) {
			throw new InvalidPasswordException("Password is incorrect");
		}

		EmployeeDto employeeDto = new EmployeeDto();
		BeanUtils.copyProperties(employee, employeeDto);
		employeeDto.setEmployeePassword(null);
		employeeDto.setDepartmentId(employee.getDepartment().getDepartmentId());
		employeeDto.setDepartmentName(employee.getDepartment().getDepartmentName());
		// employee.setEmployeePassword(null);
		return employeeDto;
	}

	@Override
	public DashboardDataDto dashboardDataOfEmployee(int employeeId) {
		Employee employee = this.employeeRepository.getById(employeeId);
		List<Complaint> complaints = this.complaintRepository.findByEmployee(employee);
		int totalComplaints = complaints.size();
		int newComplaints = (int) complaints.stream().filter(c -> c.getStatus().equalsIgnoreCase("In Progress"))
				.count();
		int closedComplaints = (int) complaints.stream().filter(c -> c.getStatus().equalsIgnoreCase("Closed")).count();

		// Create a DTO to hold the dashboard data
		DashboardDataDto dashboardDataDto = new DashboardDataDto();
		dashboardDataDto.setTotalComplaints(totalComplaints);
		dashboardDataDto.setNewComplaints(newComplaints);
		dashboardDataDto.setClosedComplaints(closedComplaints);

		return dashboardDataDto;
	}

	@Override
	public boolean deleteEmployee(int employeeId) {
		if (employeeId > 0) {
			this.employeeRepository.deleteById(employeeId);
			return true;
		}
		return false;
	}

	@Override
	public boolean updateEmployeeStatus(int employeeId, String employeeStatus) {
		if (employeeId > 0) {
			if (employeeStatus != null) {
				Employee employee = this.employeeRepository.getById(employeeId);
				if (employee != null) {
					employee.setEmployeeStatus(employeeStatus);
					Employee save = this.employeeRepository.save(employee);
					if (save != null) {
						return true;
					}
				}

			}
		}
		return false;
	}

	@Override
	public List<EmployeeDto> getEmployeesByDepartmentId(int id) {

		Department department = this.departmentRepository.findByDepartmentId(id);
		return employeeRepository.findByDepartment(department).stream().map(this::mapToEmployeeDto)
				.collect(Collectors.toList());
	}

	private EmployeeDto mapToEmployeeDto(Employee employee) {
		EmployeeDto dto = new EmployeeDto();
		BeanUtils.copyProperties(employee, dto);
		dto.setEmployeePassword(null);
		return dto;
	}

	@Override
	public boolean createEmployee(EmployeeDto employeeDto) {

		if (employeeDto != null) {
			if (this.employeeRepository.existsByEmployeeEmail(employeeDto.getEmployeeEmail())) {
				throw new EmployeeAlreadyExistsException("Employee with this email already exists.");
			}
			if (employeeRepository.existsByEmployeeContactNumber(employeeDto.getEmployeeContactNumber())) {
				throw new EmployeeAlreadyExistsException("Employee with this contact number already exists.");
			}
			Department department = this.departmentRepository.findByDepartmentId(employeeDto.getDepartmentId());
			Employee employee = new Employee();
			BeanUtils.copyProperties(employeeDto, employee);
			employee.setEmployeeImagePath("employeedefaultImage.png");
			employee.setDepartment(department);
			employee.setEmployeeStatus("Active");

			if (employeeRepository.save(employee) != null) {
				return true;
			} else {
				return false;
			}

		}
		return false;
	}

	@Override
	public Page<EmployeeDto> getSortedEmployeesByDepartmentId(int departmentId, String query, int page, int size) {
		Department department = departmentRepository.findByDepartmentId(departmentId);
		Pageable pageable = PageRequest.of(page - 1, size);
		Page<Employee> employeePages = null;
		if ("all".equalsIgnoreCase(query)) {
			employeePages = employeeRepository.findByDepartment(department, pageable);
		} else {

		}
		return employeePages.map(employee -> {
			EmployeeDto employeeDto = new EmployeeDto();
			BeanUtils.copyProperties(employee, employeeDto);
			return employeeDto;
		});
	}

	@Override
	public Page<EmployeeDto> searchEmployeesByEmail(int departmentId, String email, int page, int size) {
		Department department = departmentRepository.findByDepartmentId(departmentId);
		Pageable pageable = PageRequest.of(page - 1, size);

		Page<Employee> employeePages = employeeRepository.findByDepartmentAndEmployeeEmailContaining(department, email,
				pageable);

		return employeePages.map(employee -> {
			EmployeeDto employeeDto = new EmployeeDto();
			BeanUtils.copyProperties(employee, employeeDto);
			return employeeDto;
		});
	}

	@Override
	public List<EmployeeNames> getEmployeeNamesByDepartmentId(int departmentId) {
	    // Fetch the department by ID
	    Department department = this.departmentRepository.findByDepartmentId(departmentId);
	    if (department == null) {
	        throw new ResourceNotFoundException("Department not found with ID: " + departmentId);
	    }

	    // Fetch the employees by department
	    List<Employee> employees = this.employeeRepository.findByDepartment(department);
	    return employees.stream().map(employee -> {
	        EmployeeNames employeeNames = new EmployeeNames();
	        employeeNames.setEmployeeId(employee.getEmployeeId());
	        employeeNames.setEmployeeName(employee.getEmployeeName());
	        return employeeNames;
	    }).collect(Collectors.toList());
	}


	public EmployeeResponse getAllEmployees(int page, int size, String query) {
		Pageable pageable = PageRequest.of(page - 1, size);
		Page<Employee> employeePage;

		if (query != null && !query.isEmpty()) {
			employeePage = employeeRepository.findByEmployeeNameContainingIgnoreCase(query, pageable);
		} else {
			employeePage = employeeRepository.findAll(pageable);
		}

		EmployeeResponse response = new EmployeeResponse();
		response.setEmployees(
				employeePage.getContent().stream().map(this::mapToEmployeeDto).collect(Collectors.toList()));
		response.setTotalPages(employeePage.getTotalPages());

		return response;
	}

	@Override
	public boolean checkEmployeeByDepartmentId(int employeeId, int departmentId) {
		Department department = departmentRepository.findByDepartmentId(departmentId);
		return employeeRepository.existsByemployeeIdAndDepartment(employeeId, department);
	}

	@Override
	public EmployeeDto changeEmployeePassword(ChangePasswordDto changePasswordDto)
			throws PasswordMismatchException, InvalidPasswordException, UserNotFoundException {

		Optional<Employee> optionalEmployee = employeeRepository.findById(changePasswordDto.getUserId());
		if (!optionalEmployee.isPresent()) {
			// Handle case where user is not found
			throw new UserNotFoundException("Employee not found with ID: " + changePasswordDto.getUserId());
		}

		Employee existingEmployee = optionalEmployee.get();

		// Validate old password
		if (!existingEmployee.getEmployeePassword().equals(changePasswordDto.getOldPassword())) {
			// Handle incorrect old password
			throw new InvalidPasswordException("The old password is incorrect.");
		}

		// Validate new password and confirm password
		if (!changePasswordDto.getNewPassword().equals(changePasswordDto.getConfirmPassword())) {
			// Handle new password and confirm password mismatch
			throw new PasswordMismatchException("New password and confirm password do not match.");
		}

		// Update user password
		existingEmployee.setEmployeePassword(changePasswordDto.getNewPassword());
		employeeRepository.save(existingEmployee);
		EmployeeDto employeeDto = new EmployeeDto();
		BeanUtils.copyProperties(existingEmployee, employeeDto);

		return employeeDto; // Assuming a method to convert UserEntity to ProfileDto
	}

	@Override
	public String updateEmployeeImage(MultipartFile imageFile, int employeeId) throws IOException {
		// Save the image to a specific path
		String imagePath = saveImage(imageFile, employeeId);

		// Update the employee's profile with the new image path
		Employee employee = employeeRepository.findById(employeeId)
				.orElseThrow(() -> new IllegalArgumentException("Invalid employee ID"));
		employee.setEmployeeImagePath(imagePath);
		employeeRepository.save(employee);

		return imagePath;
	}

	private String saveImage(MultipartFile imageFile, int employeeId) throws IOException {
		if (imageFile != null && !imageFile.isEmpty()) {
			// Define the directory where images will be saved
			String directoryPath = "D:\\complaintSystemMangement\\";
			// Use employeeId to create a unique file name
			String fileName = "employee_" + employeeId + "_" + imageFile.getOriginalFilename();
			String filePath = directoryPath + fileName;

			// Create the file path
			File newFile = new File(filePath);
			Path path = Paths.get(newFile.getAbsolutePath());

			// Write the image file to the directory
			byte[] fileBytes = imageFile.getBytes();
			Files.write(path, fileBytes);

			// Return the relative path to store in the database
			return fileName;
		}
		return null; // Return null or a default path if no image is provided
	}

}
