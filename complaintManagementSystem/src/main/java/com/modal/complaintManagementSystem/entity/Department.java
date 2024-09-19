package com.modal.complaintManagementSystem.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "departments")
public class Department {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "department_id")
	private int departmentId;
	@Column(name = "department_name")
	private String departmentName;
	@Column(name = "department_country")
	private String departmentCountry;
	@Column(name = "department_state")
	private String departmentState;
	@Column(name = "department_city")
	private String departmentCity;
	@Column(name = "department_area")
	private String departmentArea;
	@Column(name = "department_address")
	private String departmentAddress;
	@Column(name = "department_number")
	private long departmentContactNumber;
	@Column(name = "department_email")
	private String departmentEmail;

}
