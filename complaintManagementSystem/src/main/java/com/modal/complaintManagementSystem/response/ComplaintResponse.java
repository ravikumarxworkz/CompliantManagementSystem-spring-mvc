package com.modal.complaintManagementSystem.response;

import java.util.List;
import java.util.Objects;

import com.modal.complaintManagementSystem.entity.Complaint;

import lombok.Data;

@Data
public class ComplaintResponse {
	private long totalComplaints;
	private long inProgressComplaints;
	private long closedComplaints;
	private long pendingComplaints;
	private List<Complaint> complaints;
	

	public long getTotalComplaints() {
		return totalComplaints;
	}

	public ComplaintResponse() {
		// TODO Auto-generated constructor stub
	}

	public void setTotalComplaints(long totalComplaints) {
		this.totalComplaints = totalComplaints;
	}

	public long getInProgressComplaints() {
		return inProgressComplaints;
	}

	public void setInProgressComplaints(long inProgressComplaints) {
		this.inProgressComplaints = inProgressComplaints;
	}

	public long getClosedComplaints() {
		return closedComplaints;
	}

	public void setClosedComplaints(long closedComplaints) {
		this.closedComplaints = closedComplaints;
	}

	public List<Complaint> getComplaints() {
		return complaints;
	}

	public void setComplaints(List<Complaint> complaints) {
		this.complaints = complaints;
	}

	@Override
	public String toString() {
		return "ComplaintResponse [totalComplaints=" + totalComplaints + ", inProgressComplaints="
				+ inProgressComplaints + ", closedComplaints=" + closedComplaints + ", complaints=" + complaints + "]";
	}

	@Override
	public int hashCode() {
		return Objects.hash(closedComplaints, complaints, inProgressComplaints, totalComplaints);
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!(obj instanceof ComplaintResponse))
			return false;
		ComplaintResponse other = (ComplaintResponse) obj;
		return closedComplaints == other.closedComplaints && Objects.equals(complaints, other.complaints)
				&& inProgressComplaints == other.inProgressComplaints && totalComplaints == other.totalComplaints;
	}

}
