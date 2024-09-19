package com.modal.complaintManagementSystem.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.modal.complaintManagementSystem.entity.ContactUs;

@Repository
public interface ContactUsRepository extends JpaRepository<ContactUs, Long> {

}
