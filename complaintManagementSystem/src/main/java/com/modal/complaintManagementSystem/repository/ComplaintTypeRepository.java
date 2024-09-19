package com.modal.complaintManagementSystem.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.modal.complaintManagementSystem.entity.ComplaintType;

@Repository
public interface ComplaintTypeRepository extends JpaRepository<ComplaintType, Integer> {

}
