<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ResolveX-Department Login</title>
<link rel="shortcut icon"
	href="/complaintManagementSystem/res/companyLogo.jpg"
	type="image/x-icon">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />

<style type="text/css">
@import url('https://fonts.googleapis.com/css?family=Raleway:400,700');

* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
	font-family: 'Raleway', sans-serif;
}

body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
	background-size: cover;
	height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	background: #ecf0f3;
}

.login-container {
	padding: 40px 30px 30px 30px;
	border-radius: 15px;
	width: 100%;
	max-width: 400px;
	text-align: center;
	background-color: #ecf0f3;
	border-radius: 15px;
	box-shadow: 13px 13px 20px #cbced1, -13px -13px 20px #fff;
}

.vh-100 {
	height: 100vh;
}

.login-container .logo {
	width: 80px;
	margin-bottom: 20px;
}

.login-form h2 {
	margin-bottom: 20px;
	text-align: center;
}

.input-group {
	position: relative;
	margin-bottom: 20px;
}

.input-group i {
	position: absolute;
	left: 10px;
	top: 50%;
	transform: translateY(-50%);
	color: #777;
}

.input-group input {
	width: 100%;
	padding: 10px 40px 10px 40px;
	/* Adjusted padding to include icon space */
	border: 1px solid #ccc;
	border-radius: 5px;
	font-size: 16px;
}

#togglePassword {
	margin-left: 85%;
	right: 10px;
	top: 50%;
	transform: translateY(-50%);
	cursor: pointer;
	color: #777;
}

.form-options {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.forgot-password {
	color: black;
	text-decoration: none;
	font-size: 14px;
}

.forgot-password:hover {
	color: wheat;
	text-decoration: underline;
}

.btn-login {
	width: 100%;
	padding: 10px;
	border: none;
	border-radius: 5px;
	background-color: #007bff;
	color: #fff;
	font-size: 16px;
	cursor: pointer;
}

.btn-login:hover {
	background-color: #0056b3;
}

.btn-home {
	width: 100%;
	padding: 10px;
	border: none;
	border-radius: 5px;
	background-color: #28a745;
	color: #fff;
	font-size: 16px;
	cursor: pointer;
	margin-top: 10px;
}

.btn-home:hover {
	background-color: #218838;
}

@media ( max-width : 480px) {
	.login-container {
		padding: 20px;
	}
	.input-group input {
		padding: 10px 30px 10px 30px; /* Adjust padding for smaller screens */
		font-size: 14px;
	}
	.btn-login, .btn-home {
		padding: 8px;
		font-size: 14px;
	}
}
</style>
</head>
<body>
	<div class="d-flex justify-content-center align-items-center vh-100">
		<div class="login-container">
			<div class="login-form">
				<img src="/complaintManagementSystem/res/companyLogo.jpg"
					alt="Company Logo" class="logo rounded-circle">
				<h2>ResolveX</h2>
				<h4>Welcome back, Department</h4>
				<form action="departmentAdminLogin" method="POST">
					<div class="input-group">
						<i class="fas fa-envelope"></i> <input type="email" name="email"
							id="email" placeholder="Email" required>
					</div>
					<div class="input-group">
						<i class="fas fa-lock"></i> <input type="password" id="password"
							name="password" placeholder="Password" required> <i
							class="fas fa-eye" id="togglePassword"></i>
					</div>
					<div class="text-center fs-6">
						<c:if test="${not empty error}">
							<div style="color: red;">${error}</div>
						</c:if>
					</div>
					<div class="form-options">
						<a href="ResetPasswordPage" class="forgot-password">Forgot Password?</a>
					</div>
					<button type="submit" class="btn-login">
						<i class="fa-solid fa-right-to-bracket"></i>Login
					</button>
				</form>
				<a href="HomePage" class="btn btn-home"><i class="fas fa-home"></i>
					Home</a>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script>
		const togglePassword = document.querySelector('#togglePassword');
		const password = document.querySelector('#password');

		togglePassword.addEventListener('click', function() {
			const type = password.getAttribute('type') === 'password' ? 'text'
					: 'password';
			password.setAttribute('type', type);
			this.classList.toggle('fa-eye-slash');
		});
	</script>

</body>
</html>
