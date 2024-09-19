package com.modal.complaintManagementSystem.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.modal.complaintManagementSystem.dto.ChangePasswordDto;
import com.modal.complaintManagementSystem.dto.EmployeeDto;
import com.modal.complaintManagementSystem.dto.EmployeeNames;
import com.modal.complaintManagementSystem.exception.EmployeeAlreadyExistsException;
import com.modal.complaintManagementSystem.exception.InvalidPasswordException;
import com.modal.complaintManagementSystem.exception.NoEmployeesFoundException;
import com.modal.complaintManagementSystem.exception.PasswordMismatchException;
import com.modal.complaintManagementSystem.exception.ResourceNotFoundException;
import com.modal.complaintManagementSystem.exception.UserNotFoundException;
import com.modal.complaintManagementSystem.response.EmployeeResponse;
import com.modal.complaintManagementSystem.service.EmployeeService;

@RestController
@RequestMapping("/employee")
public class EmployeeController {

	private static final Logger logger = LoggerFactory.getLogger(ComplaintController.class);

	@Autowired
	private EmployeeService employeeService;

	@GetMapping("/{id}/employees")
	public ResponseEntity<List<EmployeeDto>> getEmployeesByDepartmentId(@PathVariable int id) {
	    try {
	        List<EmployeeDto> employees = employeeService.getEmployeesByDepartmentId(id);
	        return ResponseEntity.ok(employees);
	    } catch (ResourceNotFoundException e) {
	        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
	    } catch (NoEmployeesFoundException e) {
	        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
	    }
	}


	@PostMapping("/createEmployee")
	public ResponseEntity<?> createEmployee(@RequestBody EmployeeDto employeeDto) {
		try {
			boolean saveEmployee = this.employeeService.createEmployee(employeeDto);
			if (saveEmployee) {
				return ResponseEntity.ok().body("Employee created successfully.");
			} else {
				return ResponseEntity.ok().body("Employee account not created");
			}
		} catch (EmployeeAlreadyExistsException e) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error creating employee.");
		}
	}

	// Get Employee By ID
	@GetMapping("/getEmployeeById")
	public ResponseEntity<EmployeeDto> getEmployeeById(@RequestParam int employeeId) {
	    try {
	        EmployeeDto employee = employeeService.getEmployeeById(employeeId);
	        return ResponseEntity.ok(employee);
	    } catch (ResourceNotFoundException e) {
	        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
	    }
	}


	// Update Employee Status
	@PostMapping("/updateEmployeeStatus")
	public ResponseEntity<String> updateEmployeeStatus(@RequestParam int employeeId, @RequestParam String status) {
		boolean isUpdated = employeeService.updateEmployeeStatus(employeeId, status);
		if (isUpdated) {
			return ResponseEntity.ok("Employee status updated successfully");
		} else {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failed to update employee status");
		}
	}

	// Delete Employee
	@PostMapping("/deleteEmployee")
	public ResponseEntity<String> deleteEmployee(@RequestParam int employeeId) {
		// int deleteEmployeeId=Integer.parseInt(employeeId);
		logger.info("deleteEmployeeId", employeeId);
		boolean isDeleted = employeeService.deleteEmployee(employeeId);
		if (isDeleted) {
			return ResponseEntity.ok("Employee deleted successfully");
		} else {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Failed to delete employee");
		}
	}

	@GetMapping("/getSortedEmployees")
	public ResponseEntity<Map<String, Object>> getSortedEmployees(@RequestParam("departmentId") int departmentId,
			@RequestParam(value = "query", required = false) String query, @RequestParam("page") int page,
			@RequestParam("size") int size) {

		// Adjust logic for query/search
		Page<EmployeeDto> employeesPage;
		if (query != null && !query.isEmpty()) {
			employeesPage = employeeService.searchEmployeesByEmail(departmentId, query, page, size);
		} else {
			employeesPage = employeeService.getSortedEmployeesByDepartmentId(departmentId, "all", page, size);
		}

		Map<String, Object> response = new HashMap<>();
		response.put("employees", employeesPage.getContent());
		response.put("totalPages", employeesPage.getTotalPages());
		response.put("totalElements", employeesPage.getTotalElements());
		response.put("currentPage", employeesPage.getNumber() + 1);

		return ResponseEntity.ok(response);
	}

	@GetMapping("/getEmployeeNamesByDepartmentId")
	public ResponseEntity<List<EmployeeNames>> getEmployeeNamesByDepartmentId(@RequestParam int departmentId) {
	    try {
	        List<EmployeeNames> employeeNames = this.employeeService.getEmployeeNamesByDepartmentId(departmentId);
	        return ResponseEntity.ok(employeeNames);
	    } catch (ResourceNotFoundException e) {
	        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
	    }
	}


	@GetMapping("/getAllEmployees")
	public ResponseEntity<EmployeeResponse> getAllEmployees(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "size", defaultValue = "10") int size,
			@RequestParam(value = "query", defaultValue = "") String query) {
		try {
			EmployeeResponse response = employeeService.getAllEmployees(page, size, query);
		
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			// Log error details
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}
	}

	@PostMapping("/searchEmployeeByDepartmentId")
	public String searchEmployeeByDepartmentId(@RequestBody Map<String, Integer> request) {
		int employeeId = request.get("employeeId");
		int departmentId = request.get("departmentId");

		boolean exists = employeeService.checkEmployeeByDepartmentId(employeeId, departmentId);
		return exists ? "exit" : "not exit";
	}

	@PostMapping("/changeEmployeePassword")
	public ResponseEntity<?> changePassword(@RequestBody ChangePasswordDto changePasswordDto, HttpSession session) {
		try {
			if (changePasswordDto == null) {
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Profile data not found in session");
			}
			EmployeeDto updatedProfile = employeeService.changeEmployeePassword(changePasswordDto);
			return ResponseEntity.ok(updatedProfile);
		} catch (UserNotFoundException | InvalidPasswordException | PasswordMismatchException ex) {
			return ResponseEntity.badRequest().body(ex.getMessage());
		} catch (Exception ex) {
			// Handle unexpected exceptions
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An unexpected error occurred.");
		}
	}
	
	@PostMapping("/updateEmployeeImage")
	public ResponseEntity<Map<String, String>> updateEmployeeImage(
	    @RequestParam("imageFile") MultipartFile imageFile,
	    @RequestParam("employeeId") int employeeId) {

	    try {
	        String newImagePath = employeeService.updateEmployeeImage(imageFile, employeeId);
	        Map<String, String> response = new HashMap<>();
	        response.put("message", "Image updated successfully");
	        response.put("newImagePath", newImagePath);
	        return ResponseEntity.ok(response);
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                             .body(Collections.singletonMap("message", "Failed to update the image."));
	    }
	}


}
