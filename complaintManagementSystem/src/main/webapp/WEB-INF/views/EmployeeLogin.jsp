<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ResolveX-Employee Login</title>
    <link rel="shortcut icon"
	href="/complaintManagementSystem/res/title icon.png"
	type="image/x-icon">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css?family=Raleway:400,700');

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Raleway', sans-serif;
        }

        body {
            background-color: #f0f4f8;
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

        .login-container .logo {
            width: 80px;
            margin-bottom: 20px;
        }

        .login-container h2 {
            font-weight: 700;
            margin-bottom: 20px;
            color: #333333;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-control {
            border-radius: 30px;
            padding: 15px 20px;
        }

        .btn-primary {
            border-radius: 30px;
            padding: 10px 20px;
            width: 100%;
            background-color: #007bff;
            border: none;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .forgot-password-link,
        .home-link {
            display: block;
            margin-top: 10px;
            color: #007bff;
        }

        .forgot-password-link:hover,
        .home-link:hover {
            color: #333333;
            text-decoration: none;
        }

        .show-password-icon {
            cursor: pointer;
            border-radius: 30PX;
        }

        .vh-100 {
            height: 100vh;
        }
    </style>
</head>

<body>
    <div class="d-flex justify-content-center align-items-center vh-100">
        <div class="login-container">
            <img src="/complaintManagementSystem/res/companyLogo.jpg" alt="Company Logo" class="logo rounded-circle">
            <h2>ResolveX</h2>
            <h4>Welcome back, Employee</h4>
            <form id="loginForm"  action="employeeLogin" method="post">
                <div class="form-group">
                    <input type="email" class="form-control" id="email" name="email" placeholder="Enter your email" required>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password"
                            required>
                        <div class="input-group-append">
                            <span class="input-group-text show-password-icon"
                                onclick="togglePasswordVisibility('password')">
                                <i class="fas fa-eye"></i>
                            </span>
                        </div>
                    </div>
                </div>
                 <div class="text-center fs-6">
                <c:if test="${not empty error}">
                    <div style="color: red;">${error}</div>
                </c:if>
                </div>
                <button type="submit" class="btn btn-primary">Login</button>
                <a href="ResetPasswordPage" class="forgot-password-link">Forgot Password?</a>
                <a href="HomePage" class="home-link">Home</a>
            </form>
        </div>
    </div>

    <script>
        function togglePasswordVisibility(fieldId) {
            var passwordField = document.getElementById(fieldId);
            var icon = passwordField.nextElementSibling.querySelector('i');

            if (passwordField.type === "password") {
                passwordField.type = "text";
                icon.classList.remove('fa-eye');
                icon.classList.add('fa-eye-slash');
            } else {
                passwordField.type = "password";
                icon.classList.remove('fa-eye-slash');
                icon.classList.add('fa-eye');
            }
        }
    </script>
</body>
</html>