<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
// Prevent caching
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<c:if
	test="${empty sessionScope.loggedInEmployeeEmail || empty sessionScope.loggedInEmployeeId}">
	<c:redirect url="index.jsp" />
</c:if>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ResolveX-Employee</title>
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
<style>
@import url('https://fonts.googleapis.com/css?family=Raleway:400,700');

* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
	font-family: 'Raleway', sans-serif;
}

#employeePhoto {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 250px;
	border-radius: 50%;
	height: 250px;
}

/* body {
	font-family: 'Roboto', sans-serif;
	background-color: #D6D4E0;
} */
.sidebar {
	background-color: #D5C6E0;
	padding: 20px;
	height: 100vh;
}

.sidebar-header {
	text-align: center;
}

.sidebar-header img {
	width: 100px;
	height: 100px;
}

.nav-link {
	color: #7D8CA3;
	font-weight: bold;
}

.nav-link.active {
	background-color: #98AFC7;
	color: #fff;
}

#logout-link {
	color: red;
}

#logout-link:hover {
	color: red;
	font-size: larger;
	font-weight: bold;
}

.content {
	padding: 20px;
	background: #ecf0f3;
}

.content-section {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.card {
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	border-radius: 15px;
}

.card-body {
	padding: 15px;
}

.card-title {
	color: black;
	font-weight: bold;
}

.card-subtitle {
	color: #D4A5A5;
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

@media ( max-width : 768px) {
	.sidebar {
		width: 100%;
		height: auto;
	}
	.content {
		padding: 10px;
	}
}
</style>
</head>

<body>
	<c:set var="profile" value="${employeeDto}" />
	<div class="container-fluid">
		<div class="row">
			<div class="col-md-3 col-lg-2 sidebar">
				<div class="sidebar-header">
					<img id="employeePhotoSide"
						src="display?imagePath=${profile.employeeImagePath}"
						alt="Employee Photo" class="img-fluid rounded-circle">
					<h5 class="mt-3">${profile.employeeName}</h5>
				</div>
				<ul class="nav flex-column">
					<li class="nav-item"><a class="nav-link active" href="#"
						id="profile-link">Profile</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						id="change-password-link">Change Password</a></li>
					<li class="nav-item"><a class="nav-link" href="#"
						id="complaints-link">Complaints</a></li>
					<li class="nav-item"><a style="color: red;" class="nav-link"
						href="/complaintManagementSystem/employeeLogOut" id="logout-link">Logout</a></li>

				</ul>
			</div>
			<div class="col-md-9 col-lg-10 content">
				<div id="profile-section" class="content-section">
					<h2 class="mb-4">Profile</h2>
					<div class="row">
						<div class="col-md-4">
							<input type="hidden" id="employeeId"
								value="${sessionScope.loggedInEmployeeId}" /> <img
								id="employeePhoto"
								src="display?imagePath=${profile.employeeImagePath}"
								alt="Employee Photo" class="img-fluid rounded-circle">
							<div id="uploadSection" style="display: none; margin-top: 20px;">
								<label for="newPhoto" class="btn btn-warning">Upload New
									Photo <input type="file" id="newPhoto" name="imageFile"
									accept="image/*" style="display: none;">
								</label> <img id="photoPreview" src="#" alt="Preview Image"
									class="img-fluid mt-3" style="display: none;">
							</div>
						</div>
						<div class="col-md-8">
							<table class="table table-borderless">
								<tbody>
									<tr>
										<td><i class="fas fa-id-badge"></i> Employee ID:</td>
										<td id="employee-id">${profile.employeeId}</td>
									</tr>
									<tr>
										<td><i class="fas fa-user"></i> Name:</td>
										<td id="employee-name">${profile.employeeName}</td>
									</tr>
									<tr>
										<td><i class="fas fa-envelope"></i> Email:</td>
										<td id="employee-email">${profile.employeeEmail}</td>
									</tr>
									<tr>
										<td><i class="fas fa-phone"></i> Contact Number:</td>
										<td id="employee-contact">${profile.employeeContactNumber}</td>
									</tr>
									<tr>
										<td><i class="fas fa-user-tag"></i> Status:</td>
										<td id="employee-status">${profile.employeeStatus}</td>
									</tr>
									<tr>
										<td><i class="fas fa-building"></i> Department Name:</td>
										<td id="employee-departmentName">${profile.departmentName}</td>
									</tr>
								</tbody>
							</table>
							<button class="btn btn-primary" id="editBtn">
								<i class="fas fa-edit"></i> Edit Profile
							</button>
							<div class="btn-group mt-3" id="actionButtons"
								style="display: none;">
								<button type="submit" class="btn btn-success" id="submitBtn">
									<i class="fas fa-check"></i> Submit
								</button>
								<button type="button" class="btn btn-secondary ml-2"
									id="cancelBtn">
									<i class="fas fa-times"></i> Cancel
								</button>
							</div>
						</div>
					</div>
				</div>


				<div id="change-password-section" class="content-section d-none">
					<h2 class="mb-4">Change Password</h2>
					<div class="card">
						<div class="card-body">
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
										<input type="password" class="form-control"
											id="confirmPassword" placeholder="Enter confirmPassword"
											name="confirmPassword" required onblur="validatePassword()">
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
				<div id="complaints-section" class="content-section d-none">
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
								<div class="card text-white dashBoradNewComplaints bg-warning">
									<div class="card-body">
										<h5 class="card-title">
											<i class="fas fa-plus-circle"></i> New Complaints
										</h5>
										<p class="card-text" id="newComplaints">0</p>
									</div>
								</div>
							</div>
							<div class="col-md-4">
								<div class="card text-white" style="background-color: #28a745;">
									<div class="card-body">
										<h5 class="card-title">
											<i class="fas fa-check-circle"></i> Closed
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
									<div class="d-flex justify-content-start mb-3">
									<div class="dropdown mb-3">
										<button class="btn btn-info dropdown-toggle"
											type="button" id="dropdownMenuButton"
											data-bs-toggle="dropdown" aria-haspopup="true"
											aria-expanded="false"><i class="fas fa-filter"></i>Filter by Status</button>
										<div class="dropdown-menu"
											aria-labelledby="dropdownMenuButton">
											<a class="dropdown-item text-primary" href="#"
												onclick="filterComplaints('all')">
											<i class="fas fa-list"></i>All Complaints</a> <a
												class="dropdown-item text-success" href="#"
												onclick="filterComplaints('In Progress')"><i class="fas fa-plus-circle"></i>New Complaints</a>
											<a class="dropdown-item text-danger" href="#"
												onclick="filterComplaints('Closed')"><i class="fas fa-check-circle"></i> Closed Complaints</a>
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
											<thead class="table-info">
												<tr>
													<th scope="col">Complaint ID</th>
													<th scope="col">Complaint Type</th>
													<th scope="col">Status</th>
													<th scope="col">Department</th>
													<th scope="col">User</th>
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
				<div id="viewComplaintModal" class="modal fade" tabindex="-1"
					role="dialog">
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
										<div class="col-md-12 form-group">
											<label for="status" class="form-label"> <i
												class="fas fa-tag form-icon"></i> Status
											</label> <select id="status" class="form-control"
												onchange="handleStatusChange()">
												<option value="">select status</option>
												<option value="Closed">Closed</option>
												<option value="Not Resolved">Not Resolved</option>
											</select>
										</div>
									</div>
									<div class="row" id="commentSection">
										<div class="col-md-12 form-group">
											<label for="statusComments">Comments</label>
											<textarea class="form-control" id="statusComments" rows="3"
												placeholder="Add your comments here"></textarea>
										</div>
									</div>
								</form>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-primary"
									id="saveComplaintButton" onclick="triggerOtp()">Save &
									Send OTP</button>
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>



				<!-- OTP Modal -->
				<div id="otpModal" class="modal fade" tabindex="-1" role="dialog"
					data-backdrop="static" data-keyboard="false">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">Enter OTP</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<form id="otpForm">
									<div class="form-group">
										<label for="otpInput">OTP</label> <input type="text"
											class="form-control" id="otpInput" placeholder="Enter OTP">
									</div>
								</form>
								<div id="otpErrorMessage" style="display: none;"></div>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-primary"
									onclick="submitOtp()">Submit OTP</button>
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">Close</button>
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
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<p id="departmentDetails"></p>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>

				<!-- Employee Modal -->
				<div class="modal fade" id="userModal" tabindex="-1" role="dialog"
					aria-labelledby="employeeModalLabel" aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="employeeModalLabel">Employee
									Details</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<p id="userDetails"></p>
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
					role="dialog" aria-labelledby="successModalLabel"
					aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="successModalLabel">Success</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<p id="successMessage"></p>
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal">OK</button>
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
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<p id="errors"></p>
								<ul id="errorList">
									<!-- Error messages will be dynamically inserted here -->
								</ul>
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
	<script>
  // Get references to DOM elements
  const profileLink = document.getElementById('profile-link');
  const changePasswordLink = document.getElementById('change-password-link');
  const complaintsLink = document.getElementById('complaints-link');
  const profileSection = document.getElementById('profile-section');
  const changePasswordSection = document.getElementById('change-password-section');
  const complaintsSection = document.getElementById('complaints-section');
  const editProfileBtn = document.getElementById('edit-profile-btn');
  const changePasswordForm = document.getElementById('change-password-form');

  // Function to show a specific section
  function showSection(sectionId) {
    profileSection.classList.add('d-none');
    changePasswordSection.classList.add('d-none');
    complaintsSection.classList.add('d-none');
    document.getElementById(sectionId).classList.remove('d-none');
  }

  // Event listeners for navigation links
  profileLink.addEventListener('click', () => showSection('profile-section'));
  changePasswordLink.addEventListener('click', () => showSection('change-password-section'));
  complaintsLink.addEventListener('click', () => {
    showSection('complaints-section');
    fetchEmployeeComplaints(); // Fetch complaints data from backend when 'Complaints' is clicked
  });
 
</script>
	<script type="text/javascript">
document.getElementById('editBtn').addEventListener('click', function () {
    // Show the new profile image upload section and action buttons
    document.getElementById('uploadSection').style.display = 'block';
    document.getElementById('editBtn').style.display = 'none';
    document.getElementById('actionButtons').style.display = 'block';
});

document.getElementById('cancelBtn').addEventListener('click', function () {
    // Hide the upload section and action buttons, show the edit button
    document.getElementById('uploadSection').style.display = 'none';
    document.getElementById('editBtn').style.display = 'block';
    document.getElementById('actionButtons').style.display = 'none';
    // Optionally, reset the preview image or any other fields
    document.getElementById('photoPreview').style.display = 'none';
});

document.getElementById('newPhoto').addEventListener('change', function (event) {
    if (event.target.files.length > 0) {
        previewNewPhoto(event);
    }
});

function previewNewPhoto(event) {
    var file = event.target.files[0];
    var reader = new FileReader();

    reader.onload = function (e) {
        document.getElementById('employeePhoto').src = e.target.result; // Update the profile image preview
    };

    reader.readAsDataURL(file);
}

document.getElementById('submitBtn').addEventListener('click', function () {
    var formData = new FormData();
    var fileInput = document.getElementById('newPhoto');
    var employeeId = document.getElementById('employeeId').value;

    if (fileInput.files.length > 0) {
        formData.append('imageFile', fileInput.files[0]);
    }
    formData.append('employeeId', employeeId);

    $.ajax({
        url: '/complaintManagementSystem/employee/updateEmployeeImage',
        type: 'POST',
        data: formData,
        contentType: false,
        processData: false,
        success: function (response) {
            if (response.message === 'Image updated successfully') {
                $('#successMessage').text('Image updated successfully!');
                $('#successModal').modal('show');
                // Optionally, refresh the profile image
                document.getElementById('employeePhoto').src = 'display?imagePath=' + response.newImagePath;
                document.getElementById('employeePhotoSide').src = 'display?imagePath=' + response.newImagePath;
                document.getElementById('uploadSection').style.display = 'none';
                document.getElementById('editBtn').style.display = 'block';
                document.getElementById('actionButtons').style.display = 'none';
            } else {
                alert('Failed to update the image.');
            }
        },
        error: function (xhr, status, error) {
            console.error('Error:', error);
            alert('An error occurred while updating the image.');
        }
    });
});
</script>

	<script>
        $(document).ready(function () {
            function updateDashboard() {
            const employeeId = '${sessionScope.loggedInEmployeeId}';
                $.ajax({
                    url: '/complaintManagementSystem/dashboardDataOfEmployee', // Endpoint to fetch dashboard data
                    type: 'GET',
                    data:{
                    employeeId:employeeId,	
                    },
                    dataType: "json",
                    success: function (response) {
                       $('#totalComplaints').text(response.totalComplaints);
                        $('#newComplaints').text(response.newComplaints);
                        $('#closedComplaints').text(response.closedComplaints);
                    },
                    error: function (xhr, status, error) {
                        console.error('Error fetching dashboard data:', error);
                    }
                });
            }
            updateDashboard();
            setInterval(updateDashboard, 30000);
        });
    </script>
	<script type="text/javascript">
        let currentPageComplaints = 1;
        let pageSizeComplaints = 10;
        let currentStatus = 'all';
        let currentSearchQuery = '';

        function fetchEmployeeComplaints(page = currentPageComplaints, status = currentStatus, query = currentSearchQuery) {
               const employeeId = '${sessionScope.loggedInEmployeeId}';
        	$.ajax({
                url: '/complaintManagementSystem/getAllComplaintsByEmployee',
                type: 'GET',
                data: {
                	employeeId:employeeId,
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
                    console.error('Error fetching complaints:', error);
                }
            });
        }

        function searchComplaints() {
            currentSearchQuery = $('#SearchComplaint').val();
            fetchEmployeeComplaints(1, currentStatus, currentSearchQuery);
        }

        function filterComplaints(status) {
            currentPageComplaints = 1;
            currentStatus = status;
            fetchEmployeeComplaints(currentPageComplaints, currentStatus, currentSearchQuery);
        }

        function populateComplaintTable(complaints) {
            const tableBody = $('#complaintsTableBody');
            tableBody.empty();

            if (complaints && complaints.length > 0) {
                complaints.forEach((complaint) => {
                    const isDepartmentAssigned = complaint.departmentId ? true : false;
                    const isUserAssigned = complaint.userId ? true : false;

                    const departmentButton = isDepartmentAssigned
                        ? `<button class='btn btn-info btn-sm' onclick='viewDepartmentDetails("`
                        + JSON.stringify(complaint.departmentId)
                        + `")'> <i class='fas fa-building'></i>Department</button>`
                        : `<button class='btn btn-secondary btn-sm' disabled>Not Assigned</button>`;

                    const userButton = isUserAssigned
                        ? `<button class='btn btn-primary btn-sm' onclick='viewUserDetails("`
                        + JSON.stringify(complaint.userId)
                        + `")'> <i class='fas fa-user'></i>user</button>`
                        : `<button class='btn btn-secondary btn-sm' disabled>Not Assigned</button>`;


                    const row = "<tr>"
                        + "<td>" + complaint.complaintId + "</td>"
                        + "<td>" + complaint.complaintType + "</td>" // Display complaint type
                        + "<td>" + complaint.status + "</td>"
                        + "<td>" + departmentButton + "</td>" // Replace with button for department
                        + "<td>" + userButton + "</td>"   // Replace with button for employee
                        + "<td><button class='btn btn-warning btn-sm' onclick='viewComplaint("
                        + JSON.stringify(complaint.complaintId)
                        + ")'><i class='fas fa-eye'></i>view</button></td>"
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
                paginationContainer.append(
                    '<li class="page-item ' + activeClass + '">'
                    + '<a class="page-link" href="#" onclick="goToPageComplaints(' + i + ')">' + i + '</a>'
                    + '</li>'
                );
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
                fetchEmployeeComplaints(currentPageComplaints);
            }
        }

        function nextPageComplaints() {
        	fetchEmployeeComplaints(currentPageComplaints + 1);
        }

        function goToPageComplaints(page) {
            currentPageComplaints = page;
            fetchEmployeeComplaints(currentPageComplaints);
        }

        function updatePageSize(newSize) {
            pageSizeComplaints = parseInt(newSize, 10);
            currentPageComplaints = 1; // Reset to the first page
            fetchEmployeeComplaints(currentPageComplaints);
        }

        $(document).ready(function () {
        	fetchEmployeeComplaints(currentPageComplaints);
            $('#SearchComplaint').on('keyup', searchComplaints);
        });
       
    </script>

	<script type="text/javascript">
	function viewComplaint(complaintId) {
	    $.ajax({
	        url: '/complaintManagementSystem/getComplaintDetailsById',
	        method: 'GET',
	        dataType: 'json',
	        data: { id: complaintId },
	        success: function (response) {
	            // Populate fields with response data
	            document.getElementById('complaintId').value = response.complaintId || '';
	            document.getElementById('complaintType').value = response.complaintType || '';
	            document.getElementById('country').value = response.country || '';
	            document.getElementById('state').value = response.state || '';
	            document.getElementById('city').value = response.city || '';
	            document.getElementById('cityArea').value = response.cityArea || '';
	            document.getElementById('complaintAddress').value = response.complaintAddress || '';
	            document.getElementById('complaintDetails').value = response.complaintDetails || '';
	            document.getElementById('createdAt').value = response.createdAt ? new Date(response.createdAt).toLocaleDateString() : '';
	            document.getElementById('updatedAt').value = response.updatedAt ? new Date(response.updatedAt).toLocaleDateString() : '';
	            document.getElementById('status').value = response.status || '';
	            document.getElementById('statusComments').value = response.complaintComment || '';

	            // Handle UI updates based on the complaint status
	            handleStatusChange(response.status);
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
	            document.getElementById('statusComments').value = response.complaintComment || '';

	            const status = response.status;
	            const comments = response.complaintComment;

	            // Disable fields if status is "Closed" or "Not Resolved" and comments exist
	            if ((status === 'Closed' || status === 'Not Resolved') && comments) {
	                document.getElementById('status').disabled = true;
	                document.getElementById('statusComments').disabled = true;
	                document.getElementById('saveComplaintButton').disabled = true;
	            } else {
	                document.getElementById('status').disabled = false;
	                document.getElementById('statusComments').disabled = false;
	                document.getElementById('saveComplaintButton').disabled = false;
	                handleStatusChange(response.status); // Trigger OTP visibility based on status
	            }
	            
	            

	            // Show the complaint modal
	            $('#viewComplaintModal').modal('show');
	        },
	        error: function (xhr, status, error) {
	            console.error("Error fetching complaint details: ", error);
	        }
	    });
	}

	function handleStatusChange(status) {
	    const statusElement = document.getElementById('status');
	    const commentsElement = document.getElementById('statusComments');
	    const saveButton = document.getElementById('saveComplaintButton');
	    const sendOtpButton = document.getElementById('sendOtpButton');
	    const commentSection = document.getElementById('commentSection');

	    // Ensure the elements are present in the DOM
	    if (!statusElement || !commentsElement || !saveButton || !sendOtpButton || !commentSection) {
	        console.error("One or more elements are missing in the DOM.");
	        return;
	    }

	    // Handle status-based UI changes
	    if (status === 'Closed' || status === 'Not Resolved') {
	        // Disable the status dropdown
	        statusElement.disabled = true;

	        // Make the comments field read-only
	        commentsElement.readOnly = true;

	        // Hide the Save and Send OTP buttons
	        saveButton.style.display = 'none';
	        sendOtpButton.style.display = 'none';
	    } else {
	        // Enable the status dropdown
	        statusElement.disabled = false;

	        // Make the comments field editable
	        commentsElement.readOnly = false;

	        // Show the Save and Send OTP buttons
	        saveButton.style.display = 'block';
	        sendOtpButton.style.display = 'block';
	    }

	    // Show the comment section if status is "Not Resolved"
	    if (status === 'Not Resolved') {
	        commentSection.style.display = 'block';
	    } else {
	        commentSection.style.display = 'none';
	    }
	}

	// Optional: Trigger status change handler when dropdown changes
	document.getElementById('status').addEventListener('change', function() {
	    handleStatusChange(this.value);
	});



  

     // Function to handle the complaint assignment submission
     function triggerOtp() {
    const complaintId = document.getElementById('complaintId').value;
    	 console.log(complaintId);
    const status = document.getElementById('status').value;
    const comments = document.getElementById('statusComments').value;
       
    if (status === '') {
        alert("select complaint status one of them.");
        return;
    }
    // Validate mandatory comments for certain statuses
    if ((status === 'Closed' || status === 'Not Resolved') && comments.trim() === '') {
        alert("Comments are mandatory for this status.");
        return;
    }

    // Send request to backend to send OTP
    $.ajax({
        url: '/complaintManagementSystem/sendComplaintCloseOtp',
        type: 'POST',
        data: {
            complaintId: complaintId
        },
        success: function(response) {
            if (response === "otp sent success") {
                // If OTP sent successfully, show the OTP modal
                $('#otpModal').modal('show');
            } else {
                alert("Failed to send OTP. Please try again.");
            }
        },
        error: function(error) {
            alert("An error occurred: " + error.responseText);
        }
    });


}

     // Function to validate OTP and update complaint
   function submitOtp() {
    const otp = document.getElementById('otpInput').value;
    const complaintId = document.getElementById('complaintId').value;
    const status = document.getElementById('status').value;
    const comments = document.getElementById('statusComments').value;

    $.ajax({
        url: '/complaintManagementSystem/validateOtpAndUpdateComplaint',
        method: 'POST',
        dataType: 'json',
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        data: {
            complaintId: complaintId,
            status: status,
            comments: comments,
            otp: otp
        },
        success: function (response) {
            if (response.success) {
                // Close OTP modal and view complaint modal
                $('#otpModal').modal('hide');
                $('#viewComplaintModal').modal('hide');

                // Show success modal with message
                $('#successMessage').text(response.message);
                $('#successModal').modal('show');

                // Refresh employee complaints list
                fetchEmployeeComplaints();
            } else {
                // Show error message in red inside OTP modal
                $('#otpErrorMessage').text(response.message).css('color', 'red').show();
            }
        },
        error: function (xhr, status, error) {
            // Handle general errors
            console.error("Error updating complaint:", xhr.responseText);
            $('#otpErrorMessage').text("An unexpected error occurred. Please try again.").css('color', 'red').show();
        }
    });
}
     
     </script>
	<script type="text/javascript">
        function viewDepartmentDetails(departmentId) {
          
            // Make an AJAX request to fetch the department details
            $.ajax({
                url: 'department/getDepartmentDetailsById/' + departmentId,
                method: 'GET',
                success: function (department) {
                    // Populate the modal with the department details
                    $('#departmentDetails').html(
                        'Department Name: ' + department.departmentName + '<br>' +
                        'Contact: ' + department.departmentContactNumber + '<br>' +
                        'Email: ' + department.departmentEmail
                    );
                    // Show the modal
                    $('#departmentModal').modal('show');
                },
                error: function () {
                    alert("Failed to load department details.");
                }
            });
        }
        function viewUserDetails(UserId) {
            $.ajax({
                url: 'getUserById',
                method: 'GET',
                data: {
                	id: UserId
                },
                success: function (user) {
                    // Populate the modal with the department details
                    $('#userDetails').html(
                        'User Name: ' + user.firstName + '<br>' +
                        'User Contact: ' + user.contactNumber + '<br>' +
                        'User Email: ' + user.email
                    );
                    // Show the modal
                    $('#userModal').modal('show');
                },
                error: function () {
                    alert("Failed to load user details.");
                }
            });
        }
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
                    const employeeId = '${sessionScope.loggedInEmployeeId}';
                    

                    var formData = {
                    	userId:employeeId,
                        oldPassword: oldPassword,
                        newPassword: newPassword,
                        confirmPassword: confirmPassword
                    };

                    $
                        .ajax({
                            url: '/complaintManagementSystem/employee/changeEmployeePassword',
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
</body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js">
    </script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.2/jspdf.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>

</html>