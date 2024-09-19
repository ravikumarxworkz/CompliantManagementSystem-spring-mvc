package com.modal.complaintManagementSystem.response;

import java.util.List;

import com.modal.complaintManagementSystem.dto.ComplaintDto;

import lombok.Data;

@Data
public class ComplaintResponseDto {

	private List<ComplaintDto> complaints;
	private int totalPages;

}
