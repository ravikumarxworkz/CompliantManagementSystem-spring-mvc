package com.modal.complaintManagementSystem.entity;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "email_validation")
public class EmailValidationEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "validation_emailId")
    private String email;

    @Column(name = "validation_OTP")
    private String otp;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    // Constructors, getters, setters
    // PrePersist method for createdAt initialization

    public EmailValidationEntity() {
        // Default constructor
    }

    public EmailValidationEntity(String email, String otp) {
        this.email = email;
        this.otp = otp;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getOtp() {
        return otp;
    }

    public void setOtp(String otp) {
        this.otp = otp;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
}
