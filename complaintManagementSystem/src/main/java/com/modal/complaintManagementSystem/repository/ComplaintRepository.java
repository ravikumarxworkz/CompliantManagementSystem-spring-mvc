package com.modal.complaintManagementSystem.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.modal.complaintManagementSystem.entity.Complaint;
import com.modal.complaintManagementSystem.entity.Department;
import com.modal.complaintManagementSystem.entity.Employee;
import com.modal.complaintManagementSystem.entity.UserEntity;

@Repository
public interface ComplaintRepository extends JpaRepository<Complaint, Integer> {
	
	// General count for all complaints	
	@Query("SELECT COUNT(c) FROM Complaint c")
	long count();

	@Query("SELECT COUNT(c) FROM Complaint c WHERE c.status = 'Registered'")
	long countNewComplaints();

	@Query("SELECT COUNT(c) FROM Complaint c WHERE c.status = 'Pending'")
	long countPendingComplaints();

	@Query("SELECT COUNT(c) FROM Complaint c WHERE c.status = 'Closed'")
	long countClosedComplaints();
	
	@Query("SELECT COUNT(c) FROM Complaint c WHERE c.status = 'In Progress'")
	long countInProgressComplaints();

	List<Complaint> findByUser(UserEntity user);
	
	
	int countByUser(UserEntity user);
	
	@Modifying
	@Query("UPDATE Complaint c SET c.complaintDetails = :complaintDetails WHERE c.complaintId = :complaintId")
	int updateComplaintDetails(@Param("complaintId") int complaintId,
			@Param("complaintDetails") String complaintDetails);
	

	

	// @Query("SELECT c FROM Complaint c WHERE c.departmentId = :department_Id")
	List<Complaint> findByDepartmentId(Department departmentId);

	List<Complaint> findByStatus(String status);

	Page<Complaint> findAllByDepartmentIdOrderByStatus(Department departmentId, Pageable pageable);

	// Fetch complaints by department and specific status
	Page<Complaint> findByDepartmentIdAndStatus(Department departmentId, String status, Pageable pageable);

	Page<Complaint> findByDepartmentIdAndComplaintType(Department departmentId, String complaintType,
			Pageable pageable);

	// this methods belongs to Department complaint table
	Page<Complaint> findByDepartmentId(Department department, Pageable pageable);

	Page<Complaint> findByDepartmentIdAndComplaintTypeContaining(Department department, String complaintType,
			Pageable pageable);

	Page<Complaint> findByDepartmentIdAndComplaintTypeContainingAndStatus(Department department, String query,
			String status, Pageable pageable);

	// this methods belongs to Admin complaint table
	Page<Complaint> findByComplaintTypeContainingAndStatus(String query, String status, Pageable pageable);

	Page<Complaint> findByComplaintTypeContaining(String query, Pageable pageable);

	Page<Complaint> findByStatus(String status, Pageable pageable);

	// this methods belongs to user complaint table
	Page<Complaint> findByUser(UserEntity user, Pageable pageable);
	
	Page<Complaint> findByUserAndComplaintTypeContainingAndStatus(UserEntity userEntity, String query, String status,
			Pageable pageable);

	Page<Complaint> findByUserAndComplaintTypeContaining(UserEntity user, String complaintType, Pageable pageable);

	Page<Complaint> findByUserAndStatus(UserEntity user, String status, Pageable pageable);

	
	
	List<Complaint> findByEmployee(Employee employee);
	
	Page<Complaint> findByEmployeeAndComplaintTypeContainingAndStatus(Employee employee, String query, String status,
			Pageable pageable);
	
	Page<Complaint>  findByEmployeeAndComplaintTypeContaining(Employee employee, String complaintType, Pageable pageable);
             
	Page<Complaint> findByEmployeeAndStatus(Employee employee,String status,Pageable pageable);
	
	
	Page<Complaint>  findByEmployee(Employee employee,Pageable pageable);

	
	 boolean existsByComplaintIdAndDepartmentId(int complaintId, Department departmentId);



}  
