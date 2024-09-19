package com.modal.complaintManagementSystem.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modal.complaintManagementSystem.dto.DashboardDataDto;
import com.modal.complaintManagementSystem.entity.AdminEntity;
import com.modal.complaintManagementSystem.repository.AdminRepository;
import com.modal.complaintManagementSystem.repository.ComplaintRepository;
import com.modal.complaintManagementSystem.repository.DepartmentRepository;
import com.modal.complaintManagementSystem.repository.EmployeeRepository;
import com.modal.complaintManagementSystem.repository.UserRepository;
import com.modal.complaintManagementSystem.service.AdminService;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminRepository adminRepository;

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private DepartmentRepository departmentRepository;

	@Autowired
	private ComplaintRepository complaintRepository;

	@Autowired
	private EmployeeRepository employeeRepository;

	@Override
	public DashboardDataDto getDashboardData() {
		log.info("DashboardDataDto");
		DashboardDataDto dto = new DashboardDataDto();
		dto.setTotalUsers(userRepository.count());
		dto.setTotalComplaints(complaintRepository.count()); //
		dto.setNewComplaints(complaintRepository.countNewComplaints()); //
		dto.setPendingComplaints(complaintRepository.countPendingComplaints()); //
		dto.setClosedComplaints(complaintRepository.countClosedComplaints()); //
		dto.setTotalDepartments(departmentRepository.count());
		dto.setTotalEmployees(employeeRepository.count());
		dto.setInProgressComplaints(complaintRepository.countInProgressComplaints());
		return dto;
	}

	@Override
	public boolean adminLogin(String email, String password) {
		if (email != null && password != null) {
			AdminEntity adminEntity = this.adminRepository.findByEmail(email);
			 System.out.println("adminEnitiy="+adminEntity);
			if (adminEntity != null) {
				if (adminEntity.getPassword().equals(password)) {
					return true;
				}

			}
		}
		return false;
	}

}