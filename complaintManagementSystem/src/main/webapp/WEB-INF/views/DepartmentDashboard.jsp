<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page session="true"%>
<%
// Prevent caching
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<c:if
	test="${empty sessionScope.loggedInUserEmail || empty sessionScope.loggedInUserDepartmentId}">
	<c:redirect url="departmentLoginPage.jsp" />
</c:if>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ResolveX-Department</title>
<link rel="shortcut icon"
	href="/complaintManagementSystem/res/title icon.png"
	type="image/x-icon">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #F7CAC9;
}

.sidebar {
	height: 100vh;
	position: fixed;
	top: 0;
	left: 0;
	width: 220px;
	background-color: #f8f9fa;
	overflow-y: auto;
	box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease;
}

.main-content {
	margin-left: 220px;
	padding: 20px;
}

.card {
	margin-bottom: 10px;
}

.profile-icon {
	display: flex;
	align-items: center;
	justify-content: center;
	position: absolute;
	top: 20px;
	background-color: #FF3366;
	border-radius: 50%;
	color: #fff;
	cursor: pointer;
}

.search-bar {
	display: flex;
	align-items: center;
	border-radius: 20px;
	background-color: #FAF0CA;
	padding: 10px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.options-dropdown {
	margin-right: 10px;
}

#search-options {
	background-color: #F4D35E;
	border: none;
	padding: 8px 12px;
	border-radius: 15px;
	font-size: 14px;
	color: #0D3B66;
	cursor: pointer;
}

#search-input {
	flex-grow: 1;
	background-color: #F4D35E;
	border: none;
	padding: 8px 12px;
	border-radius: 15px;
	font-size: 14px;
	color: #0D3B66;
}

#search-button {
	background-color: #EE964B;
	border: none;
	padding: 8px 12px;
	border-radius: 15px;
	cursor: pointer;
}

#search-button img {
	width: 20px;
	height: 20px;
}

#adminName {
	margin-left: 10px;
	color: blue;
}

.d-none {
	display: none;
}

.round-image {
	width: 120px;
	height: 100px;
	border-radius: 50%;
	overflow: hidden;
	display: inline-block;
	border: 2px solid #ccc;
}

.round-image img {
	width: 100%;
	height: 100%;
	object-fit: cover;
}

#newPhoto {
	display: none;
	margin-top: 10px;
}


#viewComplaintModal .modal-dialog {
  max-width: 800px;
}

#viewComplaintModal .form-group {
  margin-bottom: 1rem;
}

#viewComplaintModal .btn-close {
  background-color: #f5f5f5;
  border: none;
  cursor: pointer;
}

#viewComplaintModal #otpSection .form-control {
  margin-top: 0.5rem;
}

#viewComplaintModal #countdownTimer {
  font-weight: bold;
  color: #007bff;
}

#viewComplaintModal .modal-footer .btn {
  margin-right: 10px;
}
#complaintsTable.dropdown-item:hover {
	background-color: #f8f9fa; /* Light grey background on hover */
	color: #343a40; /* Dark text color on hover */
}

#complaintsTable thead {
	background-color: #17a2b8; /* Bootstrap info color */
	color: #ffffff; /* White text color */
}

#complaintsTable thead th {
	text-align: center;
	padding: 12px;
}

#complaintsTable tbody tr:nth-child(even) {
	background-color: #f2f2f2; /* Light grey for alternate rows */
}

#complaintsTable tbody tr:hover {
	background-color: #e9ecef; /* Slightly darker grey on hover */
}

#complaintsTable .spinner-border {
	color: #17a2b8; /* Match the loading spinner color with header */
}
.search-complaint-input {
    border: none;
    border-bottom: 2px solid #17a2b8;
    border-radius: 0;
    box-shadow: none;
    outline: none;
    padding: 10px 5px;
    transition: border-color 0.3s ease;
}

/* Add a hover effect for modern interaction */
.search-complaint-input:hover, 
.search-complaint-input:focus {
    border-bottom: 2px solid #138496; /* Darker shade for focus/hover */
}

</style>
</head>

<body>
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-2 sidebar bg-dark" style="height: 100vh;">
				<div class="d-flex align-items-center mb-3">
					<img width="64" height="64"
						src="https://img.icons8.com/arcade/64/administrator-male.png"
						alt="administrator-male" class="rounded-circle me-2" />
					<h5 class="mb-0" id="adminName">Hi Dept</h5>
				</div>

				<ul class="nav flex-column">
					<li class="nav-item"><a class="nav-link active"
						href="#dashboard">DashBoard</a></li>
					<li class="nav-item"><a class="nav-link" href="#employees">Employees</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="#complaints">Complaints</a>
					</li>
				</ul>
			</div>
			<div class="col-md-10 main-content">
				<div class="d-flex justify-content-between align-items-center mb-3">
					<!-- Company Logo and Name -->
					<div class="d-flex align-items-center">
						<img src="/complaintManagementSystem/res/title icon.png"
							alt="Company Logo" style="width: 50px; height: 50px;"
							class="me-3">
						<h5 class="mb-0">ResolveX Department</h5>
						<!-- Adjust the name as per your company -->
					</div>

					<!-- Search Bar and User Profile -->
					<!-- <div class="d-flex align-items-center w-75 justify-content-center"> -->
						<div class="search-bar d-flex align-items-center w-50 justify-content-center">
							<select id="search-options" class="form-select me-2">
								<option value="">Search Options</option>
								<option value="complaint">Complaint</option>
								<option value="employee">Employee</option>
							</select> <input type="text" id="search-input" class="form-control me-2"
								placeholder="Enter Search Query">
							<button id="search-button" class="btn btn-primary">
								<i class="fa-solid fa-search"></i>
							</button>
						</div>

						<!-- User Profile Dropdown -->
						<div class="dropdown">
							<button class="btn btn-secondary dropdown-toggle" type="button"
								id="dropdownMenuButton1" data-bs-toggle="dropdown"
								aria-expanded="false">
								<i class="bi bi-person-circle"></i>
							</button>
							<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
								<li><a class="dropdown-item" href="#">Profile</a></li>
								<li><a class="dropdown-item"
									href="/complaintManagementSystem/departmentAdminLogOut">Logout</a></li>
							</ul>
						</div>
					<!--</div>  -->
				</div>

				<div id="dashboardSection" class="dashboard">
					<div class="row">
						<div class="col-md-3">
							<div class="card bg-primary text-dark">
								<div class="card-body">
									<h5 class="card-title">Total Employees</h5>
									<p class="card-text" id="dashboardTotalEmployeesOfDepartment">0</p>
								</div>
							</div>
						</div>
						<div class="col-md-3">
							<div class="card  text-dark" style="background-color: #FF3366;">
								<div class="card-body">
									<h5 class="card-title">Total Complaints</h5>
									<p class="card-text" id="dashboardTotalComplaintsOfDepartment">0</p>
								</div>
							</div>
						</div>
						<div class="col-md-3">
							<div class="card  text-dark" style="background-color: #2EC4B6;">
								<div class="card-body">
									<h5 class="card-title">Pending Complaints</h5>
									<p class="card-text"
										id="dashboardPendingComplaintsOfDepartment">0</p>
								</div>
							</div>
						</div>
						<div class="col-md-3">
							<div class="card  text-dark" style="background-color: #FFD166;">
								<div class="card-body">
									<h5 class="card-title">Closed Complaints</h5>
									<p class="card-text" id="dashboardClosedComplaintsOfDepartment">0</p>
								</div>
							</div>
						</div>
					</div>
					<div class="complaintChart">
						<div class="row mt-4">
							<div class="col-md-12">
								<canvas id="complaintAnalysisChart"></canvas>
							</div>
						</div>
					</div>
				</div>
				<div id="employeesSection" class="Employees d-none">
					<div class="row mt-4">
						<div class="col-md-12">
							<div class="card bg-light text-dark">
								<div class="card-body">
									<h5 class="card-title">Employees</h5>

									<!-- Create Employee Button -->
									<a class="btn btn-primary mb-3" id="createEmployeeBtn"
										data-bs-toggle="modal" data-bs-target="#createEmployeeModal"
										role="button"> <i class="fas fa-plus-circle"></i> Create
										Employee
									</a>

									<!-- Search Bar -->
									<input type="text" class="form-control mt-2"
										placeholder="Search Employees by Email" id="employeeSearch"
										onkeyup="fetchEmployees(1)">

									<!-- Employees Table -->
									<table class="table table-striped mt-2">
										<thead>
											<tr>
												<th>#</th>
												<th>Name</th>
												<th>Email</th>
												<th>Phone</th>
												<th>Status</th>
												<th>Actions</th>
											</tr>
										</thead>
										<tbody id="employeeTableBody"></tbody>
									</table>
									<nav aria-label="Page navigation">
										<ul class="pagination justify-content-center"
											id="employeePagination">
											<li class="page-item"><a class="page-link" href="#"
												onclick="prevPage()">Previous</a></li>
											<li class="page-item"><a class="page-link" href="#"
												onclick="nextPage()">Next</a></li>
										</ul>
									</nav>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- Create Employee Modal -->
				<div class="modal fade" id="createEmployeeModal" tabindex="-1"
					role="dialog" aria-labelledby="createEmployeeModalLabel"
					aria-hidden="true">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="createEmployeeModalLabel">
									<i class="fas fa-user-plus"></i> Create Employee
								</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<form id="createEmployeeForm" method="POST">
									<div class="row">
										<div class="col-6">
											<label for="employeeName" class="form-label"><i
												class="fas fa-user"></i> Name</label> <input type="text"
												class="form-control" id="employeeName" name="employeeName"
												required>
										</div>
										<div class="col-6">
											<label for="employeeEmail" class="form-label"><i
												class="fas fa-envelope"></i> Email</label> <input type="email"
												class="form-control" id="employeeEmail" name="employeeEmail"
												required>
										</div>
									</div>
									<div class="row">
										<div class="col-6">
											<label for="employeePassword" class="form-label"><i
												class="fas fa-lock"></i> Password</label> <input type="password"
												class="form-control" id="employeePassword"
												name="employeePassword" required>
										</div>
										<div class="col-6">
											<label for="employeeContactNumber" class="form-label"><i
												class="fas fa-phone"></i> Contact Number</label> <input type="text"
												class="form-control" id="employeeContactNumber"
												name="employeeContactNumber" required>
										</div>
									</div>
									<div class="text-center mt-3">
										<button type="submit" class="btn btn-primary">
											<i class="fas fa-save"></i> Create
										</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<div id="viewEmployeeModal" class="modal fade" tabindex="-1"
					role="dialog">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="viewEmployeeModalLabel">Employee
									Details</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div class="row">
									<div class="col-md-6">
										<!-- Left column with employee details -->
										<p>
											<i class="fas fa-id-badge"></i> <strong>Employee ID:</strong>
											<span id="employeeIdDetail"></span>
										</p>
										<p>
											<i class="fas fa-user"></i> <strong>Name:</strong> <span
												id="employeeNameDetail"></span>
										</p>
										<p>
											<i class="fas fa-envelope"></i> <strong>Email:</strong> <span
												id="employeeEmailDetail"></span>
										</p>
										<p>
											<i class="fas fa-phone"></i> <strong>Contact Number:</strong>
											<span id="employeeContactNumberDetail"></span>
										</p>
									</div>
									<div class="col-md-6 text-center">
										<!-- Right column with employee image -->
										<img id="employeeImageDetail" src="" alt="Employee Image"
											class="img-fluid rounded-circle"
											style="width: 150px; height: 150px;">
									</div>
								</div>
								<div class="row mt-3">
									<div class="col-md-6">
										<!-- Active/Inactive toggle -->
										<p>
											<i class="fas fa-toggle-on"></i> <strong>Status:</strong>
										</p>
										<div class="form-group">
											<select id="employeeStatusDetail" class="form-control">
												<option value="Active">Active</option>
												<option value="Inactive">Inactive</option>
											</select>
										</div>
									</div>
								</div>
							</div>
							<div class="modal-footer">
								<!-- Submit and Close Buttons -->
								<button type="button" class="btn btn-primary"
									onclick="updateEmployeeStatus()">
									<i class="fas fa-check"></i> Submit
								</button>
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
				<!-- Delete Employee Confirmation Modal -->
				<!-- Delete Confirmation Modal -->
				<div class="modal fade" id="deleteEmployeeModal" tabindex="-1"
					aria-labelledby="deleteEmployeeModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="deleteEmployeeModalLabel">Confirm
									Delete</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<p>
									Are you sure you want to delete this employee with ID: <span
										id="deleteEmployeeIdDisplay"></span>?
								</p>
								<input type="hidden" id="deleteEmployeeId">
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-danger"
									id="confirmDeleteEmployee">Yes, Delete</button>
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">Cancel</button>
							</div>
						</div>
					</div>
				</div>
				<!--=========complaints  Section  ------------------------------------>
				<div id="complaintsSection" class="Complaints d-none">
					<div class="row mt-4">
						<div class="col-md-12">
							<div class="card bg-light text-dark">
								<div class="card-body">
									<h5 class="card-title">Complaints</h5>

									<!-- Dropdown for filtering complaints -->
									<div class="d-flex justify-content-start mb-3">
									<div class="dropdown mb-3">
										<button class="btn btn-info dropdown-toggle"
											type="button" id="dropdownMenuButton"
											data-bs-toggle="dropdown" aria-haspopup="true"
											aria-expanded="false"><i class="fas fa-filter"></i> Filter by Status</button>
										<div class="dropdown-menu"
											aria-labelledby="dropdownMenuButton">
											<a class="dropdown-item text-primary" href="#"
												onclick="filterComplaints('all')"><i class="fas fa-list"></i> All Complaints</a> <a
												class="dropdown-item text-success" href="#"
												onclick="filterComplaints('Pending')"><i class="fas fa-plus-circle"></i>New Complaints</a> <a
												class="dropdown-item text-info" href="#"
												onclick="filterComplaints('In Progress')"><i class="fas fa-spinner"></i> In Progress
												Complaints</a> <a class="dropdown-item text-danger" href="#"
												onclick="filterComplaints('Closed')"><i class="fas fa-check-circle"></i>Closed Complaints</a>
										</div>
									</div>

									<!-- Search Input -->
									<input type="text"
										class="form-control w-50 search-complaint-input"
										placeholder="Search Complaint by Complaint Type"
										id="SearchComplaint" onkeyup="searchComplaints()">
                                        </div>

									<!-- Table -->
									<div class="table-responsive">
										<table id="complaintsTable" class="table table-striped mt-2">
											<thead class="table-primary">
												<tr>
													<th scope="col">Complaint ID</th>
													<th scope="col">Complaint Type</th>
													<th scope="col">Status</th>
													<th scope="col">User</th>
													<th scope="col">Employee</th>
													<th scope="col">Action</th>
												</tr>
											</thead>
											<tbody id="complaintsTableBody">
												<!-- Loading indicator -->
												<tr id="loadingIndicator">
													<td colspan="5" class="text-center"><span
														class="spinner-border spinner-border-sm" role="status"
														aria-hidden="true"></span> Loading...</td>
												</tr>
											</tbody>
										</table>
									</div>

									<!-- Pagination and Page Size Selector -->
									<div class="d-flex justify-content-between">
										<div>
											<label for="pageSizeSelector">Items per page:</label> <select
												id="pageSizeSelector" class="form-select"
												style="width: auto;" onchange="updatePageSize(this.value)">
												<option value="5">5</option>
												<option value="10" selected>10</option>
												<option value="15">15</option>
												<option value="20">20</option>
											</select>
										</div>
										<nav aria-label="Page navigation">
											<ul class="pagination justify-content-center"
												id="complintPagination">
												<li class="page-item"><a class="page-link" href="#"
													onclick="prevPageComplaints()">Previous</a></li>
												<li class="page-item"><a class="page-link" href="#"
													onclick="nextPageComplaints()">Next</a></li>
											</ul>
										</nav>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- Complaint Details Modal -->
				<!-- Complaint Details Modal -->
				<div id="viewComplaintModal" class="modal fade" tabindex="-1"
					role="dialog" data-backdrop="static">
					<div class="modal-dialog modal-lg" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="modalTitle">Complaint Details</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<!-- Complaint details form -->
								<form id="complaintDetailsForm">
									<div class="row">
										<div class="col-md-6 form-group">
											<i class="fas fa-clipboard-list form-icon"></i> <label
												for="complaintId" class="form-label">Complaint ID</label> <input
												type="text" class="form-control" id="complaintId" readonly>
										</div>
										<div class="col-md-6 form-group">
											<i class="fas fa-building form-icon"></i> <label
												for="complaintType" class="form-label">Complaint
												Type</label> <input type="text" class="form-control"
												id="complaintType" readonly>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6 form-group">
											<i class="fas fa-globe form-icon"></i> <label for="country"
												class="form-label">Country</label> <input type="text"
												class="form-control" id="country" readonly>
										</div>
										<div class="col-md-6 form-group">
											<i class="fas fa-map-marker-alt form-icon"></i> <label
												for="state" class="form-label">State</label> <input
												type="text" class="form-control" id="state" readonly>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6 form-group">
											<i class="fas fa-city form-icon"></i> <label for="city"
												class="form-label">City</label> <input type="text"
												class="form-control" id="city" readonly>
										</div>
										<div class="col-md-6 form-group">
											<i class="fas fa-building form-icon"></i> <label
												for="cityArea" class="form-label">City Area</label> <input
												type="text" class="form-control" id="cityArea" readonly>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6 form-group">
											<i class="fas fa-map form-icon"></i> <label
												for="complaintAddress" class="form-label">Complaint
												Address</label> <input type="text" class="form-control"
												id="complaintAddress" readonly>
										</div>
										<div class="col-md-6 form-group">
											<i class="fas fa-info-circle form-icon"></i> <label
												for="complaintDetails" class="form-label">Complaint
												Details</label>
											<textarea class="form-control" id="complaintDetails" rows="3"
												readonly></textarea>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6 form-group">
											<i class="fas fa-calendar-day form-icon"></i> <label
												for="createdAt" class="form-label">Created At</label> <input
												type="text" class="form-control" id="createdAt" readonly>
										</div>
										<div class="col-md-6 form-group">
											<i class="fas fa-calendar-check form-icon"></i> <label
												for="updatedAt" class="form-label">Updated At</label> <input
												type="text" class="form-control" id="updatedAt" readonly>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6 form-group">
											<i class="fas fa-tag form-icon"></i> <label for="status"
												class="form-label">Status</label> <select id="status"
												class="form-control" onchange="handleStatusChange()">
												<option value="In Progress">In Progress</option>
												<option value="Closed">Closed</option>
												<option value="Not Resolved">Not Resolved</option>
											</select>
										</div>
										<div class="col-md-6 form-group">
											<i class="fas fa-user"></i> <label for="assignEmployee">Assign
												Employee</label> <select id="assignEmployee" class="form-control">
												<option value="">Select Employee</option>
												<!-- Dynamically load employees -->
											</select>
										</div>
									</div>

									<!-- Comments Section -->
									<div class="row" id="commentSection" style="display: none;">
										<div class="col-md-12 form-group">
											<label for="statusComments">Comments</label>
											<textarea class="form-control" id="statusComments" rows="2"
												style="resize: none;" placeholder="Add your comments here"></textarea>
										</div>
									</div>
									<!-- OTP Section -->
									<!-- OTP Section -->
									<div class="row mt-3" id="otpSection" style="display: none;">
										<div class="col-md-6 form-group">
											<button type="button" class="btn btn-primary btn-sm"
												id="sendOtpButton" onclick="sendOtp()">
												<i class="fas fa-paper-plane"></i> Send OTP
											</button>
											<div id="countdownTimer" class="mt-2"></div>
											<div id="otpSent" style="display: none; color: green;"
												class="mt-2">
												<i class="fas fa-check-circle"></i> OTP sent successfully!
											</div>
										</div>
										<div class="col-md-6 form-group">
											<input type="text" class="form-control form-control-sm mt-2"
												id="otp" placeholder="Enter OTP" style="display: none;">
											<span id="otpError" style="color: red; display: none;"
												class="mt-2"> <i class="fas fa-exclamation-circle"></i>
												Invalid OTP. Please try again.
											</span>
											<button type="button" class="btn btn-primary mt-2"
												id="verifyOtpButton" style="display: none;"
												onclick="verifyOtp()">
												<i class="fas fa-check"></i> Verify OTP
											</button>
										</div>
									</div>
								</form>

								<div id="verifyOtp" style="display: none; text-align: center;">
									<span style="color: green;"><i
										class="fas fa-check-circle"></i> OTP verified successfully!</span>
								</div>
							</div>
							<div class="modal-footer">
								<button id="submitAssignment" type="button"
									class="btn btn-primary" onclick="saveAssignment()">Submit</button>
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>

				<!-- User Details Modal -->
				<!-- User Details Modal -->
				<div id="userDetailsModal" class="modal fade" tabindex="-1"
					role="dialog">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">User Details</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div id="userDetailsContent">
									<p>
										<i class="fas fa-user-id-badge"></i> <strong>User ID:</strong>
										<span id="userIdDetail"></span>
									</p>
									<p>
										<i class="fas fa-user"></i> <strong>Name:</strong> <span
											id="userNameDetail"></span>
									</p>
									<p>
										<i class="fas fa-envelope"></i> <strong>Email:</strong> <span
											id="userEmailDetail"></span>
									</p>
									<p>
										<i class="fas fa-phone"></i> <strong>Contact Number:</strong>
										<span id="userContactNumberDetail"></span>
									</p>
									<p>
										<i class="fas fa-address-card"></i> <strong>Contact
											Number:</strong> <span id="userAddressDetail"></span>
									</p>
									<!-- User details will be dynamically inserted here -->
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
				<!-- Success Modal -->
				<div class="modal fade" id="successModal" tabindex="-1"
					aria-labelledby="successModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="successModalLabel">Success</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body" id="successMessage">
								<!-- Success message will be displayed here -->
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">OK</button>
							</div>
						</div>
					</div>
				</div>

				<!-- Error Modal -->
				<div class="modal fade" id="errorModal" tabindex="-1"
					aria-labelledby="errorModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="errorModalLabel">Error</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body" id="errorMessage">
								<!-- Error message will be displayed here -->
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
				<!-- Modal -->
				<div class="modal fade" id="searchResultsModal" tabindex="-1"
					aria-labelledby="searchResultsModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="searchResultsModalLabel">Search
									Results</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body" id="modalBodyContent">
								<!-- Search results will be dynamically inserted here -->
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>

</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const dashboardLink = document.querySelector('a[href="#dashboard"]');
        const employeesLink = document.querySelector('a[href="#employees"]');
        const complaintsLink = document.querySelector('a[href="#complaints"]');
        const dashboardSection = document.getElementById('dashboardSection');
        const employeesSection = document.getElementById('employeesSection');
        const complaintsSection = document.getElementById('complaintsSection');
        function showSection(sectionToShow) {
            dashboardSection.classList.add('d-none');
            employeesSection.classList.add('d-none');
            complaintsSection.classList.add('d-none');
            sectionToShow.classList.remove('d-none');
        }
        dashboardLink.addEventListener('click', function () {
            showSection(dashboardSection);
            updateDashboard();
            
        });

        employeesLink.addEventListener('click', function () {
            showSection(employeesSection);
            fetchEmployees(1);
        });

        complaintsLink.addEventListener('click', function () {
            showSection(complaintsSection);
            fetchComplaints();
        });
        showSection(dashboardSection);
    });
</script>
<!-- to fetch DashBoard details   and Declare a global chart variable so it can be updated later  -->
<script>
let chart;

function updateDashboard() {
    var departmentId = '${sessionScope.loggedInUserDepartmentId}'; // Fetching department ID from session

    $.ajax({
        url: '/complaintManagementSystem/department/departmentDashboardData',
        type: 'GET',
        data: { departmentId: departmentId },
        dataType: "json",
        success: function(response) {
            $('#dashboardTotalComplaintsOfDepartment').text(response.totalComplaints);
            $('#dashboardNewComplaintsOfDepartment').text(response.newComplaints);
            $('#dashboardPendingComplaintsOfDepartment').text(response.pendingComplaints);
            $('#dashboardClosedComplaintsOfDepartment').text(response.closedComplaints);
            $('#dashboardTotalEmployeesOfDepartment').text(response.totalEmployees);

            updateChart(response);
        },
        error: function(xhr, status, error) {
            console.error('Error fetching dashboard data:', error);
        }
    });
}

function updateChart(data) {
    let chartData = [data.totalComplaints, data.pendingComplaints, data.closedComplaints];

    if (!chart) {
        let ctx = document.getElementById('complaintAnalysisChart').getContext('2d');
        chart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: ['Total', 'Pending', 'Closed'],
                datasets: [{
                    label: 'Complaints',
                    data: chartData,
                    backgroundColor: ['#FF3366', '#2EC4B6', '#FFD166'],
                    borderColor: ['#FF3366', '#2EC4B6', '#FFD166'],
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    } else {
        chart.data.datasets[0].data = chartData;
        chart.update();
    }
}

function initDashboard() {
    updateDashboard();
    setInterval(updateDashboard, 30000); // Refresh every 30 seconds
}

$(document).ready(function() {
    initDashboard();
});

</script>
<!-------------------------------------- complaint section page code -------------------------------------->
<script type="text/javascript">

let currentPageComplaints = 1;
const pageSizeComplaints = 10;

function fetchComplaints(page = currentPageComplaints, status = 'all', query='') {
    const departmentId = '${sessionScope.loggedInUserDepartmentId}';
    
    $.ajax({
        url: '/complaintManagementSystem/getAllComplaintsByDepartmentId',
        type: 'GET',
        data: {
            departmentId: departmentId,
            page: page,
            size: pageSizeComplaints,
            query: query,
            status: status
        },
        dataType: 'json',
        success: function(response) {
            populateComplaintTable(response.complaints);
            updateComplaintPagination(response.totalPages, page);
        },
        error: function(xhr, status, error) {
            console.error('Error fetching complaints:', error);
        }
    });
}

function searchComplaints() {
    const searchQuery = $('#SearchComplaint').val();
    console.log(searchQuery);
    fetchComplaints(1, getCurrentStatus(), searchQuery);
}

function filterComplaints(status) {
    currentPageComplaints = 1;
    const searchQuery = $('#SearchComplaint').val();
    fetchComplaints(currentPageComplaints, status,searchQuery);
}

function getCurrentStatus() {
    const status = $('button[aria-expanded="true"]').text().trim();
    return status || 'all';
}

$(document).ready(function () {
    fetchComplaints(currentPageComplaints);
    $('#SearchComplaint').on('keyup', function () {
        searchComplaints();
    });
});
function populateComplaintTable(complaints) {
    const tableBody = $('#complaintsTableBody');
    tableBody.empty();
    
    if (complaints && complaints.length > 0) {
        complaints.forEach((complaint) => {
            var row = '<tr>' +
                '<td>' + complaint.complaintId + '</td>' +
                '<td>' + complaint.complaintType + '</td>' +
                '<td>' + complaint.status + '</td>' +
                '<td>' +
                '<button class="btn btn-primary view-user" data-user-id="' + complaint.userId + '"><i class="fas fa-user"></i> View User</button>' +
                '</td>' +
                '<td>' +
                (complaint.employeeId ? 
                    '<button class="btn btn-info view-employee" data-employee-id="' + complaint.employeeId + '"><i class="fas fa-briefcase"></i> View Employee</button>' : 
                    'Not Assigned') +
                '</td>' +
                '<td>' +
                '<button class="btn btn-warning view-complaint" data-id="' + complaint.complaintId + '"><i class="fas fa-eye"></i> View Complaint</button>' +
                '</td>' +
                '</tr>';
            tableBody.append(row);
        });
    } else {
        tableBody.html('<tr><td colspan="6" class="text-center">No complaints found for this user.</td></tr>');
    }
    
    $('#complaintsTable').on('click', '.view-complaint', function () {
        let complaintId = $(this).data('id');
        viewComplaint(complaintId); 
    });

    $('#complaintsTable').on('click', '.view-user', function () {
        let userId = $(this).data('user-id');
        loadUserDetails(userId);
    });

    $('#complaintsTable').on('click', '.view-employee', function () {
        let employeeId = $(this).data('employee-id');
        viewEmployee(employeeId); 
    });
}



function updateComplaintPagination(totalPages, currentPage) {
    
    const paginationContainer = $('#complintPagination');
    paginationContainer.empty(); 

    paginationContainer.append(`<li class="page-item"><a class="page-link" href="#" onclick="prevPageComplaints()">Previous</a></li>`);

    for (let i = 1; i <= totalPages; i++) {
        paginationContainer.append('<li class="page-item"><a class="page-link" href="#" onclick="goToPageComplaints(' + i + ')">' + i + '</a></li>');
    }


    paginationContainer.append(`<li class="page-item"><a class="page-link" href="#" onclick="nextPageComplaints()">Next</a></li>`);
}

function prevPageComplaints() {
    if (currentPageComplaints > 1) {
        currentPageComplaints--;
        fetchComplaints(currentPageComplaints);
    }
}

function nextPageComplaints() {
    currentPageComplaints++;
    fetchComplaints(currentPageComplaints);
}

function goToPageComplaints(page) {
    currentPageComplaints = page;
    fetchComplaints(currentPageComplaints);
}
function updatePageSize(newSize) {
    pageSizeComplaints = newSize;
    fetchComplaints(1);
}
</script>
<!--  this script code belongs to view complaint modal and pop employees and assign employee to complaint -->
<script>
function handleStatusChange() {
    const status = document.getElementById('status').value;
    const otpSection = document.getElementById('otpSection');
    const commentSection = document.getElementById('commentSection');
    const submitButton = document.getElementById('submitAssignment');
    
    if (status === 'Closed' || status === 'Not Resolved') {
        otpSection.style.display = 'block';
        commentSection.style.display = 'block';
        submitButton.disabled = true;
    } else {
        otpSection.style.display = 'none';
        commentSection.style.display = 'none';
        submitButton.disabled = false;
    }
}

function viewComplaint(complaintId) {
    $.ajax({
        url: '/complaintManagementSystem/getComplaintDetailsById',
        method: 'GET',
        dataType: 'json',
        data: { id: complaintId },
        success: function(response) {
        	document.getElementById('complaintId').value = response.complaintId || '';
            document.getElementById('city').value = response.city || '';
            document.getElementById('complaintType').value = response.complaintType || '';
            document.getElementById('country').value = response.country || '';
            document.getElementById('state').value = response.state || '';
            document.getElementById('cityArea').value = response.cityArea || '';
            document.getElementById('complaintAddress').value = response.complaintAddress || '';
            document.getElementById('complaintDetails').value = response.complaintDetails || '';
            
            // Format createdAt and updatedAt as a user-friendly date-time string
            if (Array.isArray(response.createdAt) && response.createdAt.length >= 6) {
                const createdAtDate = new Date(
                		response.createdAt[0], 
                		response.createdAt[1] - 1, // Month is 0-based in JS Date
                		response.createdAt[2],
                		response.createdAt[3],
                		response.createdAt[4],
                		response.createdAt[5]
                );
                document.getElementById('createdAt').value =createdAtDate.toLocaleString() ;
            } else {
            	document.getElementById('createdAt').value ='N/A';
            }

            if (Array.isArray(response.updatedAt) && response.updatedAt.length >= 6) {
                const updatedAtDate = new Date(
                		response.updatedAt[0], 
                		response.updatedAt[1] - 1, 
                		response.updatedAt[2],
                		response.updatedAt[3],
                		response.updatedAt[4],
                		response.updatedAt[5]
                );
                document.getElementById('updatedAt').value =updatedAtDate.toLocaleString() ;
            } else {
            	 document.getElementById('updatedAt').value ='N/A' ;
            }      
            // Populate fields
            document.getElementById('status').value = response.status || '';
            document.getElementById('assignEmployee').value = response.employeeId || '';
            document.getElementById('statusComments').value = response.complaintComment || '';

            const status = response.status;
            const comments = response.complaintComment;

            // Disable fields if status is "Closed" or "Not Resolved" and comments exist
            if ((status === 'Closed' || status === 'Not Resolved') && comments) {
                document.getElementById('status').disabled = true;
                document.getElementById('assignEmployee').disabled = true;
                document.getElementById('statusComments').disabled = true;
                document.getElementById('otpSection').style.display = 'none';
                document.getElementById('commentSection').style.display = 'block';
                document.getElementById('submitAssignment').disabled = true;
            } else {
                document.getElementById('status').disabled = false;
                document.getElementById('assignEmployee').disabled = false;
                document.getElementById('statusComments').disabled = false;
                document.getElementById('submitAssignment').disabled = false;
                handleStatusChange(); // Trigger OTP visibility based on status
            }

            // Show the modal with complaint details
            $('#viewComplaintModal').modal('show');
        },
        error: function(xhr, status, error) {
            console.error("Error fetching complaint details: ", error);
        }
    });
}
let otpSent = false;
let otpVerified = false;
let countdownInterval;

function sendOtp() {
    const complaintId = document.getElementById('complaintId').value;

    $.ajax({
        url: '/complaintManagementSystem/sendComplaintCloseOtp',
        method: 'POST',
        data: { complaintId: complaintId },
        success: function(response) {
            if (response === "otp sent success") {
                otpVerified = false; // Reset OTP verified status
                document.getElementById('sendOtpButton').disabled = true; // Disable the "Send OTP" button
                startCountdown(120);
                document.getElementById('otpSent').style.display = 'inline';
                document.getElementById('otp').style.display = 'inline-block';
                document.getElementById('verifyOtpButton').style.display = 'inline-block';
            } else {
                alert("Failed to send OTP. Please try again.");
            }
        },
        error: function(xhr, status, error) {
            console.error("Error sending OTP: ", error);
            alert("An error occurred while sending OTP.");
        }
    });
}

function startCountdown(seconds) {
    let countdown = seconds;
    const timerElement = document.getElementById('countdownTimer');
    const otpInput = document.getElementById('otp');
    const verifyOtpButton = document.getElementById('verifyOtpButton');
    const sendOtpButton = document.getElementById('sendOtpButton');

    otpInput.style.display = 'block';  // Show OTP input
    verifyOtpButton.style.display = 'block';  // Show Verify button

    countdownInterval = setInterval(function () {
        let minutes = Math.floor(countdown / 60);
        let seconds = countdown % 60;

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        timerElement.textContent = "The OTP will expire in " + minutes + ":" + seconds + ".";

        // Change text color to red during the last 30 seconds
        if (countdown <= 30) {
            timerElement.style.color = 'red';
        } else {
            timerElement.style.color = '';  // Default color
        }

        countdown--;  // Decrement the countdown

        // When countdown is finished
        if (countdown < 0) {
            clearInterval(countdownInterval);  // Stop the countdown
            timerElement.textContent = '';  // Clear the timer display
            otpInput.style.display = 'none';  // Hide OTP input
            verifyOtpButton.style.display = 'none';  // Hide verify button
            document.getElementById('otpSent').style.display = 'none';
            sendOtpButton.disabled = false;  // Enable resend OTP button
        }
    }, 1000);  // Run every second

    sendOtpButton.disabled = true;  // Disable send OTP button while countdown is active
}

function verifyOtp() {
    const timerElement = document.getElementById('countdownTimer');
    const otp = document.getElementById('otp').value;
    const complaintId = document.getElementById('complaintId').value;
    const otpSentMessage = document.getElementById('otpSent');
    const otpError = document.getElementById('otpError');
    const otpInput = document.getElementById('otp');
    const verifyOtpButton = document.getElementById('verifyOtpButton');
    const sendOtpButton = document.getElementById('sendOtpButton');
    const submitAssignmentButton = document.getElementById('submitAssignment');

    $.ajax({
        url: '/complaintManagementSystem/validateOtpAndOfComplaint',
        method: 'POST',
        data: { 
            complaintId: complaintId, 
            otp: otp 
        },
        success: function(response) {
            if (response.success) {
                otpVerified = true;
                otpSentMessage.style.display = 'none';  // Hide OTP sent message
                otpError.style.display = 'none';  // Hide OTP error message
                otpInput.style.display = 'none';  // Hide OTP input
                verifyOtpButton.style.display = 'none';  // Hide Verify button
                document.getElementById('verifyOtp').style.display = 'block';  // Show success message
                submitAssignmentButton.disabled = false;  // Enable the submit button
                sendOtpButton.disabled = true;
                
                // Clear the countdown timer
                if (countdownInterval) {
                    clearInterval(countdownInterval);
                    countdownInterval = null;
                }
                timerElement.textContent = ""; // Clear the timer display
                
            } else {
                otpVerified = false;
                otpError.style.display = 'block';  // Show OTP error message
            }
        },
        error: function(xhr, status, error) {
            otpVerified = false;
            otpError.style.display = 'block';  // Show OTP error message
            alert("An error occurred while verifying OTP.");
        }
    });
}



function saveAssignment() {
    let complaintId = document.getElementById('complaintId').value;
    let assignedEmployeeId = document.getElementById('assignEmployee').value;
    let status = document.getElementById('status').value;
    let comments = document.getElementById('statusComments').value;

    if ((status === 'Closed' || status === 'Not Resolved') && !otpVerified) {
        alert('Please verify OTP before submitting.');
        return;
    }

    if (status === 'Closed' || status === 'Not Resolved') {
        if (!comments.trim()) {  // Check if comments are provided
            alert('Please provide comments before closing or marking as Not Resolved.');
            return;
        }
    }

    if (status !== 'Closed' && status !== 'Not Resolved' && !assignedEmployeeId) {
        alert('Please assign an employee before submitting.');
        return;
    }

    $.ajax({
        url: '/complaintManagementSystem/updateComplaint/' + complaintId,
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            employeeId: assignedEmployeeId,
            status: status,
            comments: comments
        }),
        success: function(response) {
            $('#viewComplaintModal').modal('hide');
            $('#successMessage').text(response);
            $('#successModal').modal('show');
            document.getElementById('verifyOtp').style.display = 'none';
            fetchComplaints();
        },
        error: function(xhr, status, error) {
            if (xhr.status === 400) {
                $('#errorMessage').text(xhr.responseText || 'Error updating employee status.');
                $('#errorModal').modal('show');
            } else if (xhr.status === 500) {
                $('#errorMessage').text(xhr.responseText || 'Server Error.');
                $('#errorModal').modal('show');
            } else {
                $('#errorMessage').text('Error saving assignment');
                $('#errorModal').modal('show');
            }
            console.error('Error saving assignment:', error);
        }
    });
}

</script>

<!--------------------------- this code belongs to employee section  --------------------------->
<Script>
let currentPage = 1;
const pageSize = 10;
function fetchEmployees(page) {
    const searchQuery = $('#employeeSearch').val();
    const departmentId = '${sessionScope.loggedInUserDepartmentId}';
    $.ajax({
        url: '/complaintManagementSystem/employee/getSortedEmployees',
        type: 'GET',
        data: {
            page: page,
            size: pageSize,
            query: searchQuery,
            departmentId: departmentId
        },
        dataType: 'json',
        success: function (response) {
            populateEmployeeTable(response.employees);
            updatePagination(response.totalPages, page);
        },
        error: function (xhr) {
            console.error('Error fetching employees:', xhr);
        }
    });
}
function populateEmployeeTable(employees) {
    const tableBody = $('#employeeTableBody');
    tableBody.empty();

    if (employees.length === 0) {
        tableBody.append('<tr><td colspan="6" class="text-center">No employees found.</td></tr>');
        return;
    }

    employees.forEach((employee) => {
        var row = '<tr>' +
            '<td>' + employee.employeeId + '</td>' +
            '<td>' + employee.employeeName + '</td>' +
            '<td>' + employee.employeeEmail + '</td>' +
            '<td>' + employee.employeeContactNumber + '</td>' +
            '<td>' + employee.employeeStatus+ '</td>' +
            '<td>' +
            '<button class="btn btn-info view-employee" data-id="' + employee.employeeId + '"><i class="fas fa-eye"></i> View</button>' +
            '<button class="btn btn-danger delete-employee" data-id="' + employee.employeeId + '"><i class="fas fa-trash-alt"></i></button>' +
            '</td>' +
            '</tr>';
        tableBody.append(row);
        
        $('.view-employee').click(function() {
            const employeeId = $(this).data('id');
            viewEmployee(employeeId);
        });
        $('.delete-employee').click(function() {
            const employeeId = $(this).data('id');
            $('#deleteEmployeeIdDisplay').text(employeeId); 
            $('#deleteEmployeeId').val(employeeId);
            $('#deleteEmployeeModal').modal('show'); 
        });
        
    });
}
function updatePagination(totalPages) {
    const pagination = $('#pagination');
    pagination.empty();

    if (totalPages <= 1) return;

    pagination.append(`<li class="page-item"><a class="page-link" href="#" onclick="prevPage()">Previous</a></li>`);

    for (let i = 1; i <= totalPages; i++) {
        const activeClass = (i == currentPage) ? 'active' : '';
        pagination.append('<li class="page-item ' + activeClass + '"><a class="page-link" href="#" onclick="goToPage(' + i + ')">' + i + '</a></li>');
    }

    pagination.append(`<li class="page-item"><a class="page-link" href="#" onclick="nextPage()">Next</a></li>`);
}

function viewEmployee(employeeId) {
    $.ajax({
        url: '/complaintManagementSystem/employee/getEmployeeById',
        method: 'GET',
        data: { employeeId: employeeId },
        success: function(employee) {
            $('#employeeIdDetail').text(employee.employeeId);
            $('#employeeNameDetail').text(employee.employeeName);
            $('#employeeEmailDetail').text(employee.employeeEmail);
            $('#employeeContactNumberDetail').text(employee.employeeContactNumber);
            $('#employeeStatusDetail').val(employee.employeeStatus);
            var imagePath = employee.employeeImagePath ? "http://localhost:8080/complaintManagementSystem/display?imagePath=" + employee.employeeImagePath : 'default-image-path';
            document.getElementById('employeeImageDetail').src = imagePath;
            $('#viewEmployeeModal').modal('show');
        },
        error: function(err) {
            console.error('Error fetching employee details:', err);
            $('#errorMessage').text('Error fetching employee details.');
            $('#errorModal').modal('show');
        }
    });
}
function updateEmployeeStatus() {
    const employeeId = $('#employeeIdDetail').text();
    const status = $('#employeeStatusDetail').val();
    $.ajax({
        url: 'http://localhost:8080/complaintManagementSystem/employee/updateEmployeeStatus',
        method: 'POST',
        data: { employeeId: employeeId, status: status },
        success: function(response) {
            $('#viewEmployeeModal').modal('hide');
            $('#successMessage').text(response);
            $('#successModal').modal('show');
            fetchEmployees(1);
        },
        error: function(xhr) {
            $('#errorMessage').text(xhr.responseText || 'Error updating employee status.');
            $('#errorModal').modal('show');
        }
    });
}
function searchEmployees() {
    fetchEmployees(1);
}

function prevPage() {
    if (currentPage > 1) {
        currentPage--;
        fetchEmployees(currentPage);
    }
}

function nextPage() {
    currentPage++;
    fetchEmployees(currentPage);
}

function goToPage(page) {
    currentPage = page;
    fetchEmployees(currentPage);
}

$(document).ready(function () {
    fetchEmployees(currentPage);
});
</Script>
<script type="text/javascript">
$('#createEmployeeForm').on('submit', function (e) {
    e.preventDefault();
    var departmentId = '${sessionScope.loggedInUserDepartmentId}';
    const employeeData = {
        employeeName: $('#employeeName').val(),
        employeeEmail: $('#employeeEmail').val(),
        employeePassword: $('#employeePassword').val(),
        employeeContactNumber: $('#employeeContactNumber').val(),
        departmentId: departmentId
    };   
    $.ajax({
        url: '/complaintManagementSystem/employee/createEmployee',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(employeeData),
        success: function (response) {
            $('#createEmployeeModal').modal('hide');
            $('#successMessage').text(response);
            $('#successModal').modal('show');
            fetchEmployees(1);
            loadEmployeesByDepartment(departmentId);
        },
        error: function (xhr) {
            $('#errorMessage').text(xhr.responseText || 'Error creating employee.');
            $('#errorModal').modal('show');
        }
    });
});
</script>
<script type="text/javascript">
function deleteEmployee(employeeId) {
    $.ajax({
        url:'/complaintManagementSystem/employee/deleteEmployee',
        method: 'POST',
        data:{
        	employeeId:employeeId
        },
        success: function(response) {
            $('#deleteEmployeeModal').modal('hide');
            $('#successMessage').text(response);
            $('#successModal').modal('show');
            fetchEmployees(1);  // Refresh the employee list
        },
        error: function(xhr) {
            $('#errorMessage').text(xhr.responseText || 'Error deleting employee.');
            $('#errorModal').modal('show');
        }
    });
}

$(document).ready(function() {
	$('#confirmDeleteEmployee').click(function() {
        const deleteEmployeeId = $('#deleteEmployeeId').val(); 
        if (deleteEmployeeId) {  
            deleteEmployee(deleteEmployeeId);  
        } else {
            console.error('Employee ID is missing.'); 
            $('#errorMessage').text('Error: Employee ID is missing.');
            $('#errorModal').modal('show');
        }
    });
	
});
</script>
<script>
    $(document).ready(function() {
        // Get the department ID from the hidden input field
    const departmentId = '${sessionScope.loggedInUserDepartmentId}';

        if (departmentId) {
            loadEmployeesByDepartment(departmentId);
        }
    });

    function loadEmployeesByDepartment(departmentId) {
        $.ajax({
            url: '/complaintManagementSystem/employee/getEmployeeNamesByDepartmentId',
            type: 'GET',
            data: { departmentId: departmentId },
            success: function(response) {
                let employeeSelect = document.getElementById('assignEmployee');
                employeeSelect.innerHTML = '<option value="">Select Employee</option>';
                response.forEach(function(employee) {
                    let option = document.createElement('option');
                    option.value = employee.employeeId;
                    option.textContent = employee.employeeName;
                    employeeSelect.appendChild(option);
                });
            },
            error: function(xhr, status, error) {
                alert('Error loading employees');
                console.error('Error loading employees:', error);
            }
        });
    }
    </script>
<script type="text/javascript">

 // Function to load user details
 function loadUserDetails(userId) {
     if (userId) {
         $.ajax({
             url: '/complaintManagementSystem/getUserDetailsByUserId',
             method: 'GET',
             data: { userId: userId },
             success: function (data) {
             	 document.getElementById('userIdDetail').textContent = data.userId;
                  document.getElementById('userNameDetail').textContent = data.firstName;
                  document.getElementById('userEmailDetail').textContent = data.email;
                  document.getElementById('userContactNumberDetail').textContent = data.contactNumber;
                  document.getElementById('userAddressDetail').textContent = data.address;
                
                  $('#userDetailsModal').modal('show');
             },
             error: function (xhr, status, error) {
                 console.error('Error fetching user details:', error);
             }
         });
     } else {
         alert('User ID is not available.');
     }
 }
    
    </script>
<script type="text/javascript">
 $(document).ready(function () {
	    const searchOptions = $('#search-options');
	    const searchInput = $('#search-input');
	    
	    // Update the placeholder text based on the selected option
	    searchOptions.change(function () {
	        const type = searchOptions.val();
	        let placeholder = 'Enter Search Query';
	        
	        switch (type) {
	            case 'complaint':
	                placeholder = 'Enter Complaint ID';
	                break;
	            case 'employee':
	                placeholder = 'Enter Employee ID';
	                break;
	        }
	        
	        searchInput.attr('placeholder', placeholder);
	    });

	    // Handle the search button click event
	    $('#search-button').click(function () {
	        const query = searchInput.val().trim();
	        const type = searchOptions.val();
	        const departmentId = '${sessionScope.loggedInUserDepartmentId}';

	        if (query === '') {
	            alert('Please enter a search term.');
	            return;
	        }

	        if (type === 'complaint') {
	            searchComplaints(query, departmentId);
	        } else if (type === 'employee') {
	            searchEmployees(query, departmentId);
	        } else {
	            alert('Please select a valid search option.');
	        }
	    });

	    // AJAX function to search for complaints
	    function searchComplaints(complaintId, departmentId) {
	        $.ajax({
	            url: '/complaintManagementSystem/searchComplaintByDepartmentId',
	            method: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify({ complaintId: complaintId, departmentId: departmentId }),
	            success: function (response) {
	                if (response === 'exit') {
	                    viewComplaint(complaintId);
	                } else {
	                    $('#modalBodyContent').html('No valid complaints found.');
	                    $('#searchResultsModal').modal('show');
	                }
	            },
	            error: function (xhr, status, error) {
	                console.error('Error searching complaints:', error);
	                alert('Error performing complaint search');
	            }
	        });
	    }

	    // AJAX function to search for employees
	    function searchEmployees(employeeId, departmentId) {
	        $.ajax({
	            url: '/complaintManagementSystem/employee/searchEmployeeByDepartmentId',
	            method: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify({ employeeId: employeeId, departmentId: departmentId }),
	            success: function (response) {
	                if (response === 'exit') {
	                    viewEmployee(employeeId);
	                } else {
	                	$('#modalBodyContent').html('No valid employees found.');
	                    $('#searchResultsModal').modal('show');
	                }
	            },
	            error: function (xhr, status, error) {
	                alert('Error performing employee search');
	            }
	        });
	    }
	});
</script>




</html>