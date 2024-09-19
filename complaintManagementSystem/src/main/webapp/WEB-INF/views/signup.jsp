<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>ResolveX-Sign Up</title>
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
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap')
	;

/* Reseting */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	font-family: 'Poppins', sans-serif;
}

body {
	background: #ecf0f3;
}

.wrapper {
	max-width: 500px;
	min-height: 500px;
	margin: 80px auto;
	padding: 40px 30px 30px 30px;
	background-color: #ecf0f3;
	border-radius: 15px;
	box-shadow: 13px 13px 20px #cbced1, -13px -13px 20px #fff;
}

.wrapper .name {
	font-weight: 600;
	font-size: 1.4rem;
	letter-spacing: 1.3px;
	padding-left: 10px;
	color: #555;
}

.form-control-wrapper {
	position: relative;
}

.form-icon {
	position: absolute;
	left: 10px;
	top: 50%;
	transform: translateY(-50%);
	color: #6c757d;
}

.form-control {
	padding-left: 40px;
	border: none;
	border-bottom: 2px solid #6c757d;
	/* Default bottom border */
	transition: border-bottom-color 0.3s ease;
}

.form-control:hover, .form-control:focus {
	border-bottom-color: #007bff;
	/* Highlight bottom border on hover and focus */
	box-shadow: none;
	/* Disable the default focus shadow */
}

input:hover {
	padding-left: 40px;
	border: none;
	border-bottom: 2px solid #007bff;
	/* Change bottom border color on hover */
}

.form-check-input:checked {
	background-color: #007bff;
	border-color: #007bff;
}

.btn-primary:disabled {
	opacity: 0.65;
}

#sendOtpBtn {
	color: white;
	background-color: #007bff;
}

#registerButton {
	display: block;
	margin: 0 auto;
}

.company-logo {
	display: block;
	margin: 0 auto;
	width: 100px;
	height: 100px;
	border-radius: 50%;
	box-shadow: 0px 0px 3px #5f5f5f, 0px 0px 0px 5px #ecf0f3, 8px 8px 15px
		#a7aaa7, -8px -8px 15px #fff;
}

.nav-buttons a {
	margin-right: 10px;
}

.validError {
	color: red;
}

.validSuccess {
	color: green;
}

#HomePagebtn, #SignInbtn {
	width: 30%;
	height: 40px;
	background-color: #03A9F4;
	color: #fff;
	border-radius: 25px;
	box-shadow: 3px 3px 3px #b1b1b1, -3px -3px 3px #fff;
	letter-spacing: 1.3px;
	font-size: 15px;
	font-weight: bold;
}
/* Background overlay styling */
.modal-backdrop {
	background-color: rgba(0, 0, 0, 0.8);
}

/* Centered modal with small size */
.modal-dialog-centered {
	display: flex;
	justify-content: center;
	align-items: center;
}

/* Modern style for success modal */
.success-modal-content {
	background-color: #28a745;
	color: white;
	border-radius: 10px;
	padding: 20px;
	box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
	text-align: center;
}

/* Modern style for error modal */
.error-modal-content {
	background-color: #dc3545;
	color: white;
	border-radius: 10px;
	padding: 20px;
	box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.3);
	text-align: center;
}

/* Adjust modal body text */
.modal-body p {
	margin: 0;
}

/* Modal title spacing */
.modal-title {
	font-weight: bold;
}

/* Make modal size small */
.modal-sm {
	max-width: 300px;
}
</style>
</head>
<body>
	<div class="wrapper">
		<div class="text-center mb-4">
			<img src="/complaintManagementSystem/res/companyLogo.jpg"
				alt="Company Logo" class="company-logo">
			<div class="nav-buttons mt-3">
				<a id="HomePagebtn" href="HomePage" class="btn btn-secondary"><i
					class="fas fa-home"></i> Home</a> <a id="SignInbtn" href="SignInPage"
					class="btn btn-secondary"><i class="fas fa-sign-in-alt"></i>
					Sign In</a>
			</div>
			<h2 class="name">Sign Up</h2>
		</div>
		<form id="registerForm" onsubmit="registerUser(event)">
			<div class="form-row">
				<div class="col-md-6 mb-3">
					<!-- <label for="firstName" class="form-label">First Name</label> -->
					<div class="form-control-wrapper">
						<i class="fas fa-user form-icon"></i> <input type="text"
							class="form-control" id="firstName" name="firstName"
							placeholder="Enter First Name" onchange="validateFirstName()"
							required maxlength="25">
					</div>
					<span id="errorFirstName" class="validError"></span>
				</div>
				<div class="col-md-6 mb-3">
					<!-- <label for="lastName" class="form-label">Last Name</label> -->
					<div class="form-control-wrapper">
						<i class="fas fa-user form-icon"></i> <input type="text"
							class="form-control" id="lastName" name="lastName"
							placeholder="Enter Last Name" onchange="validateLastName()"
							required maxlength="20">
					</div>
					<span id="errorLastName" class="validError"></span>
				</div>
			</div>
			<div class="form-row">
				<div class="col-md-6 mb-3">
					<!-- <label for="email" class="form-label">Email</label> -->
					<div class="form-control-wrapper">
						<i class="fas fa-envelope form-icon"></i> <input type="email"
							class="form-control" id="email" name="email"
							onchange="checkEmail()" placeholder="Enter email" required>
					</div>
					<button type="button" class="btn btn-info mt-2" id="sendOtpBtn"
						onclick="sendOtp()" disabled>
						<i class="fas fa-envelope"></i>Send OTP
					</button>
					<h6 id="emailError" class="validError"></h6>
					<h6 id="emailSuccess" class="validSuccess"></h6>
				</div>
				<div class="col-md-6 mb-3" id="otpSection" style="display: none;">
					<!-- <label for="otp" class="form-label">Enter OTP</label> -->
					<div class="form-control-wrapper">
						<i class="fas fa-key form-icon"></i> <input type="text"
							class="form-control" id="otp" placeholder="enter OTP">
					</div>
					<button type="button" class="btn btn-success mt-2"
						id="validateOtpBtn" onclick="validateOTP()">
						<i class="fas fa-check-circle"></i> Validate OTP
					</button>
					<h6 id="otpError" class="validError"></h6>
				</div>
			</div>
			<div class="form-row">
				<div class="col-md-6 mb-3">
					<!-- <label for="contactNumber" class="form-label">Contact Number</label> -->
					<div class="form-control-wrapper">
						<i class="fas fa-phone form-icon"></i> <input type="tel"
							class="form-control" id="contactNumber" name="contactNumber"
							placeholder="Enter Contact Number"
							onchange="validateContactNumber()" required>
					</div>
					<span id="errorContactNumber" class="validError"></span>
				</div>
				<div class="col-md-6 mb-3">
					<!-- <label for="altContactNumber" class="form-label">Alternate Contact Number</label> -->
					<div class="form-control-wrapper">
						<i class="fas fa-phone-alt form-icon"></i> <input type="tel"
							class="form-control" id="altContactNumber"
							name="alterContactNumber"
							placeholder="Enter Alternate Contact Number"
							onchange="validateAltContactNumber()">
					</div>
					<span id="errorAltContactNumber" class="validError"></span>
				</div>
			</div>
			<div class="mb-3">
				<!-- <label for="address" class="form-label">Address</label> -->
				<div class="form-control-wrapper">
					<i class="fas fa-address-card form-icon"></i>
					<textarea class="form-control" id="address" name="address" placeholder="Enter Address"
						style="resize: none; height: 50px;" required></textarea>
				</div>
			</div>
			<div class="mb-3 form-check">
				<input type="checkbox" class="form-check-input" id="agreeTerms"
					name="agreement" onchange="validateAgreement()" required> <label
					class="form-check-label" for="agreeTerms"> <i
					class="fas fa-clipboard-check"></i> I agree to the terms and
					conditions
				</label> <span id="errorAgreeTerms" class="validError"></span>
			</div>
			<button type="submit" class="btn btn-primary" id="registerButton"
				disabled>
				<i class="fas fa-user-plus"></i>Register
			</button>
		</form>
	</div>

	<!-- Success Modal -->
	<!-- Success Modal -->
	<div class="modal fade" id="successModal" tabindex="-1" role="dialog"
		aria-labelledby="successModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-sm"
			role="document">
			<div class="modal-content success-modal-content">
				<div class="modal-body text-center">
					<h5 class="modal-title mb-3">Success</h5>
					<p>User registered successfully.</p>
				</div>
			</div>
		</div>
	</div>

	<!-- Error Modal -->
	<div class="modal fade" id="errorModal" tabindex="-1" role="dialog"
		aria-labelledby="errorModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-sm"
			role="document">
			<div class="modal-content error-modal-content">
				<div class="modal-body text-center">
					<h5 class="modal-title mb-3">Error</h5>
					<ul id="errorList"></ul>
				</div>
			</div>
		</div>
	</div>


	<script type="text/javascript">
		let isOTPValidated = false; // Add this global variable

		function validateFirstName() {
			var userName = document.getElementById("firstName").value.trim();
			var isValidLength = userName.replace(/\s+/g, '').length >= 3;
			var isValidCharacters = /^[A-Za-z\s]+$/.test(userName);

			if (isValidLength && isValidCharacters) {
				document.getElementById("errorFirstName").innerHTML = "";
			} else {
				document.getElementById("errorFirstName").innerHTML = "Username must be at least 3 alphabetic characters";
			}
			validateForm();
		}

		function validateLastName() {
			var userName = document.getElementById("lastName").value.trim();
			var isValidLength = userName.replace(/\s+/g, '').length >= 1;
			var isValidCharacters = /^[A-Za-z\s]+$/.test(userName);

			if (isValidLength && isValidCharacters) {
				document.getElementById("errorLastName").innerHTML = "";
			} else {
				document.getElementById("errorLastName").innerHTML = "LastName must be at least 1 alphabetic characters";
			}
			validateForm();
		}

		function checkEmail() {
			const emailInput = document.getElementById('email');
			const emailValue = emailInput ? emailInput.value.trim() : '';
			const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

			if (emailRegex.test(emailValue)) {
				const xhttp = new XMLHttpRequest();
				xhttp.open("GET",
						"/complaintManagementSystem/checkEmailExistence/"
								+ encodeURIComponent(emailValue));
				xhttp.send();

				xhttp.onload = function() {
					if (xhttp.status === 200) {
						const exists = this.responseText === "EmailIDexists";
						if (exists) {
							document.getElementById("emailError").innerHTML = "Email already exists";
							document.getElementById("sendOtpBtn").disabled = true;
							document.getElementById("registerButton").disabled = true;
						} else {
							document.getElementById("emailError").innerHTML = "";
							document.getElementById("sendOtpBtn").disabled = false;
							document.getElementById("registerButton").disabled = true;
						}
					} else {
						console.error('Error fetching email existence:',
								xhttp.status);
					}
					validateForm();
				};
			} else {
				document.getElementById("emailError").innerText = "Please enter a valid email address";
				document.getElementById("sendOtpBtn").disabled = true;
				document.getElementById("registerButton").disabled = true;
			}
			validateForm();
		}

		function sendOtp() {
			const userEmail = document.getElementById('email').value;

			$
					.ajax({
						url : '/complaintManagementSystem/genrateOTPAndSave?email='
								+ userEmail,
						type : 'GET',
						success : function(response) {
							if (response.trim() === 'Exists') {
								document.getElementById('emailError').innerHTML = '';
								document.getElementById('emailSuccess').innerHTML = 'OTP sent to email.';
								document.getElementById('otpSection').style.display = 'block';
								document.getElementById("registerButton").disabled = true;
							} else {
								document.getElementById('emailError').innerHTML = 'OTP is not generated.';
								document.getElementById("registerButton").disabled = true;
							}
							validateForm();
						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.error('Error:', textStatus, errorThrown);
						}
					});
		}

		function validateOTP() {
			const otpValue = document.getElementById('otp').value;
			const userEmail = document.getElementById('email').value;

			if (otpValue != null && otpValue != "") {
				$
						.ajax({
							url : '/complaintManagementSystem/validateEmailVerificationOTP',
							type : 'POST',
							data : {
								otp : otpValue,
								email : userEmail
							},
							success : function(response) {
								if (response.trim() === 'valid') {
									document.getElementById('otpError').innerHTML = '';
									document.getElementById('email').disabled = true;
									document.getElementById('sendOtpBtn').disabled = true;
									document.getElementById('otpSection').style.display = 'none';
									document.getElementById('emailSuccess').innerHTML = 'Email verified successfully.';
									isOTPValidated = true; // Set OTP validated state
								} else {
									document.getElementById("registerButton").disabled = true;
									document.getElementById('otpError').innerHTML = 'Invalid OTP.';
									isOTPValidated = false; // Set OTP validated state
								}
								validateForm();
							},
							error : function(jqXHR, textStatus, errorThrown) {
								console
										.error('Error:', textStatus,
												errorThrown);
								isOTPValidated = false; // Set OTP validated state
								validateForm();
							}
						});
			} else {
				document.getElementById('otpError').innerHTML = 'Please enter a valid OTP.';
				isOTPValidated = false; // Set OTP validated state
				validateForm();
			}
		}

		function validateContactNumber() {
			var contactNumber = document.getElementById("contactNumber").value;
			if (/^\d{10}$/.test(contactNumber)) {
				const xhttp = new XMLHttpRequest();
				xhttp.open("GET",
						"/complaintManagementSystem/checkContactNumberExistence/"
								+ encodeURIComponent(contactNumber));
				xhttp.send();

				xhttp.onload = function() {
					var exists = this.responseText === "contactNumberexists";
					if (exists) {
						document.getElementById("errorContactNumber").innerHTML = "Contact number already exists";
					} else {
						document.getElementById("errorContactNumber").innerHTML = "";
					}
					validateForm();
				};
			} else {
				document.getElementById("errorContactNumber").innerText = "Contact number should be a valid 10-digit number";
			}
			validateForm();
		}

		function validateAltContactNumber() {
			var number = document.getElementById("contactNumber").value;
			var altNumber = document.getElementById("altContactNumber").value;
			var numberRegex = /^[0-9]{10}$/;

			if (numberRegex.test(altNumber) && number !== altNumber) {
				document.getElementById("errorAltContactNumber").innerHTML = "";
			} else {
				document.getElementById("errorAltContactNumber").innerHTML = "Contact and alternate number cannot be same";
			}
			validateForm();
		}

		function validateAgreement() {
			var agreeTerms = document.getElementById("agreeTerms").checked;
			var errorAgreeTerms = document.getElementById("errorAgreeTerms");

			if (!agreeTerms) {
				errorAgreeTerms.innerHTML = "You must agree to the terms and conditions.";
			} else {
				errorAgreeTerms.innerHTML = "";
			}
			validateForm();
		}

		function validateForm() {
			var isFirstNameValid = document.getElementById("errorFirstName").innerHTML === "";
			var isLastNameValid = document.getElementById("errorLastName").innerHTML === "";
			var isEmailValid = document.getElementById("emailError").innerHTML === "";
			var isContactNumberValid = document
					.getElementById("errorContactNumber").innerHTML === "";
			var isAltContactNumberValid = document
					.getElementById("errorAltContactNumber").innerHTML === "";
			var isAgreementValid = document.getElementById("errorAgreeTerms").innerHTML === "";
			var isFormValid = isFirstNameValid && isLastNameValid
					&& isEmailValid && isContactNumberValid
					&& isAltContactNumberValid && isAgreementValid
					&& isOTPValidated;

			console.log('isFormValid:', isFormValid);

			var registerButton = document.getElementById("registerButton");
			registerButton.disabled = !isFormValid;
			console.log('registerButton.disabled:', registerButton.disabled);
		}

		function registerUser(event) {
		    event.preventDefault();

		    var userData = {
		        firstName: document.getElementById('firstName').value,
		        lastName: document.getElementById('lastName').value,
		        email: document.getElementById('email').value,
		        contactNumber: document.getElementById('contactNumber').value,
		        alterContactNumber: document.getElementById('altContactNumber').value,
		        address: document.getElementById('address').value,
		        agreement: document.getElementById('agreeTerms').checked
		    };

		    $.ajax({
		        url: '/complaintManagementSystem/userRegister',
		        type: 'POST',
		        data: JSON.stringify(userData),
		        contentType: 'application/json',
		        success: function(response) {
		            // Show success modal
		            $('#successModal').modal('show');
		            setTimeout(function() {
		                $('#successModal').modal('hide');
		            }, 3000);

		            // Reset the form after successful registration
		            document.getElementById('registerForm').reset();

		            // Optionally reset custom validations and success messages
		            $('#emailSuccess').text('');
		            $('#errorFirstName').text('');
		            $('#errorLastName').text('');
		            $('#errorContactNumber').text('');
		            $('#errorAltContactNumber').text('');
		            $('#emailError').text('');
		        },
		        error: function(xhr) {
		            $('#errorList').empty();

		            if (xhr.status === 400) {
		                var errorMessage = xhr.responseText;
		                $('#errorList').append('<li>' + errorMessage + '</li>');
		                $('#errorModal').modal('show');
		                setTimeout(function() {
		                    $('#errorModal').modal('hide');
		                }, 3000);
		            } else {
		                $('#errorList').append('<li>An unexpected error occurred. Please try again later.</li>');
		                $('#errorModal').modal('show');
		                setTimeout(function() {
		                    $('#errorModal').modal('hide');
		                }, 3000);
		            }
		        }
		    });
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.2/jspdf.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
