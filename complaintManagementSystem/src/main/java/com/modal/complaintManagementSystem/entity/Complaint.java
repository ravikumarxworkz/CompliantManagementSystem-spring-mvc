package com.modal.complaintManagementSystem.entity;

import java.time.LocalDateTime;
import java.util.Objects;

import javax.persistence.*;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Getter
@Setter
@ToString
@Table(name = "complaint")
public class Complaint {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "complaint_id")
	private int complaintId;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "user_id", nullable = false)
	//@JsonBackReference
	private UserEntity user;

	@Column(nullable = false)
	private String complaintType;

	@Column(nullable = false)
	private String country;

	@Column(nullable = false)
	private String state;

	@Column(nullable = false)
	private String city;

	@Column(name = "city_area", nullable = false)
	private String cityArea;

	@Column(name = "complaint_address", nullable = false)
	private String complaintAddress;

	@Column(name = "complaint_details", nullable = false)
	private String complaintDetails;

	@Column(name = "status")
	private String status;

	@Column(name = "created_at")
	private LocalDateTime createdAt;

	@Column(name = "updated_at")
	private LocalDateTime updatedAt;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "department_id", foreignKey = @ForeignKey(name = "fk_department"))
	//@JsonBackReference
	private Department departmentId;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "employee_id", foreignKey = @ForeignKey(name = "fk_employee"))
	//@JsonBackReference
	private Employee employee;
	
	@Column(name = "complaint_comment")
	private String complaintComment;

	@PrePersist
	protected void onCreate() {
		createdAt = LocalDateTime.now();
	}

	@PreUpdate
	protected void onUpdate() {
		updatedAt = LocalDateTime.now();
	}

	@Override
	public int hashCode() {
		return Objects.hash(complaintId);
	}

	@Override
	public boolean equals(Object o) {
		if (this == o)
			return true;
		if (o == null || getClass() != o.getClass())
			return false;
		Complaint that = (Complaint) o;
		return Objects.equals(complaintId, that.complaintId);
	}

}
