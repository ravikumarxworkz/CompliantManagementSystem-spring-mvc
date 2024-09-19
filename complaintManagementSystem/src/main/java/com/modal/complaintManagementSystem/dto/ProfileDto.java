package com.modal.complaintManagementSystem.dto;

import java.time.LocalDateTime;

import javax.persistence.Id;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProfileDto {

	@Id
	private int userId;
	private String firstName;
	private String lastName;
	private String email;
	private long contactNumber;
	private long alterContactNumber;
	private String address;
	private boolean agreement;
	private String imagePath;
	private LocalDateTime createdAt;
 	private LocalDateTime updatedAt;
	private int complaintsCount;
	@JsonIgnore
	private MultipartFile imageFile;
	
}
