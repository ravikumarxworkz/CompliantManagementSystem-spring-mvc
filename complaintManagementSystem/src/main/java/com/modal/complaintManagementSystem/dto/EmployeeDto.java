package com.modal.complaintManagementSystem.dto;

import javax.persistence.Id;

import lombok.Data;

@Data
public class EmployeeDto {
     
	@Id
	private Integer employeeId;
	private String employeeName;
	private String employeeEmail;
	private String employeePassword;
	private String employeeImagePath;
	private Long employeeContactNumber;
	private String employeeStatus;
	private Integer departmentId; // Using departmentId to reference the department
     private String departmentName;
	// Getters and Setters

}
