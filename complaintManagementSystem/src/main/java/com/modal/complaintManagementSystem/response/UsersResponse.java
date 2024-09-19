package com.modal.complaintManagementSystem.response;

import java.util.List;

import com.modal.complaintManagementSystem.dto.ProfileDto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class UsersResponse {


	 private List<ProfileDto> users;
	    private int totalPages;

}
