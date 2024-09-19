package com.modal.complaintManagementSystem.response;

import java.util.List;


import com.modal.complaintManagementSystem.dto.EmployeeDto;

import lombok.Data;

@Data
public class EmployeeResponse {

	  private List<EmployeeDto> employees;
	    private int totalPages;

}
