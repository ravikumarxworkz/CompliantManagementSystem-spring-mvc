package com.modal.complaintManagementSystem.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import com.modal.complaintManagementSystem.entity.Department;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface DepartmentRepository extends JpaRepository<Department, Integer> {

	@Query("SELECT d FROM Department d WHERE d.departmentId = :departmentId")
	Department findByDepartmentId(@Param("departmentId") int departmentId);

	boolean existsByDepartmentEmail(String departmentEmail);

	boolean existsByDepartmentContactNumber(long departmentContactNumber);
       
	Page<Department> findByDepartmentNameContaining(String departmentName, Pageable pageable);

}
