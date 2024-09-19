package com.modal.complaintManagementSystem.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.modal.complaintManagementSystem.dto.ComplaintDto;
import com.modal.complaintManagementSystem.dto.ComplaintTypeDto;
import com.modal.complaintManagementSystem.dto.ComplaintUpdateRequest;
import com.modal.complaintManagementSystem.dto.ProfileDto;
import com.modal.complaintManagementSystem.exception.ResourceNotFoundException;
import com.modal.complaintManagementSystem.response.ComplaintResponseDto;
import com.modal.complaintManagementSystem.service.ComplaintService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/")
public class ComplaintController {

	private static final Logger logger = LoggerFactory.getLogger(ComplaintController.class);

	@Autowired
	private ComplaintService complaintService;

	@PostMapping("/lodge-complaint")
	public ResponseEntity<?> lodgeComplaint(@RequestBody ComplaintDto complaintDto, HttpSession session) {
		try {
			ProfileDto profileDto = (ProfileDto) session.getAttribute("profileDto");
			if (profileDto == null) {
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
						.body("User not logged in or session has expired.");
			}
			int userId = profileDto.getUserId();
			complaintDto.setUserId(userId);
			ComplaintDto savedComplaint = complaintService.saveUserComplaint(complaintDto);

			if (savedComplaint != null) {
				return ResponseEntity.status(HttpStatus.CREATED).body(savedComplaint);
			} else {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to save the complaint.");
			}
		} catch (Exception e) {
			logger.error("Error processing the complaint: ", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("An unexpected error occurred: " + e.getMessage());
		}
	}

	@PostMapping("/updateComplaintDetailsByComplaintId")
	public ResponseEntity<String> updateComplaintDetails(@RequestParam int complaintId,
			@RequestParam String complaintDetails) {
		logger.info("Fetching complaint details for complaintId: {}", complaintId);
		logger.info("Fetching complaint details for complaintDetails: {}", complaintDetails);
		boolean updated = complaintService.updateComplaintDetailsByComplaintId(complaintId, complaintDetails);
		return updated ? ResponseEntity.ok("Complaint details updated successfully")
				: ResponseEntity.status(500).body("Failed to update Complaint details");
	}

	@GetMapping("/getComplaintDetailsById")
	public ResponseEntity<ComplaintDto> getComplaintDetails(@RequestParam int id) {
	    try {
	        ComplaintDto complaint = complaintService.getComplaintById(id);
	        return ResponseEntity.ok(complaint);
	    } catch (ResourceNotFoundException e) {
	        return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
	    }
	}


	@PostMapping("/assignDepartment")
	public ResponseEntity<String> assignDepartment(@RequestParam int complaintId, @RequestParam int departmentId) {
		boolean success = complaintService.assignDepartment(complaintId, departmentId);
		if (success) {
			return ResponseEntity.ok("Department assigned successfully!");
		} else {
			return ResponseEntity.status(400).body("Failed to assign department. Please check the provided IDs.");
		}
	}

	@GetMapping("/complaintTypes")
	public ResponseEntity<List<ComplaintTypeDto>> getComplaintTypes() {
		List<ComplaintTypeDto> complaintTypes = complaintService.getAllComplaintType();
		return ResponseEntity.ok(complaintTypes);
	}

	 @PostMapping("/updateComplaint/{complaintId}")
	    public ResponseEntity<String> updateComplaint(
	            @PathVariable("complaintId") int complaintId,
	            @RequestParam(value = "departmentId", required = false) Integer departmentId,
	            @RequestBody ComplaintUpdateRequest request) {
		
	        try {
	            boolean save = complaintService.updateComplaint(
	                complaintId, 
	                request.getDepartmentId(), // Pass the department ID if provided
	                request.getEmployeeId(), 
	                request.getStatus(),
	                request.getComments()
	            );
	            if (save) {
	                return ResponseEntity.ok("Complaint assignment and status updated successfully");
	            } else {
	                return ResponseEntity.status(HttpStatus.BAD_REQUEST)
	                        .body("Failed to update complaint assignment or status");
	            }
	        } catch (Exception e) {
	            // Log error details
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error saving assignment");
	        }
	    }

	@GetMapping("/getAllComplaintsByUser")
	public ResponseEntity<?> getAllComplaintsByUser(@RequestParam(value = "userId") int userId,
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "size", defaultValue = "10") int size,
			@RequestParam(value = "query", defaultValue = "") String query,
			@RequestParam(value = "status", defaultValue = "all") String status) {

		try {
			ComplaintResponseDto response = complaintService.getAllComplaintsbyUser(userId, page, size, query, status);
			return ResponseEntity.ok(response);
			// }
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("An error occurred while fetching complaints. Please try again later.");
		}
	}

	@GetMapping("/getAllComplaintsByDepartmentId")
	public ResponseEntity<ComplaintResponseDto> getAllComplaintsByDepartmentId(
			@RequestParam(value = "departmentId") int departmentId,
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "size", defaultValue = "10") int size,
			@RequestParam(value = "query", defaultValue = "") String query,
			@RequestParam(value = "status", defaultValue = "all") String status) {
		try {
			ComplaintResponseDto response = this.complaintService.getAllComplaintsbyDepartmentId(departmentId, page,
					size, query, status);
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

	@GetMapping("/getAllComplaintsByAdmin")
	public ResponseEntity<ComplaintResponseDto> getAllComplaintsByAdmin(
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "size", defaultValue = "10") int size,
			@RequestParam(value = "query", defaultValue = "") String query,
			@RequestParam(value = "status", defaultValue = "all") String status) {
		try {
			ComplaintResponseDto response = this.complaintService.getAllComplaintsByAdmin(page, size, query, status);
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

	@GetMapping("/getAllComplaintsByEmployee")
	public ResponseEntity<ComplaintResponseDto> getAllComplaintsByEmployee(
			@RequestParam(value = "employeeId") int employeeId,
			@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "size", defaultValue = "10") int size,
			@RequestParam(value = "query", defaultValue = "") String query,
			@RequestParam(value = "status", defaultValue = "all") String status) {
		try {
			ComplaintResponseDto response = this.complaintService.getAllComplaintsbyEmployee(employeeId, page, size,
					query, status);
			return ResponseEntity.ok(response);
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		}
	}

	@PostMapping("/sendComplaintCloseOtp")
	public ResponseEntity<String> sendComplaintCloseOtp(@RequestParam("complaintId") int complaintId) {
		boolean sendOtpToUserEmail = this.complaintService.sendClosingComplaintOtpToUserEmail(complaintId);
		if (sendOtpToUserEmail) {
			return ResponseEntity.ok("otp sent success");
		}
		return ResponseEntity.ok("otp not sent");
	}

	@PostMapping("/validateOtpAndUpdateComplaint")
	public ResponseEntity<Map<String, Object>> validateOtpAndUpdateComplaint(@RequestParam int complaintId,
			@RequestParam String status, @RequestParam String comments, @RequestParam String otp) {

		Map<String, Object> response = new HashMap<>();

		try {
			// Validate OTP
			boolean isValidOtp = complaintService.ComplaintValidateOtp(complaintId, otp);
			if (!isValidOtp) {
				response.put("success", false);
				response.put("message", "Invalid OTP");
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
			}

			// Update Complaint Status
			boolean updateComplaint = complaintService.updateComplaintStatus(complaintId, status, comments);
			if (!updateComplaint) {
				response.put("success", false);
				response.put("message", "Failed to update complaint status");
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
			}

			response.put("success", true);
			response.put("message", "Complaint status updated successfully");
			return ResponseEntity.ok(response);

		} catch (Exception e) {
			// Handle unexpected errors
			response.put("success", false);
			response.put("message", "An error occurred: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
	}

	@PostMapping("/validateOtpAndOfComplaint")
	public ResponseEntity<Map<String, Object>> validateOtpAndOfComplaint(@RequestParam int complaintId,
			@RequestParam String otp) {

		Map<String, Object> response = new HashMap<>();

		try {
			// Validate OTP
			boolean isValidOtp = complaintService.ComplaintValidateOtp(complaintId, otp);

			if (!isValidOtp) {
				response.put("success", false);
				response.put("message", "Invalid OTP");
				return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
			} else {
				response.put("success", true);
				response.put("message", "OTP validated successfully, you can now submit the complaint.");
				return ResponseEntity.ok(response);
			}
		} catch (Exception e) {
			// Handle unexpected errors
			response.put("success", false);
			response.put("message", "An error occurred: " + e.getMessage());
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
	}

	@PostMapping("/searchComplaintByDepartmentId")
	public String searchComplaintByDepartmentId(@RequestBody Map<String, Integer> request) {
		int complaintId = request.get("complaintId");
		int departmentId = request.get("departmentId");

		boolean exists = complaintService.checkComplaintByDepartmentId(complaintId, departmentId);
		return exists ? "exit" : "not exit";
	}

}
