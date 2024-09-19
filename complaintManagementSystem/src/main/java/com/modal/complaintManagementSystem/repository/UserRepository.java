package com.modal.complaintManagementSystem.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.modal.complaintManagementSystem.entity.UserEntity;

@Repository
public interface UserRepository extends JpaRepository<UserEntity, Integer> {

	UserEntity findByEmail(String email);

	boolean existsByEmail(String email);

	boolean existsByContactNumber(long contactNumber);
	
	 Page<UserEntity> findByEmailContainingIgnoreCase(String email, Pageable pageable);
	
	 

}
