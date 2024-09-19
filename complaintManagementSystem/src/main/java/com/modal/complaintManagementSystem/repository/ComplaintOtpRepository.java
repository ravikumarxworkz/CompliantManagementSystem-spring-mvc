package com.modal.complaintManagementSystem.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.modal.complaintManagementSystem.entity.ComplaintOtp;

@Repository
public interface ComplaintOtpRepository extends JpaRepository<ComplaintOtp, Integer> {

	Optional<ComplaintOtp> findFirstByComplaintIdOrderByCreatedTimestampDesc(int complaintId);

}
