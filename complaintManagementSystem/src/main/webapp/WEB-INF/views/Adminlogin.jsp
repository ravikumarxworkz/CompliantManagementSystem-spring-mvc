<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ResolveX-AdminLogin</title>
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
</head>
<style>
@import url('https://fonts.googleapis.com/css?family=Raleway:400,700');

* {
	box-sizing: border-box;
	margin: 0;
	padding: 0;
	font-family: 'Raleway', sans-serif;
}

section {
	position: relative;
	width: 100%;
	height: 80vh;
	padding: 60px 30px 30px 30px;
	background-color: #ecf0f3;
	box-shadow: 13px 13px 20px #cbced1, -13px -13px 20px #fff;
}

/* Card Styling */
.card {
	margin: 50px auto;
	padding: 40px 30px 30px 30px;
	background-color: #ecf0f3;
	border-radius: 15px;
	box-shadow: 13px 13px 20px #cbced1, -13px -13px 20px #fff;
}

/* Login Image Styling */
.login-image {
	position: absolute;
	border-radius: 2rem;
	height: 100%;
	object-fit: cover;
}

.form-group input {
	padding-left: 40px;
	border: none;
	border-bottom: 2px solid #6c757d;
	/* Default bottom border */
	transition: border-bottom-color 0.3s ease;
}

.form-group input :hover {
	padding-left: 40px;
	border: none;
	border-bottom: 2px solid #007bff;
}

/* Toggle Password Icon Styling */
.toggle-password {
	right: 15px;
	top: 50%;
	transform: translateY(-50%);
	cursor: pointer;
}

/* Positioning and Color of Icons */
.toggle-password i {
	font-size: 20px;
	color: #6c757d;
}
 a {
    text-decoration: none;
    font-size: 0.8rem;
    color: #03A9F4;
}

 a:hover {
  font-size: 1rem;
  text-decoration: none;
    color: #039BE5;
}
</style>
</head>

<body>
	<section>
		<div class="container py-5 h-100">
			<div
				class="row d-flex justify-content-center align-items-center h-100">
				<div class="col col-xl-10">
					<div class="card" style="border-radius: 1rem;">
						<div class="row g-0">
							<!-- Left Image Section -->
							<div class="col-md-6 col-lg-5 d-none d-md-block">
								<img src="/complaintManagementSystem/res/companyLogo.jpg"
									alt="login form" class="img-fluid login-image" />
							</div>
							<!-- Right Form Section -->
							<div class="col-md-6 col-lg-7 d-flex align-items-center">
								<div class="card-body p-4 p-lg-5 text-black">

									<form id="login-form" action="adminLogin" method="POST">
										<!-- Logo Section -->
										<div class="d-flex align-items-center mb-3 pb-1">
											<i class="fas fa-cubes fa-2x me-3" style="color: #ff6219;"></i>
											<span class="h1 fw-bold mb-0">ResolveX</span>
										</div>
										<!-- Form Heading -->
										<h5 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Welcome
											Back Admin</h5>

										<!-- Email Input -->
										<div class="form-group mb-4">
											<input type="email" id="email"
												class="form-control form-control-lg" name="email"
												placeholder="Email address" required>
										</div>

										<!-- Password Input with Show/Hide Toggle -->
										<div class="form-group mb-4 position-relative">
											<input type="password" id="password"
												class="form-control form-control-lg" name="password"
												placeholder="Password" required> <i
												class="far fa-eye position-absolute toggle-password"
												id="togglePassword"></i>
										</div>
										<div class="text-center fs-6">
											<c:if test="${not empty error}">
												<div style="color: red;">${error}</div>
											</c:if>
										</div>

										<!-- Login Button -->
										<div class="pt-1 mb-4">
											<button class="btn btn-dark btn-lg btn-block" type="submit">Login</button>
										</div>

										<!-- Terms and Policy Links -->
										<a href="ResetPasswordPage" class="forgot-password-link">Forgot
											Password?</a> <span>or</span> <a href="HomePage" class="home-link">Home</a> <a
											href="#!" class="small text-muted">Terms of use.</a> <a
											href="#!" class="small text-muted">Privacy policy</a>
									</form>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<script>
		document
				.addEventListener(
						'DOMContentLoaded',
						function() {
							const togglePassword = document
									.getElementById('togglePassword');
							const passwordField = document
									.getElementById('password');

							togglePassword
									.addEventListener(
											'click',
											function() {
												// Toggle the type attribute
												const type = passwordField
														.getAttribute('type') === 'password' ? 'text'
														: 'password';
												passwordField.setAttribute(
														'type', type);

												// Toggle the eye slash icon
												this.classList
														.toggle('fa-eye-slash');
											});
						});
	</script>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="https://kit.fontawesome.com/a076d05399.js"></script>
</body>

</html>
