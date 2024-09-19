package com.modal.complaintManagementSystem.dto;

import lombok.Data;

@Data
public class DepartmentLoginResponse {



	private int departmentId;
	private String departmentLoginEmail;
	private long totalComplaints;
	private long newComplaints;
	private long pendingComplaints;
	private long closedComplaints;
	private long totalEmployees;

}
