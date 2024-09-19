package com.modal.complaintManagementSystem.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.modal.complaintManagementSystem.dto.DashboardDataDto;
import com.modal.complaintManagementSystem.dto.DepartmentDto;
import com.modal.complaintManagementSystem.dto.DepartmentLoginDto;
import com.modal.complaintManagementSystem.dto.DepartmentNames;
import com.modal.complaintManagementSystem.dto.DepartmentResponse;
import com.modal.complaintManagementSystem.exception.DepartmentRegistrationException;
import com.modal.complaintManagementSystem.exception.ResourceNotFoundException;
import com.modal.complaintManagementSystem.service.DepartmentService;

import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/department")
@Slf4j
public class DepartmentController {

	@Autowired
	private DepartmentService departmentService;

	@PostMapping("/registerDepartment")
	public ResponseEntity<String> registerDepartment(@RequestBody DepartmentDto departmentDTO) {
		try {
			log.info("Received DepartmentDto: {}", departmentDTO);

			boolean saveDepartment = departmentService.registerDepartment(departmentDTO);
			if (saveDepartment) {
				return ResponseEntity.ok("Department registered successfully!");
			} else {
				return ResponseEntity.status(HttpStatus.BAD_REQUEST)
						.body("Department registration failed. Please try again.");
			}
		} catch (DepartmentRegistrationException e) {
			log.error("Registration failed: {}", e.getMessage());
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
		} catch (Exception e) {
			log.error("An error occurred while registering the department", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("An error occurred while registering the department: " + e.getMessage());
		}
	}

	@PostMapping("/registerDepartmentLogin")
	public ResponseEntity<String> registerDepartmentLogin(@RequestBody DepartmentLoginDto departmentLoginDto) {
		try {
			log.info("departmentLoginDto");
			boolean registered = departmentService.registerDepartmentLogin(departmentLoginDto);
			System.out.println("registered=" + registered);
			if (registered) {
				return ResponseEntity.ok("Department login registered successfully.");
			} else {
				return ResponseEntity.status(HttpStatus.BAD_REQUEST)
						.body("Email already exists or department does not exist.");
			}
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred: " + e.getMessage());
		}
	}

	@GetMapping("/getAllDepartmentDetails")
	public ResponseEntity<Page<DepartmentResponse>> getAllDepartments(
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "size", defaultValue = "10") int size,
			@RequestParam(value = "query", defaultValue = "") String query) {
		try {
			// Fetch the paginated list of DepartmentResponse
			Page<DepartmentResponse> response = departmentService.findDepartments(page, size, query);
			System.out.println(response);
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			// Log error details
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}
	}

	@GetMapping("/getDepartmentDetailsById/{departmentId}")
	public ResponseEntity<?> getDepartmentById(@PathVariable("departmentId") int departmentId) {
		try {
			DepartmentDto data = this.departmentService.getDepartmentById(departmentId);
			return ResponseEntity.ok(data); // Return the data if found
		} catch (ResourceNotFoundException e) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(e.getMessage()); // Return error message if not
																						// found
		}
	}

	@PostMapping("/update/{id}")
	public ResponseEntity<String> updateDepartment(@PathVariable int id, @RequestBody DepartmentDto department) {
		try {
			boolean updatedDepartment = departmentService.updateDepartment(id, department);
			if (updatedDepartment) {
				return ResponseEntity.ok("Department updated successfully.");
			} else {
				return ResponseEntity.status(HttpStatus.BAD_REQUEST)
						.body("Email already exists or department does not exist.");
			}
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("Error updating department: " + e.getMessage());
		}
	}

	@GetMapping("/getAllDepartmentNames")
	public ResponseEntity<?> getAllDepartmentNames() {
		try {
			List<DepartmentNames> data = this.departmentService.getAllDepartmentNames();
			return new ResponseEntity<>(data, HttpStatus.OK);
		} catch (Exception e) {
			// Log the error and return error response
			e.printStackTrace();
			return new ResponseEntity<>("Failed to fetch department names", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/departmentDashboardData")
	public ResponseEntity<?> getDashboardData(@RequestParam("departmentId") int departmentId) {
		try {
			
			DashboardDataDto response = departmentService.getDashboardDataForDepartment(departmentId);
		
			return new ResponseEntity<>(response, HttpStatus.OK);
		} catch (ResourceNotFoundException e) {
			// Handle case where department is not found
			return new ResponseEntity<>("Department not found with ID: " + departmentId, HttpStatus.NOT_FOUND);
		} catch (Exception e) {
			// Log and handle any general errors
			e.printStackTrace();
			return new ResponseEntity<>("Failed to fetch dashboard data", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

}
