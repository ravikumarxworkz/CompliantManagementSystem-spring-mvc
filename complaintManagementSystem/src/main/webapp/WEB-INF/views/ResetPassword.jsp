<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ResolveX - Reset Password 🔑</title>
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
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap')
	;

/* Resetting */
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
	max-width: 400px;
	min-height: 500px;
	margin: 80px auto;
	padding: 40px 30px 30px 30px;
	background-color: #ecf0f3;
	border-radius: 15px;
	box-shadow: 13px 13px 20px #cbced1, -13px -13px 20px #fff;
}

.logo {
	width: 80px;
	margin: auto;
}

.logo img {
	width: 100%;
	height: 80px;
	object-fit: cover;
	border-radius: 50%;
	box-shadow: 0px 0px 3px #5f5f5f, 0px 0px 0px 5px #ecf0f3, 8px 8px 15px
		#a7aaa7, -8px -8px 15px #fff;
}

.wrapper .name {
	font-weight: 600;
	font-size: 1.4rem;
	letter-spacing: 1.3px;
	padding-left: 10px;
	color: #555;
}

.wrapper .form-field input, .wrapper .form-field select {
	width: 100%;
	display: block;
	border: none;
	outline: none;
	background: none;
	font-size: 1.2rem;
	color: #666;
	padding: 10px 15px 10px 10px;
}

.wrapper .form-field {
	padding-left: 10px;
	margin-bottom: 20px;
	border-radius: 20px;
	box-shadow: inset 8px 8px 8px #cbced1, inset -8px -8px 8px #fff;
}

.wrapper .btn {
	box-shadow: none;
	width: 100%;
	height: 40px;
	background-color: #03A9F4;
	color: #fff;
	border-radius: 25px;
	box-shadow: 3px 3px 3px #b1b1b1, -3px -3px 3px #fff;
	letter-spacing: 1.3px;
	font-weight: bold;
}

.wrapper .btn:hover {
	background-color: #039BE5;
}

.wrapper a {
	text-decoration: none;
	font-size: 0.8rem;
	color: #03A9F4;
}

.wrapper a:hover {
	color: #039BE5;
}

.validError {
	color: red;
}

.validSuccess {
	color: green;
}
#HomePage {
    width: 100%;
    height: 40px;
    background-color: #03A9F4;
    color: #fff;
    border-radius: 25px;
    box-shadow: 3px 3px 3px #b1b1b1,
        -3px -3px 3px #fff;
    letter-spacing: 1.3px;
    font-size: 15px;
    font-weight: bold;
}

.wrapper .btn:hover {
    background-color: #039BE5;
}

.wrapper a {
    text-decoration: none;
    font-size: 0.8rem;
    color: #03A9F4;
}

.wrapper a:hover {
    color: #039BE5;
}

@media ( max-width : 380px) {
	.wrapper {
		margin: 30px 20px;
		padding: 40px 15px 15px 15px;
	}
}
</style>
</head>

<body>
	<div class="wrapper">
		<div class="logo">
			<img src="/complaintManagementSystem/res/companyLogo.jpg" alt="">
		</div>
		<div class="text-center mt-4 name">ResolveX</div>
		<div class="text-center mt-4 name">Reset Password</div>
		<form class="p-3 mt-3">
			<div class="form-field d-flex align-items-center">
				<select class="form-control" id="role" required>
					<option value="">Select Role</option>
					<option value="user">User</option>
					<option value="admin">Admin</option>
					<option value="department">Department</option>
					<option value="employee">Employee</option>
				</select>
			</div>
			<div class="form-field d-flex align-items-center">
				<input type="email" class="form-control" id="email"
					placeholder="Enter your email" required>
			</div>
			<button type="button" id="send-reset-link"
				class="btn btn-primary btn-block" onclick="ResetPasswordLink()"
				disabled>Send Reset Password</button>
				<a id="HomePage" href="HomePage" class="btn btn-block mt-3">
				Home</a>
		</form>
		<div class="text-center fs-6">
			<span class="validSuccess" id="emailSuccess"></span> <span
				class="validError" id="emailError"></span>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
		// Validate email and role input
		document.getElementById('email')
				.addEventListener('input', validateForm);
		document.getElementById('role')
				.addEventListener('change', validateForm);

		function validateForm() {
			const email = document.getElementById('email').value;
			const role = document.getElementById('role').value;
			const isValidEmail = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);

			// Enable or disable button based on validation
			document.getElementById('send-reset-link').disabled = !(isValidEmail && role);

			if (isValidEmail) {
				document.getElementById('emailError').innerHTML = '';
			} else {
				document.getElementById('emailError').innerHTML = 'Please enter a valid email address.';
			}
		}

		// Send reset link function
		function ResetPasswordLink() {
			const userEmail = document.getElementById('email').value;
			const userRole = document.getElementById('role').value;

			$
					.ajax({
						url : '/complaintManagementSystem/reset-password',
						type : 'POST',
						data : {
							email : userEmail,
							role : userRole
						},
						success : function(response) {
							if (response.trim() === 'Exists') {
								document.getElementById('emailError').innerHTML = '';
								document.getElementById('emailSuccess').innerHTML = 'New password sent to your email.';
								document.getElementById('email').value = ''; // Clear email
								document.getElementById('role').value = ''; // Clear role
								document.getElementById('send-reset-link').disabled = true; // Disable button
							} else {
								document.getElementById('emailError').innerHTML = 'Email does not exist for the selected role.';
								document.getElementById('emailSuccess').innerHTML = '';
							}
						},
						error : function(jqXHR, textStatus, errorThrown) {
							console.error('Error:', textStatus, errorThrown);
						}
					});
		}
	</script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>
