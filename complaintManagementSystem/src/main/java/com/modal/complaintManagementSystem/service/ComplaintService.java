package com.modal.complaintManagementSystem.service;

import java.util.List;


import com.modal.complaintManagementSystem.dto.ComplaintDto;
import com.modal.complaintManagementSystem.dto.ComplaintTypeDto;
import com.modal.complaintManagementSystem.response.ComplaintResponseDto;

public interface ComplaintService {

	ComplaintDto saveUserComplaint(ComplaintDto complaintDto);

	boolean updateComplaintDetailsByComplaintId(int complaintId, String complaintDetails);

	ComplaintDto getComplaintById(int id);

	boolean assignDepartment(int complaintId, int departmentId);

	List<ComplaintTypeDto> getAllComplaintType();

	List<ComplaintDto> getComplaints();


	boolean updateComplaint(int complaintId,Integer departmentId, Integer employeeId, String status, String comments);


	ComplaintResponseDto getAllComplaintsbyUser(int userId, int page, int size, String query, String status);

	ComplaintResponseDto getAllComplaintsByAdmin(int page, int size, String query, String status);

	ComplaintResponseDto getAllComplaintsbyDepartmentId(int departmentId, int page, int size, String query,
			String status);

	ComplaintResponseDto getAllComplaintsbyEmployee(int EmployeeId, int page, int size, String query, String status);

	boolean sendClosingComplaintOtpToUserEmail(int camplaintId);

	boolean ComplaintValidateOtp(int camplaintId, String otp);

	boolean updateComplaintStatus(int complaintId, String status, String comments);


	boolean checkComplaintByDepartmentId(int complaintId, int departmentId);
}
