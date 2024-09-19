package com.modal.complaintManagementSystem.entity;

import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "user_details")
public class UserEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int userId;
    private String firstName;
    private String lastName;
    private String email;
    private long contactNumber;
    private long alterContactNumber;
    private String address;
    private boolean agreement;
    private String imagePath;
    private String password;
//    private Timestamp createdAt;
//    private Timestamp updatedAt;
    private LocalDateTime createdAt;
 	private LocalDateTime updatedAt;

}
