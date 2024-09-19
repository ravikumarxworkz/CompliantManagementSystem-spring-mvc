package com.modal.complaintManagementSystem.entity;

import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Data
@Entity
@Table(name = "complaintotp")
public class ComplaintOtp {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	private int complaintId;
	private String otpCode;
	private LocalDateTime createdTimestamp;

}
