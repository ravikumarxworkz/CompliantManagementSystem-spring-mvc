package com.modal.complaintManagementSystem.dto;

import javax.persistence.Id;
import lombok.Data;
@Data
public class DepartmentNames {

	
	
	
	@Id
	private int departmentId;
	private String departmentName;

}
