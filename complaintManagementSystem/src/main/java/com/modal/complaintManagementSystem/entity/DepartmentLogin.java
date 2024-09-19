package com.modal.complaintManagementSystem.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.ForeignKey;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "department_login_details")
public class DepartmentLogin {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="login_id")
	private int departmentLoginId;
	@Column(name="email")
	private String departmentLoginEmail;
	@Column(name="password")
	private String departmentLoginPassword;
	@ManyToOne
	@JoinColumn(name = "department_id", foreignKey = @ForeignKey(name = "fk_department"))
	private Department department;

}
