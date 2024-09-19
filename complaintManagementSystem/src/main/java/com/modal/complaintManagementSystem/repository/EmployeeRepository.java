package com.modal.complaintManagementSystem.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.modal.complaintManagementSystem.entity.Department;
import com.modal.complaintManagementSystem.entity.Employee;

@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Integer> {

	int countByDepartment(Department department);

	Employee findByEmployeeEmail(String employeeEmail);

	// @Query("SELECT e FROM Employee e WHERE e.departmentId = :departmentId")
	List<Employee> findByDepartment(Department department);

	boolean existsByEmployeeContactNumber(Long employeeContactNumber);

	boolean existsByEmployeeEmail(String employeeEmail);

	// Fetch all employees by department without filtering by status
	Page<Employee> findByDepartment(Department department, Pageable pageable);

	// Fetch employees by department and specific status
	Page<Employee> findByDepartmentAndEmployeeEmailContaining(Department department, String employeeEmail,
			Pageable pageable);

	Page<Employee> findByEmployeeNameContainingIgnoreCase(String name, Pageable pageable);

	boolean existsByemployeeIdAndDepartment(int employeeId, Department department);

}
