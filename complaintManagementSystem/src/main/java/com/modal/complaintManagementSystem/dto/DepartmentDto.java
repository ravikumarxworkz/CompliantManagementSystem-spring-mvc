package com.modal.complaintManagementSystem.dto;

import javax.persistence.Id;

import lombok.Data;

@Data
public class DepartmentDto {

	@Id
	private int departmentId;
	private String departmentName;
	private String departmentCountry;
	private String departmentState;
	private String departmentCity;
	private String departmentArea;
	private String departmentAddress;
	private long departmentContactNumber;
	private String departmentEmail;

}
