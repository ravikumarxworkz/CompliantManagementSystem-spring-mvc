package com.modal.complaintManagementSystem.dto;

import lombok.Data;

@Data
public class DepartmentResponse {

	private int departmentId;
	private String departmentName;
	private int totalComplaints;
	private int newComplaints;
	private int pendingComplaints;
	private int closedComplaints;
	private int totalEmployees;

}
