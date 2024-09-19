package com.modal.complaintManagementSystem.dto;

import lombok.Data;

@Data
public class DashboardDataDto {

	
    private long totalUsers;
    private long totalComplaints;
    private long newComplaints;
    private long pendingComplaints;
    private long inProgressComplaints;
    private long closedComplaints;
    private long totalDepartments;
    private long totalEmployees;
}
