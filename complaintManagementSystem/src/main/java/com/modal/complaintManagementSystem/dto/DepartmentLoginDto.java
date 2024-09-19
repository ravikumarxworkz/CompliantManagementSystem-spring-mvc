package com.modal.complaintManagementSystem.dto;

import javax.persistence.Id;

import lombok.Data;

@Data
public class DepartmentLoginDto {

	@Id
	private int departmentLoginId;
	private String departmentLoginEmail;
	private String departmentLoginPassword;
	private int departmentId;

}
