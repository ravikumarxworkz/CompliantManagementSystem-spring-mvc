<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true"%>
<c:if
	test="${empty sessionScope.loggedInUserEmail || empty sessionScope.loggedInUserId}">
	<c:redirect url="/complaintManagementSystem/HomePage" />
</c:if>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ResolveX-User Profile</title>
<link rel="shortcut icon"
	href="/complaintManagementSystem/res/title icon.png"
	type="image/x-icon">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.2/jspdf.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<script src="/complaintManagementSystem/res/country.js"></script>
<link rel="stylesheet"
	href="/complaintManagementSystem/res/UserProfile.css">
<style type="text/css">
@charset "UTF-8";

@import url('https://fonts.googleapis.com/css?family=Raleway:400,700');

* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
	font-family: 'Raleway', sans-serif;
}

body {
	font-family: Arial, sans-serif;
	background-color: #f8f9fa;
}

.sidebar {
	height: 100vh;
	width: 220px;
	position: fixed;
	top: 0;
	left: 0;
	background-color: #343a40;
	padding-top: 20px;
}

.sidebar a {
	padding: 15px 20px;
	text-align: left;
	display: block;
	color: white;
	text-decoration: none;
}

.sidebar a:hover {
	background-color: #495057;
}

.content {
	padding: 20px;
	margin-left: 240px;
	/* Adjusted to accommodate sidebar */
}

.content {
	margin-left: 240px;
	background: #f5f5f5;
	padding: 20px;
	border-radius: 10px;
	width: 80%;
}
.profile-info {
	padding: 20px;
	border-radius: 5px;
	display: flex;
	flex-direction: row;
	align-items: flex-start;
}

.profile-info .profile-details {
	flex: 2;
}

.profile-info .profile-img {
	flex: 1;
	display: flex;
	justify-content: center;
	align-items: center;
}

.profile-info h3 {
	margin-bottom: 20px;
}

.btn-custom {
	background-color: #007bff;
	color: white;
	border: none;
}

.btn-custom:hover {
	background-color: #0056b3;
}

.profile-name {
	margin-right: 10px;
	/* Adjust the space between first and last name */
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

.form-row {
	margin-bottom: 15px;
}

.form-row .form-group {
	margin-bottom: 0;
}

.card {
	background-color: transparent;
	border: 4px solid black;
	border-radius: 10px;
}

.form-group label {
	font-weight: bold;
}

.card-title {
	text-align: center;
	font-weight: bolder;
}

.complaint-dashboard {
	padding: 20px;
}

.card {
	background-color: #FFFFFF;
	border: none;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.complaint-history {
	background-color: #FFFFFF;
	padding: 20px;
	border-radius: 8px;
}

.complaint-dashboard {
	margin-bottom: 30px;
}

.card {
	margin-bottom: 20px;
}

.card-title {
	font-size: 1.2rem;
	font-weight: bold;
}

.card-text {
	font-size: 1.5rem;
}

.complaint-history table {
	width: 100%;
	margin-top: 20px;
}

.table thead th {
	background-color: #f8f9fa;
	font-weight: bold;
}

.pagination {
	justify-content: center;
	margin-top: 20px;
}

.pagination .page-item {
	cursor: pointer;
}

.pagination .page-item.disabled {
	pointer-events: none;
}

.pagination .page-link {
	color: #007bff;
}

.modal-content {
	border-radius: 10px;
}

.modal-header {
	background-color: #007bff;
	color: white;
}



.show-password {
	cursor: pointer;
}

.dashBoradTotalComplaints {
	background-color: #6f42c1;
}

.content {
	margin-left: 240px;
	background: #f5f5f5;
	padding: 20px;
	border-radius: 10px;
	width: 80%;
}

.modern-form {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.form-logo img {
	width: 100%;
	height: 80px;
	object-fit: cover;
	border-radius: 50%;
	box-shadow: 0px 0px 3px #5f5f5f, 0px 0px 0px 5px #ecf0f3, 8px 8px 15px
		#a7aaa7, -8px -8px 15px #fff;
}

.form-row {
	display: flex;
	justify-content: space-between;
	width: 100%;
}

.form-group {
	flex: 1;
	margin: 10px;
}

.input-container {
	position: relative;
	width: 100%;
}

.input-container .icon {
	position: absolute;
	left: 10px; /* Adjust as needed */
	top: 50%;
	transform: translateY(-50%);
	color: #333; /* Adjust icon color if needed */
	pointer-events: none;
}

.input-container input, .input-container textarea {
	width: 100%;
	padding: 10px 10px 10px 40px;
	border: none;
	border-bottom: 2px solid #ccc;
	background: transparent;
	transition: border-color 0.3s ease;
}

.input-container input:focus, .input-container textarea:focus {
	border-bottom-color: #007bff;
	outline: none;
}

textarea.form-control {
	resize: none;
}

.input-container select {
	padding-left: 35px;
	/* This should be greater than the icon's left position + icon's width */
	width: 100%;
	border: none;
	border-bottom: 2px solid #ccc;
	background-color: transparent;
	box-sizing: border-box;
	font-size: 16px;
	color: #333;
}

.input-container select:focus {
	border-bottom-color: #007bff;
	outline: none;
}

.btn-primary {
	background-color: #007bff;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	/* margin-top: 20px; */
	cursor: pointer;
}

.btn-primary:hover {
	background-color: #0056b3;
}

.modern-form {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.form-logo img {
	width: 100%;
	height: 80px;
	object-fit: cover;
	border-radius: 50%;
	box-shadow: 0px 0px 3px #5f5f5f, 0px 0px 0px 5px #ecf0f3, 8px 8px 15px
		#a7aaa7, -8px -8px 15px #fff;
}

.form-row {
	display: flex;
	justify-content: space-between;
	width: 100%;
}

.form-group {
	flex: 1;
	margin: 10px;
}

.input-container {
	position: relative;
	width: 100%;
}

.input-container .icon {
	position: absolute;
	left: 10px; /* Adjust as needed */
	top: 50%;
	transform: translateY(-50%);
	color: #333; /* Adjust icon color if needed */
	pointer-events: none;
}

.input-container input, .input-container textarea {
	width: 100%;
	padding: 10px 10px 10px 40px;
	border: none;
	border-bottom: 2px solid #ccc;
	background: transparent;
	transition: border-color 0.3s ease;
}

.input-container input:focus, .input-container textarea:focus {
	border-bottom-color: #007bff;
	outline: none;
}

textarea.form-control {
	resize: none;
}

.input-container select {
	padding-left: 35px;
	/* This should be greater than the icon's left position + icon's width */
	width: 100%;
	border: none;
	border-bottom: 2px solid #ccc;
	background-color: transparent;
	box-sizing: border-box;
	font-size: 16px;
	color: #333;
}

.input-container select:focus {
	border-bottom-color: #007bff;
	outline: none;
}

.btn-primary {
	background-color: #007bff;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	/* margin-top: 20px; */
	cursor: pointer;
}

.btn-primary:hover {
	background-color: #0056b3;
}



/* Responsive adjustments */
@media ( max-width : 768px) {
	.sidebar {
		width: 100%;
		/* Full width on smaller screens */
		position: relative;
		height: auto;
	}
	.content {
		margin-left: 0;
		/* Adjust to remove margin on smaller screens */
	}
}

</style>
</head>

<body>
	<c:set var="profile" value="${profileDto}" />
	<div class="sidebar">
		<div class="text-center">
			<img id="userPhoto" src="display?imagePath=${profile.imagePath}"
				alt="User Image" class="img-fluid rounded-circle"
				style="width: 100px; height: 100px;">
			<h4 id="profileName" class="text-white mt-2">${profile.firstName}</h4>
		</div>
		<a href="#" class="sidebar-link" data-target="viewProfile">View
			Profile</a> <a href="#" class="sidebar-link" data-target="changePassword">Change
			Password</a> <a href="#" class="sidebar-link"
			data-target="lodgeComplaint">Lodge Complaint</a> <a href="#"
			class="sidebar-link" data-target="complaintHistory">Complaint
			History</a> <a href="signOut" class="text-danger">Logout</a>
	</div>
	<div class="container mt-5">
		<!-- View Profile Section -->
		<div class="content" id="viewProfile" style="display: none;">
			<div class="profile-info">
				<div class="profile-details">
					<h3>
						<span id="profileName" class="profile-name">${profile.firstName}</span>
						${profile.lastName} Profile
					</h3>
					<div class="form-group">
						<label>Last Updated at:</label> <span id="ProfileupdateAndTime"
							class="date-field" data-date="${profileDto.updatedAt}"></span>

					</div>
					<form id="userProfileForm" method="post"
						enctype="multipart/form-data">
						<div
							class="d-flex justify-content-center align-items-center flex-column">
							<div class="round-image">
								<img id="profileImage"
									src="display?imagePath=${profile.imagePath}" alt="User Photo">
							</div>
							<div id="uploadSection" style="display: none; margin-top: 20px;">
								<label for="newPhoto" class="btn btn-warning">Upload New
									Photo <input type="file" id="newPhoto" name="imageFile"
									accept="image/*" style="display: none;">
								</label>
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label for="firstName"><i class="fas fa-user"></i> First
									Name</label> <input type="text" class="form-control" id="firstName"
									name="firstName" disabled>
							</div>
							<div class="form-group col-md-6">
								<label for="lastName"><i class="fas fa-user"></i> Last
									Name</label> <input type="text" class="form-control" id="lastName"
									name="lastName" disabled>
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label for="userEmail"><i class="fas fa-envelope"></i>
									User Email</label> <input type="email" class="form-control"
									id="userEmail" name="email" disabled>
							</div>
							<div class="form-group col-md-6">
								<label for="contact"><i class="fas fa-phone"></i>
									Contact</label> <input type="text" class="form-control" id="contact"
									name="contactNumber" disabled>
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label for="alterContact"><i class="fas fa-phone-alt"></i>
									Alternate Contact</label> <input type="text" class="form-control"
									id="alterContact" name="alterContactNumber" disabled>
							</div>
							<div class="form-group col-md-6">
								<label for="regDate"><i class="far fa-calendar-alt"></i>
									Reg Date</label> <input type="datetime" class="form-control"
									id="regDate" name="regDate" disabled>
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-md-6">
								<label for="address"><i class="fas fa-map-marker-alt"></i>
									Address</label>
								<textarea class="form-control" id="address" name="address"
									rows="3" disabled>${profile.address}</textarea>
							</div>
						</div>
						<button type="button" id="editBtn" class="btn btn-primary">
							<i class="fas fa-edit"></i> Edit
						</button>
						<button type="submit" class="btn btn-success" id="submitBtn"
							style="display: none;">Submit</button>
					</form>
				</div>
			</div>
		</div>
		<!-- Change Password Section -->
		<div id="changePassword" class="content" style="display: none;">
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">Change Password</h5>
					<form id="changePasswordForm" method="post">
						<div class="form-group mb-4">
							<div class="input-group">
								<input type="password" class="form-control" id="oldPassword"
									placeholder="Enter old Password" required name="oldPassword"
									onblur="validatePassword()">
								<button type="button" class="btn btn-outline-info"
									onclick="togglePasswordVisibility('oldPassword')">
									<i class="bi bi-eye"></i>
								</button>
							</div>
						</div>
						<div class="form-group mb-4">
							<div class="input-group">
								<input type="password" class="form-control" id="newPassword"
									placeholder="Enter New Password" aria-label="Password"
									aria-describedby="showPasswordButton" required>
								<button type="button" class="btn btn-outline-info"
									id="showPasswordButton"
									onclick="togglePasswordVisibility('newPassword')">
									<i class="bi bi-eye"></i>
								</button>
							</div>
							<span id="errorOldPassword" class="error-message"
								style="color: red;"></span> <span id="errorPassword"
								class="error-message" style="color: red;"></span>
						</div>
						<div class="form-group mb-4">
							<div class="input-group">
								<input type="password" class="form-control" id="confirmPassword"
									placeholder="Enter confirmPassword" name="confirmPassword"
									required onblur="validatePassword()">
								<button type="button" class="btn btn-outline-info"
									onclick="togglePasswordVisibility('confirmPassword')">
									<i class="bi bi-eye"></i>
								</button>
							</div>
							<span id="errorConfirmPassword" class="error-message"
								style="color: red;"></span>
						</div>
						<div class="row justify-content-center">
							<div class="col-md-10 text-center">
								<button type="submit" class="btn btn-primary mt-4" id="button"
									disabled>Change Password</button>
							</div>
						</div>
						<span id="message" style="color: red;">${message}</span>
						<div>
							<a href="ResetPasswordPage"
								class="forgot-password-link float-right">Reset Password?</a>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!-- Lodge Complaint Section -->
		<div id="lodgeComplaint" class="content" style="display: none;">
			<h2 class="text-center">Register Complaint</h2>
			<form id="complaintForm" class="modern-form">
				<div class="form-logo">
					<img src="/complaintManagementSystem/res/companyLogo.jpg"
						alt="Company Logo">
				</div>
				<div class="form-row">
					<div class="form-group col-md-6">
						<div class="input-container">
							<i class="fas fa-list-alt icon"></i> <select class="form-control"
								id="complaintTypeFilter" placeholder="Complaint Type">
								<option value="">Select Complaint Type</option>
							</select>
						</div>
					</div>
					<div class="form-group col-md-6">
						<div class="input-container">
							<i class="fas fa-globe icon"></i> <select id="countryFilter"
								class="form-control" placeholder="Country"
								onchange="loadStates(this.value)">
								<option value="">Select Country</option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-row">
					<div class="form-group col-md-6">
						<div class="input-container">
							<i class="fas fa-map-marker-alt icon"></i> <select
								id="stateFilter" class="form-control" placeholder="State"
								onchange="loadCities(this.value)">
								<option value="">Select State</option>
							</select>
						</div>
					</div>
					<div class="form-group col-md-6">
						<div class="input-container">
							<i class="fas fa-city icon"></i> <select id="cityFilter"
								class="form-control" placeholder="City">
								<option value="">Select City</option>
							</select>
						</div>
					</div>
				</div>
				<div class="form-row">
					<div class="form-group col-md-6">
						<div class="input-container">
							<i class="fas fa-location-arrow icon"></i> <input type="text"
								class="form-control" id="cityArea" placeholder="Area">
						</div>
					</div>
					<div class="form-group col-md-6">
						<div class="input-container">
							<i class="fas fa-home icon"></i> <input type="text"
								class="form-control" id="complaintAddress" placeholder="Address">
						</div>
					</div>
				</div>
				<div class="form-row">
					<div class="form-group col-md-12">
						<div class="input-container">
							<i class="fas fa-align-left icon"></i>
							<textarea class="form-control" id="complaintDetails" rows="3"
								placeholder="Complaint Details (max 500 words)"></textarea>
						</div>
					</div>
				</div>
				<button type="submit" class="btn btn-primary">Submit</button>
			</form>
		</div>




		<!-- Complaint History Section -->
		<div id="complaintHistory" class="content" style="display: none;">
			<div class="complaint-dashboard">
				<div class="row">
					<div class="col-md-4">
						<div class="card text-white dashBoradTotalComplaints"
							style="background-color: #007bff;">
							<div class="card-body">
								<h5 class="card-title">
									<i class="fas fa-clipboard-list"></i> Total Complaints
								</h5>
								<p class="card-text" id="totalComplaints">0</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card text-white dashBoradNewComplaints"
							style="background-color: #28a745;">
							<div class="card-body">
								<h5 class="card-title">
									<i class="fas fa-plus-circle"></i> New Complaints
								</h5>
								<p class="card-text" id="newComplaints">0</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card text-white dashBoradPendingComplaints"
							style="background-color: #ffc107;">
							<div class="card-body">
								<h5 class="card-title">
									<i class="fas fa-exclamation-circle"></i> Pending Complaints
								</h5>
								<p class="card-text" id="pendingComplaints">0</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card text-white" style="background-color: #17a2b8;">
							<div class="card-body">
								<h5 class="card-title">
									<i class="fas fa-hourglass-half"></i> In Progress
								</h5>
								<p class="card-text" id="inProgressComplaints">0</p>
							</div>
						</div>
					</div>
					<div class="col-md-4">
						<div class="card text-white" style="background-color: #dc3545;">
							<div class="card-body">
								<h5 class="card-title">
									<i class="fas fa-times-circle"></i> Closed
								</h5>
								<p class="card-text" id="closedComplaints">0</p>
							</div>
						</div>
					</div>
				</div>
			</div>


			<div class="row mt-4">
				<div class="col-md-12">
					<div class="card bg-light text-dark">
						<div class="card-body">
							<h5 class="card-title">Complaints</h5>

							<!-- Dropdown for filtering complaints -->
							<div class="dropdown mb-3">
								<button class="btn btn-secondary dropdown-toggle" type="button"
									id="dropdownMenuButton" data-bs-toggle="dropdown"
									aria-haspopup="true" aria-expanded="false">Filter by
									Status</button>
								<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
									<a class="dropdown-item" href="#"
										onclick="filterComplaints('all')">All Complaints</a> <a
										class="dropdown-item" href="#"
										onclick="filterComplaints('Registered')">New Complaints</a> <a
										class="dropdown-item" href="#"
										onclick="filterComplaints('Pending')">Pending Complaints</a> <a
										class="dropdown-item" href="#"
										onclick="filterComplaints('In Progress')">In Progress
										Complaints</a> <a class="dropdown-item" href="#"
										onclick="filterComplaints('Closed')">Closed Complaints</a>
								</div>
							</div>

							<!-- Search Input -->
							<input type="text" class="form-control mt-2"
								placeholder="Search Complaint by Complaint Type"
								id="SearchComplaint" onkeyup="searchComplaints()">

							<!-- Table -->
							<div class="table-responsive">
								<table id="complaintsTable" class="table table-striped mt-2">
									<thead>
										<tr>
											<th scope="col">#</th>
											<th scope="col">Complaint Type</th>
											<th scope="col">Status</th>
											<th scope="col">assingnDepartment</th>
											<th scope="col">assingnEmployee</th>
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
										id="pageSizeSelector" class="form-select" style="width: auto;"
										onchange="updatePageSize(this.value)">
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
		<div class="modal fade" id="complaintDetailsModal" tabindex="-1"
			aria-labelledby="complaintDetailsModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="complaintDetailsModalLabel">Complaint
							Details</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form id="complaintEditDetailsForm">
							<div class="row mb-3">
								<div class="col-6">
									<label for="complaintId" class="form-label"> <i
										class="fas fa-id-card"></i> Complaint ID:
									</label> <input type="text" class="form-control" id="complaintId"
										readonly>
								</div>
								<div class="col-6">
									<label for="complaintType" class="form-label"> <i
										class="fas fa-building"></i> Complaint Type:
									</label> <input type="text" class="form-control" id="complaintType"
										disabled>
								</div>
							</div>
							<div class="row mb-3">
								<div class="col-6">
									<label for="country" class="form-label"> <i
										class="fas fa-globe"></i> Country:
									</label> <input type="text" class="form-control" id="country" disabled>
								</div>
								<div class="col-6">
									<label for="state" class="form-label"> <i
										class="fas fa-map"></i> State:
									</label> <input type="text" class="form-control" id="state" disabled>
								</div>
							</div>
							<div class="row mb-3">
								<div class="col-6">
									<label for="cityArea" class="form-label"> <i
										class="fas fa-city"></i> City/Area:
									</label> <input type="text" class="form-control" id="cityArea" disabled>
								</div>
								<div class="col-6">
									<label for="city" class="form-label"> <i
										class="fas fa-city"></i> City:
									</label> <input type="text" class="form-control" id="city" disabled>
								</div>
							</div>
							<div class="row mb-3">
								<div class="col-6">
									<label for="status" class="form-label"> <i
										class="fas fa-tag"></i> Status:
									</label> <input type="text" class="form-control" id="status" disabled>
								</div>
								<div class="col-6">
									<label for="createdAt" class="form-label"> <i
										class="fas fa-calendar-day"></i> Created At:
									</label> <input type="text" class="form-control" id="createdAt"
										readonly>
								</div>
							</div>
							<div class="row mb-3">
								<div class="col-12">
									<label for="updatedAt" class="form-label"> <i
										class="fas fa-calendar-edit"></i> Updated At:
									</label> <input type="text" class="form-control" id="updatedAt"
										readonly>
								</div>
							</div>
							<div class="row">
								<div class="col-12">
									<label for="complaintAddress" class="form-label"> <i
										class="fas fa-map-marker-alt"></i> Address:
									</label> <input type="text" class="form-control" id="complaintAddress"
										disabled>
								</div>
							</div>
							<div class="row mb-3">
								<div class="col-12">
									<label for="complaintDetails" class="form-label"> <i
										class="fas fa-file-alt"></i> Details:
									</label>
									<textarea class="form-control" id="complaintDetails"></textarea>
								</div>
							</div>
							<div class="row mb-3" id="complaintCommentRow"
								style="display: none;">
								<div class="col-12">
									<label for="complaintComment" class="form-label"> <i
										class="fas fa-comment"></i> Comment:
									</label>
									<textarea class="form-control" id="complaintComment" disabled></textarea>
								</div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">Close</button>
								<button type="button" class="btn btn-primary"
									onclick="updateComplaintDetails()" id="saveButton">Save
									Changes</button>

							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

		<!-- Department Modal -->
		<div class="modal fade" id="departmentModal" tabindex="-1"
			role="dialog" aria-labelledby="departmentModalLabel"
			aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="departmentModalLabel">Department
							Details</h5>
						<button type="button" class="close" data-dismiss="modal"
							onclick="closeModals()" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<p id="departmentDetails"></p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							onclick="closeModals()" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>

		<!-- Employee Modal -->
		<div class="modal fade" id="employeeModal" tabindex="-1" role="dialog"
			aria-labelledby="employeeModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="employeeModalLabel">Employee
							Details</h5>
						<button type="button" class="close" data-dismiss="modal"
							onclick="closeModals()" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<p id="employeeDetails"></p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							onclick="closeModals()" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>




		<!-- Success Modal -->
		<div class="modal fade" id="successModal" tabindex="-1" role="dialog"
			aria-labelledby="successModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="successModalLabel">Success</h5>
						<button type="button" class="close" data-dismiss="modal"
							onclick="closeModals()" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<p id="successMessage"></p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary"
							onclick="closeModals()" data-dismiss="modal">OK</button>
					</div>
				</div>
			</div>
		</div>
		<!-- Error Modal -->
		<div class="modal fade" id="errorModal" tabindex="-1" role="dialog"
			aria-labelledby="errorModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="errorModalLabel">Error</h5>
						<button type="button" class="close" data-dismiss="modal"
							onclick="closeModals()" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<p id="errors"></p>
						<ul id="errorList">
							<!-- Error messages will be dynamically inserted here -->
						</ul>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-danger"
							onclick="closeModals()" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
    document.addEventListener("DOMContentLoaded", function() {
        const dateElement = document.getElementById('ProfileupdateAndTime');
        const rawDate = dateElement.getAttribute('data-date');
        const dateObj = new Date(rawDate);

        const formattedDate = dateObj.toLocaleString(undefined, {
            year: 'numeric',
            month: 'long',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        });
        dateElement.textContent = formattedDate;
    });
</script>

	<script type="text/javascript">
        function closeModals() {
            $('#successModal').modal('hide');
            $('#errorModal').modal('hide');
            $('#departmentModal').modal('hide');
            $('#employeeModal').modal('hide');
        }
    </script>
	<script>
        $(document).ready(function () {
            function updateDashboard() {
                $.ajax({
                    url: '/complaintManagementSystem/dashboardDataOfUser', // Endpoint to fetch dashboard data
                    type: 'GET',
                    dataType: "json",
                    success: function (response) {
                        $('#totalComplaints').text(response.totalComplaints);
                        $('#newComplaints').text(response.newComplaints);
                        $('#pendingComplaints').text(response.pendingComplaints);
                        $('#inProgressComplaints').text(response.inProgressComplaints);
                        $('#closedComplaints').text(response.closedComplaints);
                        
                    },
                    error: function (xhr, status, error) {
                    	handleError("Error fetching dashboard data:: ", error);
                    }
                });
            }
            updateDashboard();
            setInterval(updateDashboard, 30000);
        });
    </script>
	<script>
        function handleSidebarClick(event) {
            event.preventDefault();
            var targetId = $(this).data('target');
            $('.content').hide();

            $('#' + targetId).show();

            if (targetId === 'viewProfile') {
                fetchUserProfile();
            } else if (targetId === 'complaintHistory') {
            	fetchComplaints();
            }
        }
        function fetchUserProfile() {
            $
                .ajax({
                    url: '/complaintManagementSystem/getUserProfile',
                    type: 'GET',
                    dataType: 'json',
                    success: function (response) {
                        if (response) {
                            var profile = response;
                            $('#firstName').val(
                                profile.firstName)
                                .prop('disabled',
                                    true);
                            $('#lastName').val(
                                profile.lastName)
                                .prop('disabled',
                                    true);
                            $('#userEmail').val(
                                profile.email)
                                .prop('disabled',
                                    true);
                            $('#contact')
                                .val(
                                    profile.contactNumber)
                                .prop('disabled',
                                    true);
                            $('#alterContact')
                                .val(
                                    profile.alterContactNumber)
                                .prop('disabled',
                                    true);
                            $('#address').val(
                                profile.address)
                                .prop('disabled',
                                    true);
                            $('#regDate')
                                .val(
                                    profile.createdAt ? profile.createdAt
                                        : 'N/A')
                                .prop('disabled',
                                    true);

                            // Update user photo
                            $('#userPhoto')
                                .attr(
                                    'src',
                                    'display?imagePath='
                                    + profile.imagePath);
                            $('#ProfileupdateAndTime').text(profile.updatedAt);
                        } else {
                            alert('Profile data not available.');
                        }
                    },
                    error: function (xhr) {
                        alert('Error fetching profile data: '
                            + xhr.responseText);
                    }
                });
        }
        $('.sidebar-link').on('click', handleSidebarClick);
    </script>
	<!--   complete user profile edit update JavaScript and AJAX CODES -->
	<script type="text/javascript">
        document
            .getElementById('editBtn')
            .addEventListener(
                'click',
                function () {
                    var inputs = document
                        .querySelectorAll('#userProfileForm input:not([id="regDate"], [id="userEmail"]), #userProfileForm textarea');
                    for (var i = 0; i < inputs.length; i++) {
                        inputs[i].disabled = false;
                    }
                    // Show the new profile image upload section and submit button
                    document.getElementById('uploadSection').style.display = 'block';
                    document.getElementById('editBtn').style.display = 'none';
                    document.getElementById('submitBtn').style.display = 'block';
                });

        document.getElementById('newPhoto').addEventListener('change',
            function (event) {
                if (event.target.files.length > 0) {
                    previewNewPhoto(event);
                }
            });

        function previewNewPhoto(event) {
            var file = event.target.files[0];
            var reader = new FileReader();

            reader.onload = function (e) {
                document.getElementById('profileImage').src = e.target.result; // Update the profile image preview
            };

            reader.readAsDataURL(file);
        }

        document
            .getElementById('userProfileForm')
            .addEventListener(
                'submit',
                function (event) {
                    event.preventDefault(); // Prevent default form submission

                    var formData = new FormData(this);

                    $
                        .ajax({
                            url: '/complaintManagementSystem/updateProfile', // Adjust URL as needed
                            type: 'POST',
                            data: formData,
                            contentType: false,
                            processData: false,
                            success: function (response) {
                                if (response === 'Profile updated successfully') {
                                    $('#successMessage')
                                        .text(
                                            'Profile updated successfully!');
                                    $('#successModal')
                                        .modal('show');
                                    fetchUserProfile();
                                    // Function to refresh user profile data
                                    document.getElementById('uploadSection').style.display = 'none';
                                    document.getElementById('editBtn').style.display = 'block';
                                    document.getElementById('submitBtn').style.display = 'none';
                                } else {
                                    showErrorModal(['Unexpected response: '
                                        + response]);
                                }
                            },
                            error: function (xhr, status, error) {

                            	handleError("Error while updating profile: " + error);
                            }
                        });
                });

    </script>
	<script type="text/javascript">
        $('#changePasswordForm')
            .submit(
                function (event) {
                    event.preventDefault(); // Prevent the default form submission

                    var oldPassword = $(
                        '#oldPassword').val();
                    var newPassword = $(
                        '#newPassword').val();
                    var confirmPassword = $(
                        '#confirmPassword')
                        .val();

                    var formData = {
                        oldPassword: oldPassword,
                        newPassword: newPassword,
                        confirmPassword: confirmPassword
                    };

                    $
                        .ajax({
                            url: '/complaintManagementSystem/changePassword',
                            type: 'POST',
                            contentType: 'application/json',
                            data: JSON
                                .stringify(formData),
                            success: function (
                                response) {
                                $(
                                    '#successMessage')
                                    .text(
                                        'Password changed successfully!');
                                $(
                                    '#successModal')
                                    .modal(
                                        'show');
                                setTimeout(
                                    function () {
                                        $(
                                            '#successModal')
                                            .modal(
                                                'hide');
                                        $('#changePasswordForm')[0]
                                            .reset();
                                    }, 3000);
                            },
                            error: function (
                                xhr) {
                                $('#errorList')
                                    .empty();
                                if (xhr.status === 400) {
                                    var errorMessage = xhr.responseText;
                                    $(
                                        '#errorList')
                                        .append(
                                            '<li>'
                                            + errorMessage
                                            + '</li>');
                                } else {
                                    $(
                                        '#errorList')
                                        .append(
                                            '<li>An unexpected error occurred. Please try again later.</li>');
                                }
                                $(
                                    '#changePasswordErrorModal')
                                    .modal(
                                        'show');
                            }
                        });
                });
    </script>
	<script type="text/javascript">
        $('#complaintForm').submit(function (event) {
            event.preventDefault();

            var complaintType = $('#complaintTypeFilter option:selected').text();
            var country = $('#countryFilter option:selected').text();
            var state = $('#stateFilter option:selected').text();
            var city = $('#cityFilter option:selected').text();
            var cityArea = $('#cityArea').val();
            var complaintAddress = $('#complaintAddress').val();
            var complaintDetails = $('#complaintDetails').val();

            // Now you can create the ComplaintDto object or send this data to your backend as needed



            var complaintData = {
                complaintType: complaintType,
                country: country,
                state: state,
                city: city,
                cityArea: cityArea,
                complaintAddress: complaintAddress,
                complaintDetails: complaintDetails
            };

            $.ajax({
                url: '/complaintManagementSystem/lodge-complaint',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(complaintData),
                success: function (response) {
                    $('#successMessage').text('Complaint lodged successfully!');
                    $('#successModal').modal('show');
                    $('#complaintForm')[0].reset();
                },
                error: function (xhr) {
                    var errorMessage = 'Error lodging complaint: ' + (xhr.responseText || 'An unexpected error occurred.');
                    $('#errorMessage').text(errorMessage);
                    $('#errorModal').modal('show');
                }
            });
        });
    </script>
	<script>
        function togglePasswordVisibility(fieldId) {
            var passwordField = document.getElementById(fieldId);
            var buttonIcon = passwordField.nextElementSibling
                .querySelector('i');

            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                buttonIcon.classList.remove('bi-eye');
                buttonIcon.classList.add('bi-eye-slash');
            } else {
                passwordField.type = 'password';
                buttonIcon.classList.remove('bi-eye-slash');
                buttonIcon.classList.add('bi-eye');
            }
        }
        function validatePassword() {
            var oldPassword = document.getElementById("oldPassword").value;
            var newPassword = document.getElementById("newPassword").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=!])(?=.*[a-zA-Z]).{8,20}$/;

            if (oldPassword !== newPassword && passwordRegex.test(newPassword)
                && newPassword === confirmPassword) {
                document.getElementById("errorPassword").innerHTML = "";
                document.getElementById("errorConfirmPassword").innerHTML = "";
                document.getElementById("errorOldPassword").innerHTML = "";
                document.getElementById("button").disabled = false;
            } else {
                if (oldPassword === newPassword) {
                    document.getElementById("errorOldPassword").innerHTML = "New password should be different from old password";
                } else {
                    document.getElementById("errorOldPassword").innerHTML = "";
                }
                if (!passwordRegex.test(newPassword)) {
                    document.getElementById("errorPassword").innerHTML = "Password must contain at least one uppercase letter, one lowercase letter, one digit, one special character, and be between 8 and 20 characters long";
                    document.getElementById("button").disabled = true;
                } else {
                    document.getElementById("errorPassword").innerHTML = "";
                }

                if (newPassword !== confirmPassword) {
                    document.getElementById("errorConfirmPassword").innerHTML = "Passwords do not match";
                    document.getElementById("button").disabled = true;
                } else {
                    document.getElementById("errorConfirmPassword").innerHTML = "";
                }
            }
        }
    </script>

	<script type="text/javascript">
        let currentPageComplaints = 1;
        let pageSizeComplaints = 10;
        let currentStatus = 'all';
        let currentSearchQuery = '';

        function fetchComplaints(page = currentPageComplaints, status = currentStatus, query = currentSearchQuery) {
               const userId = '${sessionScope.loggedInUserId}';
        	$.ajax({
                url: '/complaintManagementSystem/getAllComplaintsByUser',
                type: 'GET',
                data: {
                	userId:userId,
                    page: page,
                    size: pageSizeComplaints,
                    query: query,
                    status: status
                },
                dataType: 'json',
                success: function (response) {
                	
                	
                	populateComplaintTable(response.complaints);
                    updateComplaintPagination(response.totalPages, page);
                },
                error: function (xhr, status, error) {
                	handleError("Error fetching complaints: " + error);
                }
            });
        }

        function searchComplaints() {
            currentSearchQuery = $('#SearchComplaint').val();
            fetchComplaints(1, currentStatus, currentSearchQuery);
        }

        function filterComplaints(status) {
            currentPageComplaints = 1;
            currentStatus = status;
            fetchComplaints(currentPageComplaints, currentStatus, currentSearchQuery);
        }

        function populateComplaintTable(complaints) {
 
            const tableBody = $('#complaintsTableBody');
            tableBody.empty();

            if (complaints && complaints.length > 0) {
                complaints.forEach((complaint) => {
                    const isDepartmentAssigned = complaint.departmentId ? true : false;
                    const isEmployeeAssigned = complaint.employeeId ? true : false;

                    const departmentButton = isDepartmentAssigned
                        ? `<button class='btn btn-info btn-sm' onclick='viewDepartmentDetails("`
                        + JSON.stringify(complaint.departmentId)
                        + `")'> <i class='fas fa-eye'></i> View Department</button>`
                        : `<button class='btn btn-secondary btn-sm' disabled>Not Assigned</button>`;

                    const employeeButton = isEmployeeAssigned
                        ? `<button class='btn btn-info btn-sm' onclick='viewEmployeeDetails("`
                        + JSON.stringify(complaint.employeeId)
                        + `")'> <i class='fas fa-eye'></i> View Employee</button>`
                        : `<button class='btn btn-secondary btn-sm' disabled>Not Assigned</button>`;


                    const row = "<tr>"
                        + "<td>" + complaint.complaintId + "</td>"
                        + "<td>" + complaint.complaintType + "</td>" // Display complaint type
                        + "<td>" + complaint.status + "</td>"
                        + "<td>" + departmentButton + "</td>" // Replace with button for department
                        + "<td>" + employeeButton + "</td>"   // Replace with button for employee
                        + "<td><button class='btn btn-primary btn-sm' onclick='editComplaintDetails("
                        + JSON.stringify(complaint)
                        + ")'>Edit</button></td>"
                        + "</tr>";

                    tableBody.append(row);
                });
            } else {
                tableBody.html('<tr><td colspan="6" class="text-center">No complaints found for this user.</td></tr>');
            }

            $('#complaintsTable').off('click').on('click', '.view-complaint', function () {
                const complaintId = $(this).data('id');
                viewComplaint(complaintId);
            });
        }

        function updateComplaintPagination(totalPages, currentPage) {
            const paginationContainer = $('#complintPagination');
            paginationContainer.empty();

            const prevDisabled = currentPage === 1 ? 'disabled' : '';
            const nextDisabled = currentPage === totalPages ? 'disabled' : '';

            paginationContainer.append(`
         <li class="page-item ${prevDisabled}">
             <a class="page-link" href="#" onclick="prevPageComplaints()">Previous</a>
         </li>
     `);

            for (let i = 1; i <= totalPages; i++) {
                const activeClass = i === currentPage ? 'active' : '';
                paginationContainer.append('<li class="page-item ' + activeClass + '"><a class="page-link" href="#" onclick="goToPageComplaints(' + i + ')">' + i + '</a></li>');
            }


            paginationContainer.append(`
         <li class="page-item ${nextDisabled}">
             <a class="page-link" href="#" onclick="nextPageComplaints()">Next</a>
         </li>
     `);
        }

        function prevPageComplaints() {
            if (currentPageComplaints > 1) {
                currentPageComplaints--;
                fetchComplaints(currentPageComplaints);
            }
        }

        function nextPageComplaints() {
            fetchComplaints(currentPageComplaints + 1);
        }

        function goToPageComplaints(page) {
            currentPageComplaints = page;
            fetchComplaints(currentPageComplaints);
        }

        function updatePageSize(newSize) {
            pageSizeComplaints = parseInt(newSize, 10);
            currentPageComplaints = 1; // Reset to the first page
            fetchComplaints(currentPageComplaints);
        }

        $(document).ready(function () {
            fetchComplaints(currentPageComplaints);
            $('#SearchComplaint').on('keyup', searchComplaints);
        });

    </script>
<script type="text/javascript">
    $(document).ready(function () {
        // Event delegation for dynamically created buttons
        $(document).on('click', '.view-btn', function () {
            var complaint = $(this).data('complaint');

            if (window.editComplaintDetails) {
                window.editComplaintDetails(complaint);
            } else {
                handleError('editComplaintDetails function is not defined.');
            }
        });

        // Define editComplaintDetails in the global scope
         window.editComplaintDetails = function(complaint) {
    if (!complaint || typeof complaint !== 'object') {
        handleError('Invalid complaint object.');
        return;
    }

    // Populate the modal fields with the complaint data
    $('#complaintDetailsModal #complaintId').val(complaint.complaintId);
    $('#complaintDetailsModal #complaintType').val(complaint.complaintType);
    $('#complaintDetailsModal #country').val(complaint.country);
    $('#complaintDetailsModal #state').val(complaint.state);
    $('#complaintDetailsModal #cityArea').val(complaint.cityArea);
    $('#complaintDetailsModal #city').val(complaint.city || '');
    $('#complaintDetailsModal #complaintAddress').val(complaint.complaintAddress);
    $('#complaintDetailsModal #complaintDetails').val(complaint.complaintDetails);
    $('#complaintDetailsModal #status').val(complaint.status);

    // Format createdAt and updatedAt as a user-friendly date-time string
    if (Array.isArray(complaint.createdAt) && complaint.createdAt.length >= 6) {
        const createdAtDate = new Date(
            complaint.createdAt[0], 
            complaint.createdAt[1] - 1, // Month is 0-based in JS Date
            complaint.createdAt[2],
            complaint.createdAt[3],
            complaint.createdAt[4],
            complaint.createdAt[5]
        );
        $('#complaintDetailsModal #createdAt').val(createdAtDate.toLocaleString());
    } else {
        $('#complaintDetailsModal #createdAt').val('N/A');
    }

    if (Array.isArray(complaint.updatedAt) && complaint.updatedAt.length >= 6) {
        const updatedAtDate = new Date(
            complaint.updatedAt[0], 
            complaint.updatedAt[1] - 1, 
            complaint.updatedAt[2],
            complaint.updatedAt[3],
            complaint.updatedAt[4],
            complaint.updatedAt[5]
        );
        $('#complaintDetailsModal #updatedAt').val(updatedAtDate.toLocaleString());
    } else {
        $('#complaintDetailsModal #updatedAt').val('N/A');
    }

    // Enable/Disable textarea and save button based on the complaint status
    const isEditable = complaint.status === 'Registered';
    $('#complaintDetailsModal #complaintDetails').prop('disabled', !isEditable);
    $('#complaintDetailsModal #saveButton').prop('disabled', !isEditable);

    // Show or hide complaint comment section
    if (complaint.complaintComment) {
        $('#complaintDetailsModal #complaintComment').val(complaint.complaintComment);
        $('#complaintCommentRow').show();
    } else {
        $('#complaintCommentRow').hide();
    }

    // Show the modal
    $('#complaintDetailsModal').modal('show');
};


        // Define updateComplaintDetails in the global scope
        window.updateComplaintDetails = function() {
            var complaintId = $('#complaintDetailsModal #complaintId').val();
            var complaintDetails = $('#complaintDetailsModal #complaintDetails').val();

            $.ajax({
                type: 'POST',
                url: 'updateComplaintDetailsByComplaintId',
                data: {
                    complaintId: complaintId,
                    complaintDetails: complaintDetails
                },
                success: function (response) {
                    if (response.includes("Complaint details updated successfully")) {
                        $('#successMessage').text('Complaint details updated successfully!');
                        $('#complaintDetailsModal').modal('hide');
                        $('#successModal').modal('show');
                        fetchComplaints();

                        setTimeout(function () {
                            $('#successModal').modal('hide');
                        }, 3000);
                    } else {
                        showErrorModal(['Unexpected response: ' + response]);
                        setTimeout(function () {
                            $('#errorModal').modal('hide');
                        }, 3000);
                    }
                },
                error: function (xhr, status, error) {
                    handleError("Error while updating complaints: " + error);
                }
            });
        };
    });
</script>



	<script type="text/javascript">
function viewDepartmentDetails(departmentId) {
    $.ajax({
        url: 'department/getDepartmentDetailsById/' + departmentId,
        method: 'GET',
        success: function (department) {
            $('#departmentDetails').html(
                'Department Name: ' + department.departmentName + '<br>' +
                'Contact: ' + department.departmentContactNumber + '<br>' +
                'Email: ' + department.departmentEmail
            );
            $('#departmentModal').modal('show');
        },
        error: function () {
            handleError("Failed to load department details.");
        }
    });
}

function viewEmployeeDetails(employeeId) {
    $.ajax({
        url: 'employee/getEmployeeById',
        method: 'GET',
        data: {
            employeeId: employeeId
        },
        success: function (employee) {
            $('#employeeDetails').html(
                'Employee Name: ' + employee.employeeName + '<br>' +
                'Employee Contact: ' + employee.employeeContactNumber + '<br>' +
                'Employee Email: ' + employee.employeeEmail
            );
            $('#employeeModal').modal('show');
        },
        error: function () {
            handleError("Failed to load employee details.");
        }
    });
}
</script>

	<script type="text/javascript">
    $(document).ready(function () {
        // Load countries and complaint types when the document is ready
        loadCountries();
        populateComplaintTypes();
    });

    function loadCountries() {
        $.ajax({
            url: 'https://api.countrystatecity.in/v1/countries',
            method: 'GET',
            headers: {
                "X-CSCAPI-KEY": "ald3ZWVHZDNwOTZUY09KT3lLam9uQ2VkWWoyNHpBZTUwb3hjUkU0OQ=="
            },
            success: function (response) {
                $('#countryFilter').empty().append(new Option("Select Country", ""));
                response.forEach(country => {
                    $('#countryFilter').append(new Option(country.name, country.iso2));
                });
            },
            error: function (xhr, status, error) {
            	handleError("Error loading countries: " + error);
            }
        });
    }

    function loadStates(countryCode) {
        console.log("Inside loadStates - Received Country Code:", countryCode);

        if (!countryCode) {
        	handleError("Country code is missing!:");
            return;
        }

        $.ajax({
            url: 'https://api.countrystatecity.in/v1/countries/' + countryCode + '/states',
            method: 'GET',
            headers: {
                "X-CSCAPI-KEY": "ald3ZWVHZDNwOTZUY09KT3lLam9uQ2VkWWoyNHpBZTUwb3hjUkU0OQ=="
            },
            success: function (response) {
                $('#stateFilter').empty().append(new Option("Select State", ""));
                response.forEach(state => {
                    $('#stateFilter').append(new Option(state.name, state.iso2));
                });
                $('#cityFilter').empty().append(new Option("Select City", ""));
            },
            error: function (xhr, status, error) {
            	handleError("Error loading states: " + error);
            }
        });
    }

    function loadCities(stateCode) {
        const countryCode = $('#countryFilter').val();

        if (!stateCode || !countryCode) {
        	handleError("State code or Country code is missing!: ");
            return;
        }

        $.ajax({
            url: 'https://api.countrystatecity.in/v1/countries/' + countryCode + '/states/' + stateCode + '/cities',
            method: 'GET',
            headers: {
                "X-CSCAPI-KEY": "ald3ZWVHZDNwOTZUY09KT3lLam9uQ2VkWWoyNHpBZTUwb3hjUkU0OQ=="
            },
            success: function (response) {
                $('#cityFilter').empty().append(new Option("Select City", ""));
                response.forEach(city => {
                    $('#cityFilter').append(new Option(city.name, city.name));
                });
            },
            error: function (xhr, status, error) {
            	handleError("Error loading cities: ");
            }
        });
    }

    function populateComplaintTypes() {
        $.ajax({
            url: 'http://localhost:8080/complaintManagementSystem/complaintTypes',  // Adjust URL as needed
            method: 'GET',
            dataType: 'json',
            success: function (response) {
                $('#complaintTypeFilter').empty().append('<option value="">Select Complaint Type</option>');  // Default option

                response.forEach(type => {
                    $('#complaintTypeFilter').append(new Option(type.complaintType, type.complaintType));
                });
            },
            error: function (xhr, status, error) {
            	 handleError("Error fetching complaint types: " + error);
            }
        });
    }

    </script>
	<script type="text/javascript">
function handleError(message) {
    alert(message); 
}
</script>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js">
    </script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.2/jspdf.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
</body>

</html>