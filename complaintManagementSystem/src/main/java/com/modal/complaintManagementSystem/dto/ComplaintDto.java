package com.modal.complaintManagementSystem.dto;

import java.time.LocalDateTime;

import javax.persistence.Id;

import lombok.Data;

@Data
public class ComplaintDto {

	@Id
	private int complaintId;
	private int userId;
	private String complaintType;
	private String country;
	private String state;
	private String city;
	private String cityArea;
	private String complaintAddress;
	private String complaintDetails;
	private String status;
	private LocalDateTime createdAt;
	private LocalDateTime updatedAt;
	private DepartmentDto departmentDto;
	private EmployeeDto employeeDto;
	private int departmentId; // Only department ID
	private int employeeId; 
	private String complaintComment;

}
