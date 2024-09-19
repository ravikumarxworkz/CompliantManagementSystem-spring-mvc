package com.modal.complaintManagementSystem.dto;

import javax.persistence.Id;

import lombok.Data;

@Data
public class ChangePasswordDto {

	@Id
	private int userId;
	private String oldPassword;
	private String newPassword;
	private String confirmPassword;

}
