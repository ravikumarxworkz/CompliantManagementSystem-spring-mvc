package com.modal.complaintManagementSystem.dto;

import java.time.LocalDateTime;

import javax.persistence.Id;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserDto {

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
	private String password;	
	private LocalDateTime createdAt;
 	private LocalDateTime updatedAt;
	
}
