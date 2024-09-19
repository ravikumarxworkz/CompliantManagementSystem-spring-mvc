package com.modal.complaintManagementSystem.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.modal.complaintManagementSystem.dto.DashboardDataDto;
import com.modal.complaintManagementSystem.dto.DepartmentDto;
import com.modal.complaintManagementSystem.dto.DepartmentLoginDto;
import com.modal.complaintManagementSystem.dto.DepartmentNames;
import com.modal.complaintManagementSystem.dto.DepartmentResponse;
import com.modal.complaintManagementSystem.entity.Complaint;
import com.modal.complaintManagementSystem.entity.Department;
import com.modal.complaintManagementSystem.entity.DepartmentLogin;
import com.modal.complaintManagementSystem.exception.DepartmentRegistrationException;
import com.modal.complaintManagementSystem.exception.PasswordMismatchException;
import com.modal.complaintManagementSystem.exception.ResourceNotFoundException;
import com.modal.complaintManagementSystem.exception.UserNotFoundException;
import com.modal.complaintManagementSystem.repository.ComplaintRepository;
import com.modal.complaintManagementSystem.repository.DepartmentLoginRepository;
import com.modal.complaintManagementSystem.repository.DepartmentRepository;
import com.modal.complaintManagementSystem.repository.EmployeeRepository;
import com.modal.complaintManagementSystem.service.DepartmentService;

@Service
public class DepartmentServiceImpl implements DepartmentService {

	@Autowired
	private DepartmentRepository departmentRepository;

	@Autowired
	private DepartmentLoginRepository departmentLoginRepository;

	@Autowired
	private ComplaintRepository complaintRepository;

	@Autowired
	private EmployeeRepository employeeRepository;

	@Override
	public boolean registerDepartment(DepartmentDto departmentDto) {
		if (departmentDto != null) {
			boolean emailExists = departmentRepository.existsByDepartmentEmail(departmentDto.getDepartmentEmail());
			boolean contactNumberExists = departmentRepository
					.existsByDepartmentContactNumber(departmentDto.getDepartmentContactNumber());

			if (emailExists) {
				throw new DepartmentRegistrationException("Email already exists.");
			}

			if (contactNumberExists) {
				throw new DepartmentRegistrationException("Contact number already exists.");
			}
			Department department = new Department();
			BeanUtils.copyProperties(departmentDto, department);
			Department savedDepartment = this.departmentRepository.save(department);
			return savedDepartment != null;
		}
		return false;
	}

	@Override
	public boolean registerDepartmentLogin(DepartmentLoginDto departmentLoginDto) {
		if (departmentLoginDto != null) {
			if (this.departmentLoginRepository
					.existsByDepartmentLoginEmail(departmentLoginDto.getDepartmentLoginEmail())) {
				return false;
			}
			Department department = this.departmentRepository.findById(departmentLoginDto.getDepartmentId())
					.orElse(null);
			if (department != null) {
				DepartmentLogin departmentLogin = new DepartmentLogin();
				departmentLogin.setDepartmentLoginEmail(departmentLoginDto.getDepartmentLoginEmail());
				departmentLogin.setDepartment(department);
				BeanUtils.copyProperties(departmentLoginDto, departmentLogin);
				this.departmentLoginRepository.save(departmentLogin);
				return true;
			} else {
				return false;
			}
		}
		return false;
	}

	@Override
	public List<DepartmentResponse> getAllDepartments() {
	    try {
	        // Fetch all departments
	        List<Department> departments = departmentRepository.findAll();

	        // Map each department to a DepartmentResponse
	        return departments.stream().map(department -> {
	            DepartmentResponse response = mapToDepartmentResponse(department);

	            // Fetch complaints for the department and handle errors
	            List<Complaint> complaints = complaintRepository.findByDepartmentId(department);
	            if (complaints == null) {
	                throw new ResourceNotFoundException("No complaints found for department ID: " + department.getDepartmentId());
	            }

	            // Calculate complaint statistics
	            int totalComplaints = complaints.size();
	            int newComplaints = (int) complaints.stream()
	                    .filter(c -> c.getStatus().equalsIgnoreCase("Registered"))
	                    .count();
	            int pendingComplaints = (int) complaints.stream()
	                    .filter(c -> c.getStatus().equalsIgnoreCase("In Progress"))
	                    .count();
	            int closedComplaints = (int) complaints.stream()
	                    .filter(c -> c.getStatus().equalsIgnoreCase("Closed"))
	                    .count();
	            response.setTotalComplaints(totalComplaints);
	            response.setNewComplaints(newComplaints);
	            response.setPendingComplaints(pendingComplaints);
	            response.setClosedComplaints(closedComplaints);

	            // Fetch total employees in the department and handle errors
	            int totalEmployees = employeeRepository.countByDepartment(department);
	            response.setTotalEmployees(totalEmployees);

	            return response;

	        }).collect(Collectors.toList());

	    } catch (ResourceNotFoundException e) {
	        // Handle specific case when data is not found
	        System.err.println("Error: " + e.getMessage());
	        throw new ResourceNotFoundException("Error fetching department data: " + e.getMessage());

	    } catch (Exception e) {
	        // Handle general exceptions
	        e.printStackTrace();
	        throw new RuntimeException("An error occurred while fetching departments", e);
	    }
	}


	@Override
	public Page<DepartmentResponse> findDepartments(int page, int size, String search) {
	    // Create Pageable object
	    Pageable pageable = PageRequest.of(page - 1, size);

	    // Fetch departments based on the search criteria
	    Page<Department> departmentPage;
	    if (search != null && !search.isEmpty()) {
	        departmentPage = departmentRepository.findByDepartmentNameContaining(search, pageable);
	    } else {
	        departmentPage = departmentRepository.findAll(pageable);
	    }

	    // Convert Department entities to DepartmentResponse objects
	    List<DepartmentResponse> departmentResponses = new ArrayList<>();
	    for (Department department : departmentPage.getContent()) {
	        DepartmentResponse response = mapToDepartmentResponse(department);

	        // Fetch complaints related to the department
	        List<Complaint> complaints = complaintRepository.findByDepartmentId(department);

	        // Calculate complaint statistics
	        int totalComplaints = complaints.size();
	        int newComplaints = (int) complaints.stream().filter(c -> c.getStatus().equals("Registered")).count();
	        int pendingComplaints = (int) complaints.stream().filter(c -> c.getStatus().equalsIgnoreCase("In Progress")).count();
	        int closedComplaints = (int) complaints.stream().filter(c -> c.getStatus().equalsIgnoreCase("Closed")).count();

	        // Set complaint statistics in response
	        response.setTotalComplaints(totalComplaints);
	        response.setNewComplaints(newComplaints);
	        response.setPendingComplaints(pendingComplaints);
	        response.setClosedComplaints(closedComplaints);

	        // Fetch total employees in the department
	        int totalEmployees = employeeRepository.countByDepartment(department);
	        response.setTotalEmployees(totalEmployees);

	        // Add response to the list
	        departmentResponses.add(response);
	    }

	    // Return the results as a Page
	    return new PageImpl<>(departmentResponses, pageable, departmentPage.getTotalElements());
	}

	private DepartmentResponse mapToDepartmentResponse(Department department) {
	    DepartmentResponse response = new DepartmentResponse();
	    response.setDepartmentId(department.getDepartmentId()); // Ensure proper naming convention
	    response.setDepartmentName(department.getDepartmentName());
	    return response;
	}

	@Override
	public List<DepartmentNames> getAllDepartmentNames() {
	    try {
	        // Fetch all departments
	        List<Department> departments = departmentRepository.findAll();

	        // Check if the list is empty
	        if (departments.isEmpty()) {
	            throw new ResourceNotFoundException("No departments found");
	        }

	        // Map each department to a DepartmentNames object
	        return departments.stream().map(department -> {
	            DepartmentNames departmentNames = new DepartmentNames();
	            departmentNames.setDepartmentId(department.getDepartmentId());
	            departmentNames.setDepartmentName(department.getDepartmentName());
	            return departmentNames; // Return the DepartmentNames object
	        }).collect(Collectors.toList()); // Collect results into a List

	    } catch (ResourceNotFoundException e) {
	       
	        throw new ResourceNotFoundException("Error fetching department names: " + e.getMessage());

	    } catch (Exception e) {
	        // Handle any other exceptions
	        e.printStackTrace();
	        throw new RuntimeException("An error occurred while fetching department names", e);
	    }
	}


	@Override
	public DepartmentDto getDepartmentById(int id) {
	    Department department = departmentRepository.findById(id)
	            .orElseThrow(() -> new ResourceNotFoundException("Department not found with ID: " + id));

	    DepartmentDto departmentDto = new DepartmentDto();
	    BeanUtils.copyProperties(department, departmentDto);
	    return departmentDto;
	}


	@Override
	public boolean updateDepartment(int id, DepartmentDto departmentDto) {
		if (id != 0 && departmentDto != null) {
			Department existingDepartment = departmentRepository.findById(id).orElse(null);
			if (existingDepartment == null) {
				return false;
			}
			boolean emailExists = departmentRepository.existsByDepartmentEmail(departmentDto.getDepartmentEmail())
					&& !departmentDto.getDepartmentEmail().equals(existingDepartment.getDepartmentEmail());

			boolean contactNumberExists = departmentRepository
					.existsByDepartmentContactNumber(departmentDto.getDepartmentContactNumber())
					&& departmentDto.getDepartmentContactNumber() != existingDepartment.getDepartmentContactNumber();

			if (emailExists) {
				return false;
			}

			if (contactNumberExists) {
				return false;
			}

			// Update department details
			BeanUtils.copyProperties(departmentDto, existingDepartment, "departmentId");
			existingDepartment.setDepartmentId(id);
			Department updatedDepartment = departmentRepository.save(existingDepartment);
			return updatedDepartment != null;
		}
		return false;
	}

	@Override
	public DepartmentLoginDto DepartmentLogin(String email, String password)
			throws UserNotFoundException, PasswordMismatchException {

		if (email == null || password == null) {
			throw new UserNotFoundException("Email or password is null");
		}

		DepartmentLogin login = this.departmentLoginRepository.findByDepartmentLoginEmail(email);
		
		if (login == null) {
			throw new UserNotFoundException("Login email not found");
		} else if (!login.getDepartmentLoginPassword().equals(password)) {
			throw new PasswordMismatchException("Password is incorrect");
		}
		DepartmentLoginDto loginDto = new DepartmentLoginDto();
		BeanUtils.copyProperties(login, loginDto);
		loginDto.setDepartmentLoginPassword(null);
		login.setDepartmentLoginId(login.getDepartmentLoginId());
		login.setDepartmentLoginEmail(login.getDepartmentLoginEmail());
		loginDto.setDepartmentId(login.getDepartment().getDepartmentId());
		return loginDto;

	}

	@Override
	public DashboardDataDto getDashboardDataForDepartment(int departmentId) {
		// Fetch all complaints for the given department
		List<Complaint> complaints = fetchAllComplintsByDepartmentID(departmentId);
           System.out.println(complaints);
		// Initialize counters for the different complaint statuses
		int totalComplaints = complaints.size();
		int newComplaints = (int) complaints.stream().filter(c -> c.getStatus().equalsIgnoreCase("pending")).count();
		int pendingComplaints = (int) complaints.stream().filter(c -> c.getStatus().equalsIgnoreCase("In Progress"))
				.count();
		int closedComplaints = (int) complaints.stream().filter(c -> c.getStatus().equalsIgnoreCase("Closed")).count();

		// Fetch total employees for the department
		int totalEmployees = this.employeeRepository
				.countByDepartment(departmentRepository.findByDepartmentId(departmentId));

		// Create a DTO to hold the dashboard data
		DashboardDataDto dashboardDataDto = new DashboardDataDto();
		dashboardDataDto.setTotalComplaints(totalComplaints);
		dashboardDataDto.setNewComplaints(newComplaints);
		dashboardDataDto.setPendingComplaints(pendingComplaints);
		dashboardDataDto.setClosedComplaints(closedComplaints);
		dashboardDataDto.setTotalEmployees(totalEmployees);

		return dashboardDataDto;
	}

	private List<Complaint> fetchAllComplintsByDepartmentID(int departmentId) {
		Department department = this.departmentRepository.findByDepartmentId(departmentId);
		return this.complaintRepository.findByDepartmentId(department);

	}
}
