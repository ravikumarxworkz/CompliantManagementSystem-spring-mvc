package com.modal.complaintManagementSystem.service;

import com.modal.complaintManagementSystem.dto.DashboardDataDto;
import com.modal.complaintManagementSystem.exception.AdminNotFoundException;
import com.modal.complaintManagementSystem.exception.InvalidPasswordException;

public interface AdminService {

	boolean adminLogin(String email, String password) throws AdminNotFoundException, InvalidPasswordException;

	DashboardDataDto getDashboardData();
}
