package com.modal.complaintManagementSystem.entity;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.persistence.ForeignKey;
import javax.persistence.ManyToOne;
import javax.persistence.JoinColumn;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import com.fasterxml.jackson.annotation.JsonBackReference;

import lombok.Data;

@Entity
@Data
@Table(name = "employees")
public class Employee {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "employee_id")
	private Integer employeeId;

	@Column(name = "employee_name", nullable = false)
	@NotBlank(message = "Employee name is required")
	@Size(max = 100, message = "Employee name must be less than 100 characters")
	private String employeeName;

	@Column(name = "employee_email", nullable = false, unique = true)
	@NotBlank(message = "Employee email is required")
	@Email(message = "Invalid email format")
	private String employeeEmail;

	@Column(name = "password", nullable = false)
	@NotBlank(message = "Password is required")
	private String employeePassword;

	@Column(name = "image_path")
	private String employeeImagePath;

	@Column(name = "employee_contact_number", nullable = false)
	private Long employeeContactNumber;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "department_id", foreignKey = @ForeignKey(name = "fk_department"))
	@JsonBackReference
	private Department department;

	@Column(name = "employee_status")
	private String employeeStatus;

	// Getters and Setters

}
