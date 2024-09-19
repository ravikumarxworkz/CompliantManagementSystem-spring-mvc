package com.modal.complaintManagementSystem.service.impl;

import java.time.LocalDateTime;
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

import com.modal.complaintManagementSystem.dto.ComplaintDto;
import com.modal.complaintManagementSystem.dto.ComplaintTypeDto;
import com.modal.complaintManagementSystem.entity.Complaint;
import com.modal.complaintManagementSystem.entity.ComplaintOtp;
import com.modal.complaintManagementSystem.entity.ComplaintType;
import com.modal.complaintManagementSystem.entity.Department;
import com.modal.complaintManagementSystem.entity.Employee;
import com.modal.complaintManagementSystem.entity.UserEntity;
import com.modal.complaintManagementSystem.exception.ResourceNotFoundException;
import com.modal.complaintManagementSystem.mailSending.MailSending;
import com.modal.complaintManagementSystem.repository.ComplaintOtpRepository;
import com.modal.complaintManagementSystem.repository.ComplaintRepository;
import com.modal.complaintManagementSystem.repository.ComplaintTypeRepository;
import com.modal.complaintManagementSystem.repository.DepartmentRepository;
import com.modal.complaintManagementSystem.repository.EmployeeRepository;
import com.modal.complaintManagementSystem.repository.UserRepository;
import com.modal.complaintManagementSystem.response.ComplaintResponseDto;
import com.modal.complaintManagementSystem.service.ComplaintService;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@Transactional
public class ComplaintServiceImpl implements ComplaintService {

	@Autowired
	private ComplaintRepository complaintRepository;

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private DepartmentRepository departmentRepository;

	@Autowired
	private ComplaintTypeRepository complaintTypeRepository;

	@Autowired
	private EmployeeRepository employeeRepository;

	@Autowired
	private ComplaintOtpRepository complaintOtpRepository;

	@Autowired
	private MailSending mailSending;
	


	@Override
	public ComplaintDto saveUserComplaint(ComplaintDto complaintDto) {

		if (complaintDto != null) {
			UserEntity userEntity = this.userRepository.getById(complaintDto.getUserId());
			Complaint complaint = new Complaint();
			BeanUtils.copyProperties(complaintDto, complaint);
			complaint.setUser(userEntity);
			complaint.setCreatedAt(LocalDateTime.now());
			complaint.setStatus("Registered");

			Complaint complaintSave = this.complaintRepository.save(complaint);
			if (complaintSave != null) {
				log.info("Complaint saved successfully: {}", complaintSave);
				return complaintDto;
			} else {
				log.warn("Failed to save complaint: {}");
			}
		} else {
			log.warn("Received null ComplaintDto in saveUserComplaint");
		}
		return complaintDto;
	}


	@Transactional
	@Override
	public boolean updateComplaintDetailsByComplaintId(int complaintId, String complaintDetails) {
		log.info("Updating complaint details for complaintId: {}, new details: {}", complaintId, complaintDetails);

		boolean isUpdated = complaintRepository.updateComplaintDetails(complaintId, complaintDetails) > 0;
		if (isUpdated) {
			log.info("Complaint details updated successfully for complaintId: {}", complaintId);
		} else {
			log.warn("Failed to update complaint details for complaintId: {}", complaintId);
		}
		return isUpdated;
	}

	@Override
	public ComplaintDto getComplaintById(int id) {
	    Complaint complaint = complaintRepository.findById(id)
	            .orElseThrow(() -> new ResourceNotFoundException("Complaint not found with ID: " + id));
	    
	    ComplaintDto complaintDto = new ComplaintDto();
	    BeanUtils.copyProperties(complaint, complaintDto);
	    return complaintDto;
	}

	@Override
	public boolean assignDepartment(int complaintId, int departmentId) {
		log.info("Assigning departmentId: {} to complaintId: {}", departmentId, complaintId);

		var complaint = complaintRepository.findById(complaintId).orElse(null);
		if (complaint == null) {
			log.warn("Complaint not found with complaintId: {}", complaintId);
			return false;
		}

		var department = departmentRepository.findById(departmentId).orElse(null);
		if (department == null) {
			log.warn("Department not found with departmentId: {}", departmentId);
			return false;
		}

		complaint.setStatus("Pending");
		complaint.setDepartmentId(department);
		complaintRepository.save(complaint);

		log.info("Department assigned successfully to complaintId: {}", complaintId);
		return true;
	}

	@Override
	public List<ComplaintTypeDto> getAllComplaintType() {
		log.info("Fetching all complaint types");

		List<ComplaintType> complaintTypes = this.complaintTypeRepository.findAll();
		return complaintTypes.stream().map(complaintType -> {
			ComplaintTypeDto complaintTypeDto = new ComplaintTypeDto();
			BeanUtils.copyProperties(complaintType, complaintTypeDto);
			return complaintTypeDto;
		}).collect(Collectors.toList());
	}



	@Override
	 public boolean updateComplaint(int complaintId, Integer departmentId, Integer employeeId, String status, String comments) {
        log.debug("Updating complaint with ID: {}", complaintId);
        log.debug("Department ID: {}, Employee ID: {}, Status: {}, Comments: {}", departmentId, employeeId, status, comments);

        try {
            Complaint complaint = complaintRepository.findById(complaintId)
                    .orElseThrow(() -> new RuntimeException("Complaint not found with id: " + complaintId));

            Department department = departmentId != null ? departmentRepository.findById(departmentId).orElse(null) : null;
            Employee employee = employeeId != null ? employeeRepository.findById(employeeId).orElse(null) : null;
            if (department != null) {
                complaint.setDepartmentId(department);
            }
            if (employee != null) {
                complaint.setEmployee(employee);
            }

            if (status != null) {
                complaint.setStatus(status);
                log.debug("Updated status to: {}", status);
            }

            if (comments != null) {
                complaint.setComplaintComment(comments);
                log.debug("Updated comments to: {}", comments);
            }

            Complaint savedComplaint = complaintRepository.save(complaint);

            return savedComplaint != null;
        } catch (Exception e) {
        	log.error("Error updating complaint", e);
            throw e;
        }
    }

	// this method of by user table
	@Override
	public ComplaintResponseDto getAllComplaintsbyUser(int userId, int page, int size, String query, String status) {
		Pageable pageable = PageRequest.of(page - 1, size);
		UserEntity userEntity = userRepository.getById(userId);
		Page<Complaint> complaintsPage;

		// Check if both query and status are provided
		if (query != null && !query.isEmpty() && !"all".equalsIgnoreCase(status)) {
			complaintsPage = complaintRepository.findByUserAndComplaintTypeContainingAndStatus(userEntity, query,
					status, pageable);

		}
		// If only query is provided
		else if (query != null && !query.isEmpty()) {
			complaintsPage = complaintRepository.findByUserAndComplaintTypeContaining(userEntity, query, pageable);
		}
		// If only status is provided
		else if (!"all".equalsIgnoreCase(status)) {
			complaintsPage = complaintRepository.findByUserAndStatus(userEntity, status, pageable);
		}
		// If neither query nor status is provided, fetch all complaints
		else {
			complaintsPage = complaintRepository.findByUser(userEntity, pageable);
		}

		// Convert complaints to DTOs
		List<ComplaintDto> complaintDtos = complaintsPage.getContent().stream().map(this::toDto) // Use the private
																									// method within the
																									// class
				.collect(Collectors.toList());

		ComplaintResponseDto response = new ComplaintResponseDto();
		response.setComplaints(complaintDtos);
		response.setTotalPages(complaintsPage.getTotalPages());

		return response;
	}

	// this method of by Admin table
	@Override
	public ComplaintResponseDto getAllComplaintsByAdmin(int page, int size, String query, String status) {
		Pageable pageable = PageRequest.of(page - 1, size);
		Page<Complaint> complaintsPage;

		// Check if both query and status are provided
		if (query != null && !query.isEmpty() && !"all".equalsIgnoreCase(status)) {
			complaintsPage = complaintRepository.findByComplaintTypeContainingAndStatus(query, status, pageable);
		}
		// If only query is provided
		else if (query != null && !query.isEmpty()) {
			complaintsPage = complaintRepository.findByComplaintTypeContaining(query, pageable);
		}
		// If only status is provided
		else if (!"all".equalsIgnoreCase(status)) {
			complaintsPage = complaintRepository.findByStatus(status, pageable);
		}
		// If neither query nor status is provided, fetch all complaints
		else {
			complaintsPage = complaintRepository.findAll(pageable);
		}

		// Convert complaints to DTOs
		List<ComplaintDto> complaintDtos = complaintsPage.getContent().stream().map(this::toDto) // Use the private
																									// method within the
																									// class
				.collect(Collectors.toList());

		ComplaintResponseDto response = new ComplaintResponseDto();
		response.setComplaints(complaintDtos);
		response.setTotalPages(complaintsPage.getTotalPages());

		return response;
	}

	// this method of by Department table
	@Override
	public ComplaintResponseDto getAllComplaintsbyDepartmentId(int departmentId, int page, int size, String query,
			String status) {
		Pageable pageable = PageRequest.of(page - 1, size);
		Department department = departmentRepository.findByDepartmentId(departmentId);
		Page<Complaint> complaintsPage;

		// Check if both query and status are provided
		if (query != null && !query.isEmpty() && !"all".equalsIgnoreCase(status)) {
			complaintsPage = complaintRepository.findByDepartmentIdAndComplaintTypeContainingAndStatus(department,
					query, status, pageable);
		}
		// If only query is provided
		else if (query != null && !query.isEmpty()) {
			complaintsPage = complaintRepository.findByDepartmentIdAndComplaintTypeContaining(department, query,
					pageable);
		}
		// If only status is provided
		else if (!"all".equalsIgnoreCase(status)) {
			complaintsPage = complaintRepository.findByDepartmentIdAndStatus(department, status, pageable);
		}
		// If neither query nor status is provided, fetch all complaints
		else {
			complaintsPage = complaintRepository.findByDepartmentId(department, pageable);
		}

		// Convert complaints to DTOs
		List<ComplaintDto> complaintDtos = complaintsPage.getContent().stream().map(this::toDto) // Use the private
																									// method within the
																									// class
				.collect(Collectors.toList());

		ComplaintResponseDto response = new ComplaintResponseDto();
		response.setComplaints(complaintDtos);
		response.setTotalPages(complaintsPage.getTotalPages());

		return response;
	}

	// this method is to fetch value of employees
	@Override
	public ComplaintResponseDto getAllComplaintsbyEmployee(int EmployeeId, int page, int size, String query,
			String status) {
		Pageable pageable = PageRequest.of(page - 1, size);
		Employee employee = employeeRepository.getById(EmployeeId);
		Page<Complaint> complaintsPage;

		// Check if both query and status are provided
		if (query != null && !query.isEmpty() && !"all".equalsIgnoreCase(status)) {
			complaintsPage = complaintRepository.findByEmployeeAndComplaintTypeContainingAndStatus(employee, query,
					status, pageable);
		}
		// If only query is provided
		else if (query != null && !query.isEmpty()) {
			complaintsPage = complaintRepository.findByEmployeeAndComplaintTypeContaining(employee, status, pageable);
		}
		// If only status is provided
		else if (!"all".equalsIgnoreCase(status)) {
			complaintsPage = complaintRepository.findByEmployeeAndStatus(employee, status, pageable);
		}
		// If neither query nor status is provided, fetch all complaints
		else {
			complaintsPage = complaintRepository.findByEmployee(employee, pageable);
		}

		List<ComplaintDto> complaintDtos = complaintsPage.getContent().stream().map(this::toDto) // Use the private
				// method within the
				// class
				.collect(Collectors.toList());

		ComplaintResponseDto response = new ComplaintResponseDto();
		response.setComplaints(complaintDtos);
		response.setTotalPages(complaintsPage.getTotalPages());

		return response;
	}

	// this to convert entity to DTo
	private ComplaintDto toDto(Complaint complaint) {
		ComplaintDto dto = new ComplaintDto();
		dto.setComplaintId(complaint.getComplaintId());
		dto.setUserId(complaint.getUser().getUserId()); // Set only user ID
		dto.setComplaintType(complaint.getComplaintType());
		dto.setCountry(complaint.getCountry());
		dto.setState(complaint.getState());
		dto.setCity(complaint.getCity());
		dto.setCityArea(complaint.getCityArea());
		dto.setComplaintAddress(complaint.getComplaintAddress());
		dto.setComplaintDetails(complaint.getComplaintDetails());
		dto.setStatus(complaint.getStatus());
		dto.setCreatedAt(complaint.getCreatedAt());
		dto.setUpdatedAt(complaint.getUpdatedAt());
		dto.setComplaintComment(complaint.getComplaintComment());
		if (complaint.getDepartmentId() != null) {
			dto.setDepartmentId(complaint.getDepartmentId().getDepartmentId()); // Set only department ID
		}
		if (complaint.getEmployee() != null) {
			dto.setEmployeeId(complaint.getEmployee().getEmployeeId()); // Set only employee ID
		}
		return dto;
	}

	@Override
	public List<ComplaintDto> getComplaints() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean sendClosingComplaintOtpToUserEmail(int camplaintId) {
		Complaint complaint = complaintRepository.findById(camplaintId)
				.orElseThrow(() -> new RuntimeException("Complaint not found with id: " + camplaintId));
		UserEntity userEntity = this.userRepository.getById(complaint.getUser().getUserId());
		if (userEntity != null) {
			String otp = generateOtp();
			ComplaintOtp complaintOtp = new ComplaintOtp();
			complaintOtp.setComplaintId(camplaintId);
			complaintOtp.setOtpCode(otp);
			complaintOtp.setCreatedTimestamp(LocalDateTime.now());
			ComplaintOtp save = this.complaintOtpRepository.save(complaintOtp);
			if (save != null) {
				boolean send = true;
				 mailSending.sendOtpToUser(userEntity.getEmail(), otp);
				if (send) {
					return true;
				} else {
					return false;
				}

			}
		}
		return false;
	}

	private String generateOtp() {
		// Generate a random 6-digit OTP
		return String.valueOf((int) (Math.random() * 900000) + 100000);
	}

	@Override
	public boolean ComplaintValidateOtp(int camplaintId, String otpCode) {

		Optional<ComplaintOtp> latestOtpOpt = this.complaintOtpRepository
				.findFirstByComplaintIdOrderByCreatedTimestampDesc(camplaintId);

		if (latestOtpOpt.isPresent()) {
			ComplaintOtp latestOtp = latestOtpOpt.get();
			return latestOtp.getOtpCode().equals(otpCode);
		}

		return false; // No OTP found or invalid OTP
	}

	@Override
	public boolean updateComplaintStatus(int complaintId, String status, String comments) {

		Complaint complaint = this.complaintRepository.getById(complaintId);
		if (complaint != null) {
			complaint.setStatus(status);
			complaint.setComplaintComment(comments);
			Complaint save = this.complaintRepository.save(complaint);
			if (save != null) {
				return true;
			}
		}
		return false;
	}

	@Override
	public boolean checkComplaintByDepartmentId(int complaintId, int departmentId) {
		Department department = departmentRepository.findByDepartmentId(departmentId);
		return complaintRepository.existsByComplaintIdAndDepartmentId(complaintId, department);
	}

}
