package com.modal.complaintManagementSystem.dto;

import java.time.LocalDateTime;

import javax.persistence.Id;

import lombok.Data;

@Data
public class EmailValidationDTO {

	@Id
	private int id;
	private String email;
	private String otp;
	private LocalDateTime createdAt;

}
