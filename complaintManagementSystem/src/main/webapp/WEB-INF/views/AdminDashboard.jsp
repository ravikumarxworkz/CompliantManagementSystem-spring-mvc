 <%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ResolveX-Admin</title>
    <link rel="shortcut icon" href="/complaintManagementSystem/res/title icon.png" type="image/x-icon">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" />
    <link rel="stylesheet" href="/complaintManagementSystem/res/chat.css">
    <link rel="stylesheet" href="/complaintManagementSystem/res/chat.css">
    <style>
        @import url("https://fonts.googleapis.com/css?family=Raleway:400,700");

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Raleway, sans-serif;
        }

        /*************************************container / sidebar/main content styling  css start *************************************/
        /* General styles */
        .container-fluid {
            display: flex;
        }

        .content-section {
            display: none;
        }

        .header-logo {
            border-radius: 50%;
        }

        #sidebar {
            width: 250px;
            transition: all 0.3s ease;
            left: 0;
            margin-left: -12px;
            height: auto;
            /* Allows height to grow based on content */
            min-height: 100vh;

        }

        #main-content {
            flex-grow: 1;
            transition: all 0.3s ease;
            padding: 20px;
            transition: margin-left 0.3s ease;
            background-color: #ecf0f1;

        }

        #sidebar .nav-link {
            color: #adb5bd;
            transition: color 0.2s;
        }

        #sidebar .nav-link:hover {
            color: #ffffff;
            background-color: #495057;
            border-radius: 5px;
        }

        #sidebar .dropdown-menu {
            background-color: #495057;
            border: none;
            padding: 0;
        }

        #sidebar .dropdown-item {
            color: #adb5bd;
            padding: 10px 15px;
            transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
        }

        #sidebar .dropdown-item:hover {
            color: #ffffff;
            background-color: #252729;
        }

        #sidebar .nav-link.active {
            background-color: #217fd2;
            color: #ffffff;
            border-radius: 5px;
        }

        .nav-item .dropdown-menu {
            /* position: static;
        width: 100%; */
            background-color: #f8f9fa;
        }

        .nav-item .dropdown-menu a {
            padding: 0.5rem 1rem;
        }

        .nav-link.active {
            background-color: #92A8D1;
            color: white;
        }

        /* Hidden sidebar */
        .sidebar-hidden #sidebar {
            width: 0;
            padding: 0;
            margin-left: -50px;
            background-color: transparent;
            transition: width 0.3s ease;
        }

        .sidebar-hidden #sidebar #departmentsDropdown {
            width: 0;
            padding: 0;
            margin-left: -250px;
            display: none;
        }

        .sidebar-hidden #main-content {
            width: 100%;
        }

        .sidebar-hidden #main-content-header {
            margin-left: 50px;
        }



        /* Sidebar toggle button */
        .sidebar-toggle {
            color: rgb(150, 62, 208);
            position: fixed;
            top: 10px;
            left: 10px;
            font-size: 30px;
            cursor: pointer;
            z-index: 1000;

        }

        #closeSidebar {
            background: transparent;
            color: red;
            border: none;
            font-size: 30px;
            font-weight: bold;
            cursor: pointer;


        }

        /* Responsive styles for mobile */
        /* Small Screen Media Query */
        @media only screen and (max-width: 768px) {
            #sidebar {
                position: fixed;
                left: -260px;
                /* Move the sidebar fully out of view */
                width: 250px;
                height: 100%;
                z-index: 1000;
                background-color: #333;
                /* Ensures the background color is not black */
            }

            .sidebar-visible #sidebar {
                left: 0;
            }

            #main-content {
                width: 100%;
            }

            /* Sidebar toggle button */
            .sidebar-toggle {
                position: fixed;
                top: 10px;
                left: 10px;
                font-size: 30px;
                cursor: pointer;
                z-index: 1001;
                /* Keep toggle button on top */
                color: white;
            }

            /* Change toggle color when sidebar is open */
            .sidebar-visible .sidebar-toggle {
                color: #333;
                /* Change color when sidebar is open (make it contrast the open sidebar) */
            }

            /* Hide any outline or leftover line when sidebar is closed */
            .sidebar-hidden #sidebar {
                left: -260px;
                /* Ensure it's completely hidden */
                transition: left 0.3s ease;
            }

            .sidebar-hidden .sidebar-toggle {
                color: white;
                /* Default color of toggle button */
            }
        }


        /*************************************container / sidebar/main content styling  css end *************************************/
        /*************************************dashboard card styling  css start*************************************/
        .card {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }

        .card-title {
            font-size: 18px;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .card-title i {
            font-size: 24px;
            margin-right: 10px;
        }

        .card-body {
            text-align: center;
        }

        .card-text {
            font-size: 22px;
            font-weight: bold;
        }

        #complaintChart {
            background-color: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
        }

        #adminName {
            color: white;
        }

        #dashBoradTotalComplaints {
            background-color: #6f42c1;
        }

        .img-fluid {
            max-width: 100%;
            height: auto;
        }

        .rounded-circle {
            border-radius: 50%;
        }

        /*************************************user complint card styling  css end*************************************/

        .user-complaints-modal .modal-dialog {
            max-width: 90%;
            margin: 30px auto;
        }

        .user-complaints-modal .modal-content {
            height: 80vh;
            overflow-y: auto;
        }

        /*************************************search bar styling  css start*************************************/
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

        /*************************************search bar styling  css end*************************************/
        /*************************************view all section styling  css start*************************************/
        #viewAllComplaints,
        #viewAllEmployees,
        #viewAllUsers {
            background-color: #f9f9f9;
            border-radius: 0.5rem;
            padding: 1rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        /* Styling the h3 tags inside the sections */
        #viewAllComplaints h3,
        #viewAllEmployees h3,
        #viewAllUsers h3 {
            font-family: 'Roboto', sans-serif;
            font-weight: 700;
            color: #17a2b8;
            font-style: italic;
        }

        /* common css for all tables  */
        /* General table header styling */
        #complaintsTable thead,
        #viewAllDepartmentsTable thead,
        #viewAllEmployeesTable thead,
        #viewAllUsersTable thead {
            background-color: #17a2b8;
            /* Bootstrap info color */
            color: #ffffff;
            /* White text color */
        }

        /* Header cell alignment and padding for complaintsTable */
        #complaintsTable thead th {
            text-align: center;
            padding: 12px;
        }

        /* Alternating row colors for complaintsTable */
        #complaintsTable tbody tr:nth-child(even) {
            background-color: #f2f2f2;
            /* Light grey for alternate rows */
        }

        /* Hover effect for rows in complaintsTable */
        #complaintsTable tbody tr:hover {
            background-color: #e9ecef;
            /* Slightly darker grey on hover */
        }

        /* General table styling for all view tables */
        #viewAllDepartmentsTable tbody tr:nth-child(even),
        #viewAllEmployeesTable tbody tr:nth-child(even),
        #viewAllUsersTable tbody tr:nth-child(even) {
            background-color: #f2f2f2;
            /* Light grey for alternate rows */
        }

        #viewAllDepartmentsTable tbody tr:hover,
        #viewAllEmployeesTable tbody tr:hover,
        #viewAllUsersTable tbody tr:hover {
            background-color: #e9ecef;
            /* Slightly darker grey on hover */
        }

        /* Table borders and padding for all tables */
        #complaintsTable,
        #viewAllDepartmentsTable,
        #viewAllEmployeesTable,
        #viewAllUsersTable {
            width: 100%;
            border-collapse: collapse;
        }

        #complaintsTable th,
        #viewAllDepartmentsTable th,
        #viewAllEmployeesTable th,
        #viewAllUsersTable th,
        #complaintsTable td,
        #viewAllDepartmentsTable td,
        #viewAllEmployeesTable td,
        #viewAllUsersTable td {
            border: 1px solid #ddd;
            padding: 8px;
        }

        /* Align content to the center */
        #complaintsTable td,
        #viewAllDepartmentsTable td,
        #viewAllEmployeesTable td,
        #viewAllUsersTable td {
            text-align: center;
        }

        /* Table header styling for non-complaints tables */
        #viewAllDepartmentsTable thead th,
        #viewAllEmployeesTable thead th,
        #viewAllUsersTable thead th {
            padding: 10px;
            text-align: center;
        }



        /* Styling for pagination if needed */
        .table-pagination {
            display: flex;
            justify-content: flex-end;
            padding: 10px;
        }

        .table-pagination a {
            color: #17a2b8;
            margin: 0 5px;
            text-decoration: none;
            padding: 8px 12px;
            border: 1px solid #17a2b8;
            border-radius: 4px;
        }

        .table-pagination a:hover {
            background-color: #17a2b8;
            color: white;
        }

        /*************************************view all section styling  css end*************************************/
        /*************************************dropdown styling  css start*************************************/
        #complaintsTable.dropdown-item:hover {
            background-color: #f8f9fa;
            /* Light grey background on hover */
            color: #343a40;
            /* Dark text color on hover */
        }



        #complaintsTable .spinner-border {
            color: #17a2b8;
            /* Match the loading spinner color with header */
        }



        #userComplaintsModal .modal-dialog {
            max-width: 80%;
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

        /*************************************dropdown styling  css end*************************************/
        /*************************************search input styling  css start*************************************/
        .search-complaint-input,
        .search-user-input,
        .search-employee-input,
        .search-departments-input {
            width: 50%;
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
        .search-complaint-input:focus,
        .search-user-input:hover,
        .search-user-input:focus,
        .search-employee-input:hover,
        .search-employee-input:focus,
        .search-departments-input:hover,
        .search-departments-input:focus {
            border-bottom: 2px solid #138496;
            /* Darker shade for focus/hover */
        }

        /*************************************search input styling  css end*************************************/

        /*************************************department section styling  css*************************************/
        #departmentForm {
            background-color: #f9f9f9;
            border-radius: 0.5rem;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        #departmentForm #registerDepartment {
            font-family: 'Roboto', sans-serif;
            font-weight: 700;
            color: #17a2b8;
            font-style: italic;
        }

        /* Input group styling */
        #departmentForm .modern-input {
            display: flex;
            align-items: center;
            position: relative;
            margin-bottom: 1.5rem;
        }

        #departmentForm .modern-input .input-group-prepend {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 1.2rem;
            color: #17a2b8;
        }

        #departmentForm .modern-input input,
        #departmentForm .modern-input textarea,
        #departmentForm .modern-input select {
            border: none;
            border-bottom: 2px solid #17a2b8;
            border-radius: 0;
            padding: 0.75rem 1rem;
            padding-left: 2.5rem;
            font-family: 'Roboto', sans-serif;
            transition: border-color 0.3s ease;
            background-color: transparent;
        }

        #departmentForm .modern-input input:focus,
        #departmentForm .modern-input textarea:focus,
        #departmentForm .modern-input select:focus {
            outline: none;
            border-bottom-color: #007bff;
        }

        /* Select-specific styling */
        #departmentForm select.form-control {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            background-color: transparent;
            padding-right: 2rem;
        }

        #departmentForm select.form-control:focus {
            box-shadow: none;
        }

        #departmentForm select.form-control option {
            color: #495057;
        }

        /* Custom arrow for select dropdown */
        #departmentForm select.form-control {
            background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 4 5"%3E%3Cpath fill="%23000000" d="M2 0L0 2h4zM0 3l2 2 2-2z"/%3E%3C/svg%3E');
            background-repeat: no-repeat;
            background-position: right 0.75rem center;
            background-size: 0.65rem auto;
        }

        #departmentForm select.form-control::-ms-expand {
            display: none;
        }

        /* Button styling */
        #departmentForm .modern-button {
            background-color: #007bff;
            border: none;
            padding: 0.75rem 1.5rem;
            font-family: 'Roboto', sans-serif;
            font-weight: 500;
            border-radius: 2rem;
            color: #fff;
            transition: background-color 0.3s ease;
        }

        #departmentForm .modern-button:hover {
            background-color: #0056b3;
        }

        /* Font and general input styling */
        #departmentForm .form-control {
            font-family: 'Roboto', sans-serif;
            font-size: 1rem;
            background-color: transparent;
            color: #495057;
        }

        #departmentForm textarea.form-control {
            resize: none;
        }

        /* Modern form styling */
        #registerDepartmentLogin {
            background-color: #f9f9f9;
            border-radius: 0.5rem;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        #registerDepartmentLoginForm {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        /* Form Heading */
        #registerDepartmentLogin h3.text-center {
            font-family: 'Roboto', sans-serif;
            font-weight: 700;
            color: #17a2b8;
            font-style: italic;
        }

        /* Input group styling */
        #registerDepartmentLogin .modern-input {
            display: flex;
            flex-direction: column;
            margin-bottom: 1.5rem;
            width: 100%;
            /* Ensures input fields take the full available width */
            max-width: 400px;
            /* Limit the width of input fields */
        }

        #registerDepartmentLogin .input-group {
            display: flex;
            align-items: center;
            position: relative;
            width: 100%;
            /* Make sure the input group takes full width */
        }

        #registerDepartmentLogin .input-group-prepend,
        #registerDepartmentLogin .input-group-append {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #17a2b8;
            z-index: 10;
        }

        #registerDepartmentLogin .input-group-append {
            left: auto;
            right: 10px;
            cursor: pointer;
        }

        /* Adjust padding to avoid overlap with FontAwesome icons */
        #registerDepartmentLogin .input-group input {
            padding: 0.75rem 1rem;
            padding-left: 4rem;
            /* Increased left padding to ensure enough space for the icon */
            padding-right: 2.5rem;
            border: none;
            border-bottom: 2px solid #17a2b8;
            font-family: 'Roboto', sans-serif;
            transition: border-color 0.3s ease;
            width: 100%;
            /* Ensure the input takes up full width within the container */
        }

        #registerDepartmentLogin .input-group input:focus {
            border-bottom-color: #007bff;
            outline: none;
        }

        /* Button styling */
        #registerDepartmentLogin .modern-button {
            background-color: #007bff;
            border: none;
            padding: 0.75rem 1.5rem;
            font-family: 'Roboto', sans-serif;
            font-weight: 500;
            border-radius: 2rem;
            color: #fff;
            transition: background-color 0.3s ease;
            width: 100%;
            /* Ensure the button takes up full width */
            max-width: 200px;
            /* Limit button width */
            margin-top: 1rem;
        }

        #registerDepartmentLogin .modern-button:hover {
            background-color: #0056b3;
        }

        #submitButton {
            margin-top: 10px;
            background-color: #17a2b8;
            border: none;
            padding: 0.75rem 1.5rem;
            font-family: 'Roboto', sans-serif;
            font-weight: 500;
            border-radius: 2rem;
            color: #fff;
        }

        #submitButton:hover {
            background-color: #0056b3;
        }

        #departmentModal #submitButton:focus {
            outline: none;
        }

        /* Styling for the View All Departments Section */
        #viewAllDepartments {
            background-color: #f9f9f9;
            border-radius: 0.5rem;
            padding: 1rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        #viewAllDepartments h3 {
            font-family: 'Roboto', sans-serif;
            font-weight: 700;
            color: #17a2b8;
            font-style: italic;
        }


        #viewAllDepartments table thead {
            background-color: #343a40;
            color: #fff;
        }

        #viewAllDepartments table tbody tr:hover {
            background-color: #f1f1f1;
        }

        #viewAllDepartments table th,
        #viewAllDepartments table td {
            padding: 1rem;
            text-align: center;
        }

        #viewAllDepartments table th {
            font-weight: bold;
        }



        /* Pagination styling */
        #viewAllDepartments .pagination .page-link {
            color: #007bff;
        }

        #viewAllDepartments .pagination .page-item.active .page-link {
            background-color: #007bff;
            border-color: #007bff;
        }

        /*************************************department section styling  css end*************************************/
        /*************************************modal section styling  css start*************************************/
        .modal-content {
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            background-color: #f9f9f9;
        }

        .modal-header {
            background-color: #0bc7e4;
            color: white;
            border-bottom: none;
            border-radius: 10px 10px 0 0;
        }

        .modal-title {
            font-weight: bold;
        }

        .modal-body {
            padding: 20px;
        }

        .modal-footer {
            border-top: none;
            padding-top: 10px;
        }
    </style>
</head>

<body>
    <div class="sidebar-toggle">
        <i class="fas fa-bars"></i>
    </div>
    <div class="container-fluid">

        <!-- Sidebar -->
        <div id="sidebar" class="p-3 bg-dark text-white">
            <div class="d-flex align-items-center mb-3">
                <img width="94" height="94" src="https://img.icons8.com/3d-fluency/94/administrator-male--v1.png"
                    class="rounded-circle me-2" alt="administrator-male--v1" />
                <h5 class="mb-0" id="adminName">HI ADMIN</h5>
                <!-- Close Button for Sidebar -->
                <button id="closeSidebar" class="btn btn-light ms-auto">X</button>
            </div>
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link active" href="#dashboard" aria-current="page">DashBoard</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="departmentsDropdown" role="button"
                        data-bs-toggle="dropdown" aria-expanded="false">Departments</a>
                    <ul class="dropdown-menu" aria-labelledby="departmentsDropdown">
                        <li><a class="dropdown-item" href="#registerDepartment">Register Department</a></li>
                        <li><a class="dropdown-item" href="#registerDepartmentLogin">Reg Department Login</a></li>
                        <li><a class="dropdown-item" href="#viewAllDepartments">View All Departments</a></li>
                        <li><a class="dropdown-item" href="#viewAllEmployees">View All Employees</a></li>
                    </ul>
                </li>
                <li class="nav-item"><a class="nav-link" href="#viewAllComplaints">Manage Complaints</a></li>
                <li class="nav-item"><a class="nav-link" href="#viewAllUsers">Users</a></li>
                <li class="nav-item"><a class="nav-link" href="#viewchats">Chats</a></li>
            </ul>
        </div>
        <!-- Main Content -->
        <div class="col-md-10 p-3" id="main-content">
            <!---------------------------main content of header ------------------------>

            <div id="main-content-header" class="d-flex justify-content-between align-items-center mb-3">
                <!-- Left side: Company Logo and Name -->
                <div class="d-flex align-items-center">
                    <img src="/complaintManagementSystem/res/companyLogo.jpg" alt="Company Logo"
                        style="width: 50px; height: 50px;" class="header-logo me-3">
                    <h5 class="mb-0">ResolveX Admin</h5>
                </div>

                <!-- Middle: Search bar -->
                <div class="search-bar d-flex align-items-center w-50 justify-content-center">
                    <select id="search-options" class="form-select me-2">
                        <option value="">Search Options</option>
                        <option value="department">Department</option>
                        <option value="complaint">Complaint</option>
                        <option value="user">User</option>
                        <option value="employee">Employee</option>
                    </select>
                    <input type="text" id="search-input" class="form-control me-2" placeholder="Enter Search Query">
                    <button id="search-button" class="btn btn-primary">
                        <i class="fa-solid fa-search"></i>
                    </button>
                </div>

                <!-- Right side: Dropdown Menu -->
                <div class="dropdown">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton1"
                        data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-person-circle"></i>
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                        <li><a class="dropdown-item" href="#">Profile</a></li>
                        <li><a class="dropdown-item" href="/complaintManagementSystem/HomePage">Logout</a>
                        </li>
                    </ul>
                </div>
            </div>

            <!------------------------------ DashBoard Section-------------------------------->
            <div id="dashboard" class="content-section" style="display: block;">
                <h3 class="mt-3">Dashboard</h3>
                <div class="row">
                    <!-- Total Users -->
                    <div class="col-md-3 mb-3">
                        <div class="card text-white bg-primary">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <i class="fas fa-users"></i> Total Users
                                </h5>
                                <p class="card-text">
                                    <span id="totalUsers">0</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <!-- Total Departments -->
                    <div class="col-md-3 mb-3">
                        <div class="card text-white bg-info">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <i class="fas fa-building"></i> Total Departments
                                </h5>
                                <p class="card-text">
                                    <span id="totalDepartments">0</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <!-- Total Complaints -->
                    <div class="col-md-3 mb-3">
                        <div class="card text-white bg-secondary">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <i class="fas fa-clipboard-list"></i> Total Complaints
                                </h5>
                                <p class="card-text">
                                    <span id="totalComplaints">0</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <!-- Total Employees -->
                    <div class="col-md-3 mb-3">
                        <div class="card text-white bg-dark">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <i class="fas fa-user-tie"></i> Total Employees
                                </h5>
                                <p class="card-text">
                                    <span id="totalEmployees">0</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <!-- New Complaints -->
                    <div class="col-md-3 mb-3">
                        <div class="card text-white bg-warning">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <i class="fas fa-exclamation-circle"></i> New Complaints
                                </h5>
                                <p class="card-text">
                                    <span id="newComplaints">0</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <!-- Pending Complaints -->
                    <div class="col-md-3 mb-3">
                        <div class="card text-white bg-danger">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <i class="fas fa-hourglass-half"></i> Pending Complaints
                                </h5>
                                <p class="card-text">
                                    <span id="pendingComplaints">0</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <!-- In Progress -->
                    <div class="col-md-3 mb-3">
                        <div class="card text-white bg-info">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <i class="fas fa-tasks"></i> In Progress
                                </h5>
                                <p class="card-text">
                                    <span id="inProgressComplaints">0</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <!-- Closed Complaints -->
                    <div class="col-md-3 mb-3">
                        <div class="card text-white bg-success">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <i class="fas fa-check-circle"></i> Closed Complaints
                                </h5>
                                <p class="card-text">
                                    <span id="closedComplaints">0</span>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Complaint Analysis -->
                <div class="row">
                    <div class="col-md-12 mb-3">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">
                                    <i class="fas fa-chart-bar"></i> Complaint Analysis
                                </h5>
                                <canvas id="complaintChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- ---------------------------------------------------- department side bar section complete code start ------------------------------------------------------------------------------- -->
            <!------------------------------ Register Department Section-------------------------------->
            <div id="registerDepartment" class="content-section">

                <form id="departmentForm" class="p-4 rounded shadow" style="background-color: #f9f9f9;">
                    <h4 id="registerDepartment" class="text-center">Register Department</h4>
                    <div class="row">
                        <div class="col-md-6 form-group">
                            <div class="input-group modern-input">
                                <div class="input-group-prepend">
                                    <i class="fas fa-building"></i>
                                </div>
                                <input type="text" class="form-control" id="departmentName"
                                    placeholder="Department Name" required>
                            </div>
                        </div>
                        <div class="col-md-6 form-group">
                            <div class="input-group modern-input">
                                <div class="input-group-prepend">
                                    <i class="fas fa-globe"></i>
                                </div>
                                <select id="country" class="form-control" placeholder="Country"
                                    onchange="loadStates(this.value)" required>
                                    <option value="">Select Country</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 form-group">
                            <div class="input-group modern-input">
                                <div class="input-group-prepend">
                                    <i class="fas fa-map-marker-alt"></i>
                                </div>
                                <select id="state" class="form-control" placeholder="State"
                                    onchange="loadCities(this.value)" required>
                                    <option value="">Select State</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6 form-group">
                            <div class="input-group modern-input">
                                <div class="input-group-prepend">
                                    <i class="fas fa-city"></i>
                                </div>
                                <select id="city" class="form-control" placeholder="City" required>
                                    <option value="">Select City</option>
                                </select>
                            </div>
                        </div>

                    </div>
                    <div class="row">
                        <div class="col-md-6 form-group">
                            <div class="input-group modern-input">
                                <div class="input-group-prepend">
                                    <i class="fas fa-map"></i>
                                </div>
                                <input type="text" class="form-control" id="area" placeholder="Area" required>
                            </div>
                        </div>
                        <div class="col-md-6 form-group">
                            <div class="input-group modern-input">
                                <div class="input-group-prepend">
                                    <i class="fas fa-address-card"></i>
                                </div>
                                <textarea class="form-control" id="address" rows="2" placeholder="Address"
                                    required></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6 form-group">
                            <div class="input-group modern-input">
                                <div class="input-group-prepend">
                                    <i class="fas fa-phone"></i>
                                </div>
                                <input type="text" class="form-control" id="contactNumber" placeholder="Contact Number"
                                    required>
                            </div>
                        </div>
                        <div class="col-md-6 form-group">
                            <div class="input-group modern-input">
                                <div class="input-group-prepend">
                                    <i class="fas fa-envelope"></i>
                                </div>
                                <input type="email" class="form-control" id="departmentEmail" placeholder="Email"
                                    required>
                            </div>
                        </div>
                    </div>
                    <div class="text-center mt-3">
                        <button type="submit" class="btn modern-button"><i
                                class="fas fa-user-plus"></i>Register</button>
                    </div>
                </form>
            </div>
            <!-- Register Department Login Section -->
            <div id="registerDepartmentLogin" class="content-section">
                <h3 class="text-center">Register Department Login</h3>
                <form id="registerDepartmentLoginForm">
                    <div class="modern-input">
                        <!--<label for="departmentId" class="form-label">Department ID</label> -->
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <!-- <span class="input-group-text"> -->
                                <i class="fas fa-id-badge"></i>
                                <!-- </span> -->
                            </div>
                            <input type="text" class="form-control" id="departmentId" placeholder="Enter Department ID"
                                required>
                        </div>
                    </div>

                    <div class="modern-input">
                        <!-- <label for="departmentLoginEmail" class="form-label">Department Login Email</label> -->
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <!-- <span class="input-group-text"> -->
                                <i class="fas fa-envelope"></i>
                                <!-- </span> -->
                            </div>
                            <input type="email" class="form-control" id="departmentLoginEmail"
                                placeholder="Enter Department Email" required>
                        </div>
                    </div>

                    <div class="modern-input">
                        <!-- <label for="departmentLoginPassword" class="form-label">Department Login Password</label> -->
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <!-- <span class="input-group-text"> -->
                                <i class="fas fa-lock"></i>
                                <!-- </span> -->
                            </div>
                            <input type="password" class="form-control" id="departmentLoginPassword"
                                placeholder="Enter Department Password" required>
                            <div class="input-group-append">
                                <span class="toggle-password" onclick="togglePassword()">
                                    <i class="fas fa-eye"></i>
                                </span>
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="btn modern-button"><i class="fa-solid fa-right-to-bracket"></i>Register
                        Login</button>
                </form>
            </div>

            <div id="viewAllDepartments" class="content-section">
                <h3>View All Departments</h3>
                <div class="row mt-4">
                    <div class="col-md-12">
                        <div class="card bg-light text-dark">
                            <div class="card-body">


                                <!-- Search Bar -->
                                <input type="text" class="form-control mt-2 search-departments-input"
                                    placeholder="Search by Department Name" id="departmentSearch"
                                    onkeyup="loadDepartments(1)">

                                <!-- Departments Table -->
                                <div class="table-responsive">
                                    <table id="viewAllDepartmentsTable"
                                        class="table table-bordered table-hover table-fixed table-responsive mt-2">
                                        <thead class="table-info">
                                            <tr>
                                                <th>ID</th>
                                                <th>Department Name</th>
                                                <th>Total Complaints</th>
                                                <th>New Complaints</th>
                                                <th>Pending Complaints</th>
                                                <th>Closed Complaints</th>
                                                <th>Total Employees</th>
                                                <th>View</th>
                                                <th>Employees</th>
                                            </tr>
                                        </thead>
                                        <tbody id="departmentTableBody">
                                            <!-- Data will be injected here by AJAX -->
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Pagination -->
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center" id="departmentPagination">
                                        <li class="page-item"><a class="page-link" href="#"
                                                onclick="prevPageDepartments()">Previous</a></li>
                                        <li class="page-item"><a class="page-link" href="#"
                                                onclick="nextPageDepartments()">Next</a></li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <!-- Modal for viewing employees -->
            <!-- Modal to view employees -->
            <div id="viewEmployeesByDepartmentModal" class="modal fade" tabindex="-1" role="dialog">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">View Employees for Department</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <table class="table table-bordered table-responsive">
                                <thead class="table-info">
                                    <tr>
                                        <th>ID</th>
                                        <th>Employee Name</th>
                                        <th>Email</th>
                                        <th>Contact Number</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="employeeTableBodyByDepartment">
                                    <!-- Data will be injected here by AJAX -->
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
                                <i class="fas fa-times me-2"></i>Close
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <div id="viewAllEmployees" class="content-section">
                <h3>View All Employees</h3>
                <div class="row mt-4">
                    <div class="col-md-12">
                        <div class="card bg-light text-dark">
                            <div class="card-body">

                                <!-- Search Bar -->
                                <input type="text" class="form-control mt-2 search-employee-input"
                                    placeholder="Search Employees by Name" id="employeeSearch"
                                    onkeyup="fetchEmployees(1)">

                                <!-- Employees Table -->
                                <div class="table-responsive">
                                    <table id="viewAllEmployeesTable" class="table table-striped mt-2">
                                        <thead class="table-info">
                                            <tr>
                                                <th>#</th>
                                                <th>Name</th>
                                                <th>Email</th>
                                                <th>Phone</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody id="viewAllEmployeeTableBody"></tbody>
                                    </table>
                                </div>
                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center" id="employeePagination">
                                        <li class="page-item"><a class="page-link" href="#"
                                                onclick="prevPageEmployees()">Previous</a></li>
                                        <li class="page-item"><a class="page-link" href="#"
                                                onclick="nextPageEmployees()">Next</a></li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="viewAllComplaints" class="content-section">
                <h3>View All Complaints</h3>
                <div class="row mt-4">
                    <div class="col-md-12">
                        <div class="card bg-light text-dark">
                            <div class="card-body">

                                <div class="d-flex justify-content-start mb-3">
                                    <!-- Dropdown for filtering complaints -->
                                    <div class="dropdown me-2">
                                        <button class="btn btn-info dropdown-toggle" type="button"
                                            id="dropdownMenuButton" data-bs-toggle="dropdown" aria-haspopup="true"
                                            aria-expanded="false">
                                            <i class="fas fa-filter"></i> Filter by Status
                                        </button>
                                        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                            <a class="dropdown-item text-primary" href="#"
                                                onclick="filterComplaints('all')"> <i class="fas fa-list"></i> All
                                                Complaints
                                            </a> <a class="dropdown-item text-success" href="#"
                                                onclick="filterComplaints('Registered')"> <i
                                                    class="fas fa-plus-circle"></i> New Complaints
                                            </a> <a class="dropdown-item text-warning" href="#"
                                                onclick="filterComplaints('Pending')"> <i
                                                    class="fas fa-hourglass-half"></i> Pending Complaints
                                            </a> <a class="dropdown-item text-info" href="#"
                                                onclick="filterComplaints('In Progress')"> <i
                                                    class="fas fa-spinner"></i> In Progress Complaints
                                            </a> <a class="dropdown-item text-danger" href="#"
                                                onclick="filterComplaints('Closed')"> <i
                                                    class="fas fa-check-circle"></i> Closed Complaints
                                            </a>
                                        </div>
                                    </div>

                                    <!-- Search Input -->
                                    <input type="text" class="form-control w-50 search-complaint-input"
                                        placeholder="Search Complaint by Complaint Type" id="SearchComplaint"
                                        onkeyup="searchComplaints()">

                                </div>

                                <!-- Table -->
                                <div class="table-responsive">
                                    <table id="complaintsTable" class="table table-striped mt-2 table-bordered">
                                        <thead class="table-info">
                                            <tr>
                                                <th scope="col">#</th>
                                                <th scope="col">Complaint Type</th>
                                                <th scope="col">Status</th>
                                                <th scope="col">User</th>
                                                <th scope="col">Department</th>
                                                <th scope="col">Employee</th>
                                                <th scope="col">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody id="complaintsTableBody">
                                            <!-- Loading indicator -->
                                            <tr id="loadingIndicator">
                                                <td colspan="7" class="text-center"><span
                                                        class="spinner-border spinner-border-sm" role="status"
                                                        aria-hidden="true"></span> Loading...</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Pagination and Page Size Selector -->
                                <div class="d-flex justify-content-between mt-3">
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
                                        <ul class="pagination justify-content-center" id="complintPagination">
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

            <div id="viewAllUsers" class="content-section">
                <h3>View All Users</h3>

                <div class="row mt-4">
                    <div class="col-md-12">
                        <div class="card bg-light text-dark">
                            <div class="card-body">

                                <!-- Search Bar -->
                                <input type="text" class="form-control mt-2 search-user-input"
                                    placeholder="Search User by Email" id="UserSearch" onkeyup="fetchAllUsers(1)">

                                <!-- Employees Table -->
                                <div class="table-responsive">
                                    <table id="viewAllUsersTable" class="table table-striped mt-2">
                                        <thead class="table-info">
                                            <tr>
                                                <th>User ID</th>
                                                <th>Name</th>
                                                <th>Email</th>
                                                <th>Phone</th>
                                                <th>Complaints</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody id="userDetailsTableBody"></tbody>
                                    </table>
                                </div>

                                <nav aria-label="Page navigation">
                                    <ul class="pagination justify-content-center" id="usersPagination">
                                        <li class="page-item"><a class="page-link" href="#"
                                                onclick="prevPageUsers()">Previous</a></li>
                                        <li class="page-item"><a class="page-link" href="#"
                                                onclick="nextPageUsers()">Next</a></li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="viewchats" class="content-section">



                <div class="chat-container">
                    <button class="toggle-btn btn ms-auto" id="toggle-btn" onclick="toggleChatList()">X</button>
                    <!-- Left side - Chat list -->
                    <div class="chat-list" id="chat-list">
                        <div class="chat-owner">
                            <img src="/complaintManagementSystem/res/companyLogo.jpg" width="50px" height="50px"
                                alt="Owner">
                            <div>
                                <div><strong>ResolveX admin</strong></div>
                                <div class="chat-status">Online</div>
                            </div>
                        </div>

                        <!-- Search Bar -->
                        <div class="chat-search">
                            <input type="text" id="chat-search-input" placeholder="Search chats">
                        </div>
                        <div class="chat-item" onclick="openChat('user1')">
                            <img width="40" height="40" src="https://img.icons8.com/arcade/64/guest-male.png"
                                alt="guest-male" />
                            <div>
                                <div><strong>Somanath huddar</strong></div>
                                <div class="last-message">Hello there!</div>
                            </div>
                        </div>
                        <div class="chat-item" onclick="openChat('user2')">
                            <img width="64" height="64"
                                src="https://img.icons8.com/arcade/64/gender-neutral-user--v1.png"
                                alt="gender-neutral-user--v1" />
                            <div>
                                <div><strong>Venkatesh</strong></div>
                                <div class="last-message">How's it going?</div>
                            </div>
                        </div>
                        <div class="chat-item" onclick="openChat('user3')">
                            <img width="48" height="48" src="https://img.icons8.com/color/48/user.png" alt="user" />
                            <div>
                                <div><strong>Rajesh</strong></div>
                                <div class="last-message">See you soon!</div>
                            </div>
                        </div>
                    </div>

                    <!-- Right side - Chat window -->
                    <div class="chat-window" id="chat-user1">
                        <div class="chat-header">
                            <img width="40" height="40" class="chat-header-img"
                                src="https://img.icons8.com/arcade/64/guest-male.png" alt="guest-male" />
                            <div>
                                <div class="chat-header-name"><strong>Somanath huddar</strong></div>
                                <div class="status">Online</div>
                            </div>
                        </div>
                        <div class="messages">
                            <div class="message received">
                                <div class="message-text">Hello! How are you?</div>
                            </div>
                            <div class="message sent">
                                <div class="message-text">I'm good, how about you?</div>
                            </div>
                        </div>
                        <div class="chat-input">
                            <input type="text" placeholder="Type a message">
                            <button>Send</button>
                        </div>
                    </div>

                    <div class="chat-window" id="chat-user2">
                        <div class="chat-header">
                            <img width="40" height="40" class="chat-header-img"
                                src="https://img.icons8.com/arcade/64/gender-neutral-user--v1.png"
                                alt="gender-neutral-user--v1" />
                            <div>
                                <div><strong>Venkatesh</strong></div>
                                <div class="status">Online</div>
                            </div>
                        </div>
                        <div class="messages">
                            <div class="message received">
                                <div class="message-text">How's everything?</div>
                            </div>
                            <div class="message sent">
                                <div class="message-text">All good, thanks!</div>
                            </div>
                        </div>
                        <div class="chat-input">
                            <input type="text" placeholder="Type a message">
                            <button>Send</button>
                        </div>
                    </div>

                    <div class="chat-window" id="chat-user3">
                        <div class="chat-header">
                            <img width="40" height="40" class="chat-header-img"
                                src="https://img.icons8.com/color/48/user.png" alt="user" />
                            <div>
                                <div><strong>Rajesh</strong></div>
                                <div class="status">Offline</div>
                            </div>
                        </div>
                        <div class="messages">
                            <div class="message received">
                                <div class="message-text">See you soon!</div>
                            </div>
                        </div>
                        <div class="chat-input">
                            <input type="text" placeholder="Type a message">
                            <button>Send</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Complaint Details Modal -->
            <!-- Complaint Details Modal -->

            <!-- Views Section -->
            <div id="userDetailsModal" class="modal fade" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">User Details</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <!-- Left column with user details -->
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
                                </div>
                                <div class="col-md-6 text-center">
                                    <!-- Right column with user image -->
                                    <img id="userImageDetail" src="" alt="User Image" class="img-fluid rounded-circle"
                                        style="width: 150px; height: 150px;">
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-md-6">
                                    <p>
                                        <i class="fas fa-phone"></i> <strong>Contact Number:</strong> <span
                                            id="userContactNumberDetail"></span>
                                    </p>
                                    <p>
                                        <i class="fas fa-phone-alt"></i> <strong>Alternate
                                            Contact Number:</strong> <span id="userAlterContactNumberDetail"></span>
                                    </p>
                                </div>
                                <div class="col-md-6">
                                    <p>
                                        <i class="fas fa-check-circle"></i> <strong>Agreement:</strong>
                                        <span id="userAgreementDetail"></span>
                                    </p>
                                    <p>
                                        <i class="fas fa-exclamation-circle"></i> <strong>Complaints:</strong>
                                        <span id="userComplaintsCountDetail"></span>
                                    </p>
                                </div>
                            </div>
                            <button type="button" class="btn btn-primary" onclick="viewUserComplaints()">
                                <i class="fas fa-folder-open"></i> View Complaints
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal for Complaints Details -->
            <div id="userComplaintsModal" class="modal fade" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">User Complaints</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="table-responsive">
                                <table class="table table-bordered">
                                    <thead class="table-info">
                                        <tr>
                                            <th>ID</th>
                                            <th>Type</th>
                                            <th>Status</th>
                                            <th>Department</th>
                                            <th>Employee</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody id="userComplaintsBody">
                                        <!-- Data will be injected here by AJAX -->
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Modal for employee Details -->
            <div id="viewEmployeeModal" class="modal fade" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="viewEmployeeModalLabel">Employee
                                Details</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <p>
                                        <i class="fas fa-id-badge"></i> <strong>Employee ID:</strong> <span
                                            id="employeeIdDetail"></span>
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
                                        <i class="fas fa-phone"></i> <strong>Contact Number:</strong> <span
                                            id="employeeContactNumberDetail"></span>
                                    </p>
                                </div>
                                <div class="col-md-6 text-center">
                                    <img id="employeeImageDetail" src="" alt="Employee Image"
                                        class="img-fluid rounded-circle" style="width: 150px; height: 150px;">
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-md-6">
                                    <p>
                                        <i class="fas fa-toggle-on"></i> <strong>Status:<span
                                                id="employeeStatusDetail"></span></strong>
                                    </p>
                                </div>
                                <div class="col-md-6">
                                    <button class="btn btn-primary" onclick="viewEmployeeDepartment()"><i
                                            class='fas fa-eye'></i>Department</button>

                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
                                <i class="fas fa-times me-2"></i>Close
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Edit or Register Department Modal -->
            <div id="departmentModal" class="modal fade" tabindex="-1" role="dialog">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalTitle">Register Department</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="editDepartmentForm">
                                <input type="hidden" id="departmentId" name="departmentId">
                                <!-- Hidden field for department ID -->

                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <i class="fas fa-building form-icon"></i>
                                        <label for="departmentName" class="form-label">Department Name</label>
                                        <input type="text" class="form-control" id="departmentName" name="name"
                                            placeholder="Enter Department Name" required>
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <i class="fas fa-globe form-icon"></i>
                                        <label for="country" class="form-label">Country</label>
                                        <input type="text" class="form-control" id="country" name="country"
                                            placeholder="Enter Country" required>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <i class="fas fa-map-marker-alt form-icon"></i>
                                        <label for="state" class="form-label">State</label>
                                        <input type="text" class="form-control" id="state" name="state"
                                            placeholder="Enter State" required>
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <i class="fas fa-city form-icon"></i>
                                        <label for="city" class="form-label">City</label>
                                        <input type="text" class="form-control" id="city" name="city"
                                            placeholder="Enter City" required>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <i class="fas fa-map form-icon"></i>
                                        <label for="area" class="form-label">Area</label>
                                        <input type="text" class="form-control" id="area" name="area"
                                            placeholder="Enter Area" required>
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <i class="fas fa-address-card form-icon"></i>
                                        <label for="address" class="form-label">Address</label>
                                        <textarea class="form-control" id="address" name="address" rows="2"
                                            placeholder="Enter Address" required></textarea>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <i class="fas fa-phone form-icon"></i>
                                        <label for="contactNumber" class="form-label">Contact Number</label>
                                        <input type="text" class="form-control" id="contactNumber" name="contactNumber"
                                            placeholder="Enter Contact Number" required>
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <i class="fas fa-envelope form-icon"></i>
                                        <label for="departmentEmail" class="form-label">Department Email</label>
                                        <input type="email" class="form-control" id="departmentEmail"
                                            name="departmentEmail" placeholder="Enter Department Email" required>
                                    </div>
                                </div>
                                <div class="text-center">
                                    <button type="submit" class="btn btn-primary" id="submitButton">Save
                                        Department</button>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
                                <i class="fas fa-times me-2"></i>Close
                            </button>

                        </div>
                    </div>
                </div>
            </div>
            <div id="viewComplaintModal" class="modal fade" tabindex="-1" role="dialog" data-backdrop="static">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="modalTitle">Complaint Details</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <!-- Complaint details form -->
                            <form id="complaintDetailsForm">
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <i class="fas fa-clipboard-list form-icon"></i> <label for="complaintId"
                                            class="form-label">Complaint ID</label> <input type="text"
                                            class="form-control" id="complaintId" readonly>
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <i class="fas fa-building form-icon"></i> <label for="complaintType"
                                            class="form-label">Complaint Type</label>
                                        <input type="text" class="form-control" id="complaintType" readonly>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <i class="fas fa-globe form-icon"></i> <label for="country"
                                            class="form-label">Country</label> <input type="text" class="form-control"
                                            id="country" readonly>
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <i class="fas fa-map-marker-alt form-icon"></i> <label for="state"
                                            class="form-label">State</label> <input type="text" class="form-control"
                                            id="state" readonly>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <i class="fas fa-city form-icon"></i> <label for="city"
                                            class="form-label">City</label> <input type="text" class="form-control"
                                            id="city" readonly>
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <i class="fas fa-building form-icon"></i> <label for="cityArea"
                                            class="form-label">City Area</label> <input type="text" class="form-control"
                                            id="cityArea" readonly>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <i class="fas fa-map form-icon"></i> <label for="complaintAddress"
                                            class="form-label">Complaint
                                            Address</label> <input type="text" class="form-control"
                                            id="complaintAddress" readonly>
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <i class="fas fa-info-circle form-icon"></i> <label for="complaintDetails"
                                            class="form-label">Complaint
                                            Details</label>
                                        <textarea class="form-control" id="complaintDetails" rows="3"
                                            readonly></textarea>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <i class="fas fa-calendar-day form-icon"></i> <label for="createdAt"
                                            class="form-label">Created At</label> <input type="text"
                                            class="form-control" id="createdAt" readonly>
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <i class="fas fa-calendar-check form-icon"></i> <label for="updatedAt"
                                            class="form-label">Updated At</label> <input type="text"
                                            class="form-control" id="updatedAt" readonly>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 form-group">
                                        <i class="fas fa-tag form-icon"></i> <label for="status"
                                            class="form-label">Status</label> <select id="status" class="form-control"
                                            onchange="handleStatusChange()">
                                            <option value="Pending">Pending</option>
                                            <option value="In Progress">In Progress</option>
                                            <option value="Closed">Closed</option>
                                            <option value="Not Resolved">Not Resolved</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <label for="departmentSelect" class="form-label"> <i
                                                class="fas fa-building me-2"></i>Assign Department
                                        </label> <select id="departmentSelect" class="form-control">
                                            <option value="">Select Department</option>
                                            <!-- Dynamically load departments here -->
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
                                        <button type="button" class="btn btn-primary btn-sm" id="sendOtpButton"
                                            onclick="sendOtp()">
                                            <i class="fas fa-paper-plane"></i> Send OTP
                                        </button>
                                        <div id="countdownTimer" class="mt-2"></div>
                                        <div id="otpSent" style="display: none; color: green;" class="mt-2">
                                            <i class="fas fa-check-circle"></i> OTP sent successfully!
                                        </div>
                                    </div>
                                    <div class="col-md-6 form-group">
                                        <input type="text" class="form-control form-control-sm mt-2" id="otp"
                                            placeholder="Enter OTP" style="display: none;">
                                        <span id="otpError" style="color: red; display: none;" class="mt-2"> <i
                                                class="fas fa-exclamation-circle"></i>
                                            Invalid OTP. Please try again.
                                        </span>
                                        <button type="button" class="btn btn-primary mt-2" id="verifyOtpButton"
                                            style="display: none;" onclick="verifyOtp()">
                                            <i class="fas fa-check"></i> Verify OTP
                                        </button>
                                    </div>
                                </div>
                            </form>

                            <div id="verifyOtp" style="display: none; text-align: center;">
                                <span style="color: green;"><i class="fas fa-check-circle"></i>
                                    OTP verified successfully!</span>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button id="submitAssignment" type="button" class="btn btn-primary"
                                onclick="assignDepartment()">
                                <i class="fas fa-check me-2"></i>Submit
                            </button>
                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">
                                <i class="fas fa-times me-2"></i>Close
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Success Modal -->
            <div class="modal fade" id="successModal" tabindex="-1" role="dialog" aria-labelledby="successModalLabel"
                aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="successModalLabel">Success</h5>
                            <button type="button" class="close" data-dismiss="modal" onclick="closeModals()"
                                aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p id="successMessage"></p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" onclick="closeModals()"
                                data-dismiss="modal">OK</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Error Modal -->
            <div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="errorModalLabel"
                aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="errorModalLabel">Error</h5>
                            <button type="button" class="close" data-dismiss="modal" onclick="closeModals()"
                                aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p id="errorMessage"></p>
                            <ul id="errorList">
                            </ul>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" onclick="closeModals()"
                                data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!---------------------- side bar JavaScript code ------------->
    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function () {
            const sidebar = document.getElementById('sidebar');
            const sidebarToggle = document.querySelector('.sidebar-toggle');
            const closeSidebarButton = document.getElementById('closeSidebar');
            const containerFluid = document.querySelector('.container-fluid');

            // Toggle sidebar visibility
            sidebarToggle.addEventListener('click', function () {
                if (containerFluid.classList.contains('sidebar-visible')) {
                    containerFluid.classList.remove('sidebar-visible');
                    containerFluid.classList.add('sidebar-hidden');
                } else {
                    containerFluid.classList.add('sidebar-visible');
                    containerFluid.classList.remove('sidebar-hidden');
                }
            });


            // Close the sidebar when "X" button is clicked
            closeSidebarButton.addEventListener('click', function () {
                containerFluid.classList.remove('sidebar-visible');
                containerFluid.classList.add('sidebar-hidden');
            });

            const navLinks = document.querySelectorAll('.nav-link, .dropdown-item');
            const contentSections = document.querySelectorAll('.content-section');

            navLinks.forEach(link => {
                link.addEventListener('click', function (e) {
                    const targetId = this.getAttribute('href');

                    if (targetId && targetId.startsWith('#') && targetId.length > 1) {
                        e.preventDefault();

                        // Remove 'active' class from all links and add to the clicked link
                        navLinks.forEach(nav => nav.classList.remove('active'));
                        this.classList.add('active');

                        // Hide all content sections
                        contentSections.forEach(section => section.style.display = 'none');

                        // Show the target section
                        const target = document.querySelector(targetId);
                        if (target) {
                            target.style.display = 'block';

                            // Load dynamic content based on section
                            const sectionName = targetId.substring(1);

                            if (sectionName === 'viewAllComplaints') {
                                fetchComplaints(); // Implement this function
                            } else if (sectionName === 'viewAllUsers') {
                                fetchAllUsers(1); // Implement this function
                            } else if (sectionName === 'viewAllEmployees') {
                                fetchEmployees(1); // Implement this function
                            } else if (sectionName === 'viewAllDepartments') {
                                loadDepartments(1); // Implement this function
                            }
                        }
                    }
                });
            });
        });

    </script>

    <!---------------------- ssuccessModal errorModal JavaScript code ------------->
    <script>
        function closeModals() {
            $('#successModal').modal('hide');
            $('#errorModal').modal('hide');
            $('#viewEmployeeModal').modal('hide');
        }
    </script>
    <!---------------------- complaintChart JavaScript code ------------->
    <script>
        let complaintChart;
        function updateChart(data) {
            const ctx = document.getElementById('complaintChart').getContext('2d');
            if (complaintChart) {
                complaintChart.data.datasets[0].data = [
                    data.totalComplaints,
                    data.newComplaints,
                    data.pendingComplaints,
                    data.inProgressComplaints,
                    data.closedComplaints
                ];
                complaintChart.update();
            } else {
                complaintChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: ['Total', 'New', 'Pending', 'In Progress', 'Closed'],
                        datasets: [{
                            label: 'Complaints',
                            data: [
                                data.totalComplaints,
                                data.newComplaints,
                                data.pendingComplaints,
                                data.inProgressComplaints,
                                data.closedComplaints
                            ],
                            backgroundColor: [
                                '#6f42c1',  // Purple for Total
                                '#ffc107',  // Yellow for New
                                '#dc3545',  // Red for Pending
                                '#17a2b8',  // Info (Light Blue) for In Progress
                                '#28a745'   // Green for Closed
                            ],
                            borderColor: '#ffffff', // White borders
                            borderWidth: 2
                        }]
                    },
                    options: {
                        responsive: true,
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            }
        }
    </script>

    <!------------Update Dash Board with response data javaScript code ----->
    <script>
        $(document).ready(function () {
            function updateDashboard() {
                $.ajax({
                    url: '/complaintManagementSystem/dashboardData', // Endpoint to fetch dashboard data
                    type: 'GET',
                    dataType: "json",
                    success: function (response) {
                        // Update dashboard with response data
                        updateChart(response);
                        $('#totalUsers').text(response.totalUsers);
                        $('#totalDepartments').text(response.totalDepartments);
                        $('#totalComplaints').text(response.totalComplaints);
                        $('#totalEmployees').text(response.totalEmployees);
                        $('#newComplaints').text(response.newComplaints);
                        $('#pendingComplaints').text(response.pendingComplaints);
                        $('#inProgressComplaints').text(response.inProgressComplaints);
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

    <!--  all Department java script code here  start-->
    <script type="text/javascript">

        // Call functions inside document ready
        $(document).ready(function () {

            $('#departmentForm').on('submit', function (e) {
                e.preventDefault();
                registerDepartment(); // Call the register department function
            });

            // Handle department login registration
            $('#registerDepartmentLoginForm').submit(function (e) {
                e.preventDefault();
                registerDepartmentLogin();
            });

            // Handle form submission for department update
            $('#editDepartmentForm').submit(function (e) {
                e.preventDefault();
                updateDepartment();
            });
        });

        function registerDepartment() {
            let formData = {
                departmentName: $('#departmentName').val().trim(),
                departmentCountry: $('#country option:selected').text(),
                departmentState: $('#state option:selected').text(),
                departmentCity: $('#city option:selected').text(),
                departmentArea: $('#area').val().trim(),
                departmentAddress: $('#address').val().trim(),
                departmentContactNumber: parseInt($('#contactNumber').val().trim(), 10),
                departmentEmail: $('#departmentEmail').val().trim()
            };

            $.ajax({
                url: '/complaintManagementSystem/department/registerDepartment',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(formData),
                success: function (response) {
                    $('#successMessage').text('Department registered successfully!');
                    $('#successModal').modal('show');
                    $('#departmentForm')[0].reset(); // Reset the form fields
                    $('#submitButton').prop('disabled', true); // Disable the submit button again
                },
                error: function (xhr, status, error) {
                    var errorMessage = 'Error registering department: ' + (xhr.responseText || 'An unexpected error occurred.');
                    $('#errorMessage').text(errorMessage);
                    $('#errorModal').modal('show');
                }
            });
        }

        // Function to handle department login registration
        function registerDepartmentLogin() {
            let formData = {
                departmentLoginEmail: $('#departmentLoginEmail').val().trim(),
                departmentLoginPassword: $('#departmentLoginPassword').val().trim(),
                departmentId: parseInt($('#departmentId').val().trim(), 10)
            };

            $.ajax({
                url: '/complaintManagementSystem/department/registerDepartmentLogin', // Adjust the URL if needed
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(formData),
                success: function (response) {
                    $('#successMessage').text(response);
                    $('#successModal').modal('show');
                    $('#registerDepartmentLoginForm')[0].reset(); // Reset the form
                },
                error: function (xhr, status, error) {
                    $('#errorMessage').text(xhr.responseText || 'An unexpected error occurred.');
                    $('#errorModal').modal('show');
                }
            });
        }

        // Function to handle department update
        function updateDepartment() {
            let departmentId = $('#editDepartmentForm #departmentId').val();

            let formData = {
                departmentName: $('#editDepartmentForm #departmentName').val().trim(),
                departmentCountry: $('#editDepartmentForm #country').val().trim(),
                departmentState: $('#editDepartmentForm #state').val().trim(),
                departmentCity: $('#editDepartmentForm #city').val().trim(),
                departmentArea: $('#editDepartmentForm #area').val().trim(),
                departmentAddress: $('#editDepartmentForm #address').val().trim(),
                departmentContactNumber: parseInt($('#editDepartmentForm #contactNumber').val().trim(), 10),
                departmentEmail: $('#editDepartmentForm #departmentEmail').val().trim()
            };

            $.ajax({
                url: '/complaintManagementSystem/department/update/' + departmentId,
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(formData),
                success: function (response) {
                    $('#departmentModal').modal('hide');
                    $('#successMessage').text('Department updated successfully!');
                    $('#successModal').modal('show');
                    loadDepartments(1); // Reload department data
                },
                error: function (xhr, status, error) {
                    $('#errorMessage').text('Error updating department: ' + (xhr.responseText || 'An unexpected error occurred.'));
                    $('#errorModal').modal('show');
                }
            });
        }

        function loadDepartments(page) {
            var query = $('#departmentSearch').val();
            $.ajax({
                url: `http://localhost:8080/complaintManagementSystem/department/getAllDepartmentDetails?page=${page}&size=10&query=${query}`, // Adjust URL according to your backend
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                    var departmentTableBody = $('#departmentTableBody');
                    departmentTableBody.empty();

                    data.content.forEach(function (department) { // Adjust for pagination response structure
                        var row = '<tr>' +
                            '<td>' + department.departmentId + '</td>' +
                            '<td>' + department.departmentName + '</td>' +
                            '<td>' + department.totalComplaints + '</td>' +
                            '<td>' + department.newComplaints + '</td>' +
                            '<td>' + department.pendingComplaints + '</td>' +
                            '<td>' + department.closedComplaints + '</td>' +
                            '<td>' + department.totalEmployees + '</td>' +
                            '<td>' + '<button class="btn btn-primary edit-department" data-id="' + department.departmentId + '">Edit</button>' + '</td>' +
                            '<td>' + '<button class="btn btn-info view-employees" data-id="' + department.departmentId + '">Employees</button>' + '</td>' +
                            '</tr>';
                        departmentTableBody.append(row);
                    });

                    // Attach event listeners to buttons
                    $('.edit-department').click(function () {
                        var departmentId = $(this).data('id');
                        // Open the modal for editing with the department details
                        loadDepartmentByDepartmentId(departmentId);
                    });

                    $('.view-employees').click(function () {
                        var departmentId = $(this).data('id');
                        // Call function to load employee details
                        loadEmployeesByDepartmentId(departmentId);
                    });

                    // Handle Pagination
                    $('#departmentPagination').html(`
            <li class="page-item ${data.first ? 'disabled' : ''}">
                <a class="page-link" href="#" onclick="prevPageDepartments(${page})">Previous</a>
            </li>
            <li class="page-item ${data.last ? 'disabled' : ''}">
                <a class="page-link" href="#" onclick="nextPageDepartments(${page})">Next</a>
            </li>
        `);
                },
                error: function (error) {
                    console.error('Error fetching department data:', error);
                }
            });
        }

        function prevPageDepartments(currentPage) {
            if (currentPage > 1) {
                loadDepartments(currentPage - 1);
            }
        }

        function nextPageDepartments(currentPage) {
            loadDepartments(currentPage + 1);
        }

        function loadDepartmentByDepartmentId(departmentId) {
            $.ajax({
                url: '/complaintManagementSystem/department/getDepartmentDetailsById/' + departmentId,
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                    // Populate the form with department data
                    $('#editDepartmentForm #departmentId').val(data.departmentId);
                    $('#editDepartmentForm #departmentName').val(data.departmentName);
                    $('#editDepartmentForm #country').val(data.departmentCountry);
                    $('#editDepartmentForm #state').val(data.departmentState);
                    $('#editDepartmentForm #city').val(data.departmentCity);
                    $('#editDepartmentForm #area').val(data.departmentArea);
                    $('#editDepartmentForm #address').val(data.departmentAddress);
                    $('#editDepartmentForm #contactNumber').val(data.departmentContactNumber);
                    $('#editDepartmentForm #departmentEmail').val(data.departmentEmail);

                    // Open the department modal
                    $('#departmentModal').modal('show');
                    $('#departmentModal .modal-title').text('Edit Department');
                },
                error: function (xhr, status, error) {
                    // Extract error message from the response
                    var errorMessage = xhr.responseText || 'An error occurred. Please try again.';
                    
                    // Show the error modal with the message
                    $('#errorMessage').text(errorMessage);
                    $('#errorModal').modal('show');
                }
            });
        }


        // Function to load employee details
        function loadEmployeesByDepartmentId(departmentId) {
            $.ajax({
                url: '/complaintManagementSystem/employee/' + departmentId + '/employees', // Adjust URL
                type: 'GET',
                success: function (employees) {
                    var employeeTableBody = $('#employeeTableBodyByDepartment');
                    employeeTableBody.empty();
                    employees.forEach(function (employee) {
                        var row = '<tr>' +
                            '<td>' + employee.employeeId + '</td>' +
                            '<td>' + employee.employeeName + '</td>' +
                            '<td>' + employee.employeeEmail + '</td>' +
                            '<td>' + employee.employeeContactNumber + '</td>' +
                            '<td>' +
                            '<button class="btn btn-info view-employee" data-id="' + employee.employeeId + '"><i class="fas fa-eye"></i> View</button>' +
                            '</td>' +
                            '</tr>';
                        employeeTableBody.append(row);
                        // Ensure that the click handlers are bound correctly
                        $('.view-employee').click(function () {
                            const employeeId = $(this).data('id');
                            viewEmployee(employeeId);
                        });
                    });
                    $('#viewEmployeesByDepartmentModal').modal('show');
                },
                error: function (xhr, status, error) {
                    // Extract error message from the response
                    var errorMessage = xhr.responseText || 'An error occurred. Please try again.';
                    
                    // Show the error modal with the message
                    $('#errorMessage').text(errorMessage);
                    $('#errorModal').modal('show');
                }
            });
        }



    </script>

    <!--------------------------------- ALL COMPLINT REALTED JAVA SCRIPT CODE STRAT FROM HERE ---------------->
    <script type="text/javascript">
        let currentPageComplaints = 1;
        const pageSizeComplaints = 10;
        let otpSent = false;
        let otpVerified = false;
        let countdownInterval;

        function fetchComplaints(page = currentPageComplaints, status = 'all', query = '') {
            $.ajax({
                url: '/complaintManagementSystem/getAllComplaintsByAdmin',
                type: 'GET',
                data: {
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
            const searchQuery = $('#SearchComplaint').val();
            console.log(searchQuery);
            fetchComplaints(1, getCurrentStatus(), searchQuery);
        }

        function filterComplaints(status) {
            currentPageComplaints = 1;
            const searchQuery = $('#SearchComplaint').val();
            fetchComplaints(currentPageComplaints, status, searchQuery);
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
                complaints.forEach((complaint, index) => {
                    var row = '<tr>' +
                        '<td>' + (index + 1) + '</td>' +
                        '<td>' + complaint.complaintType + '</td>' +
                        '<td>' + complaint.status + '</td>' +
                        '<td>' +
                        '<button class="btn btn-primary view-user" data-user-id="' + complaint.userId + '"><i class="fas fa-user"></i> User</button>' +
                        '</td>' +
                        '<td>' +
                        (complaint.departmentId ?
                            '<button class="btn btn-info view-department" data-department-id="' + complaint.departmentId + '"><i class="fas fa-building"></i> Department</button>' :
                            'Not Assigned') +
                        '</td>' +
                        '<td>' +
                        (complaint.employeeId ?
                            '<button class="btn btn-success view-employee" data-employee-id="' + complaint.employeeId + '"><i class="fas fa-briefcase"></i> Employee</button>' :
                            'Not Assigned') +
                        '</td>' +
                        '<td>' +
                        '<button class="btn btn-warning view-complaint" data-id="' + complaint.complaintId + '"><i class="fas fa-eye"></i> View Complaint</button>' +
                        '</td>' +
                        '</tr>';
                    tableBody.append(row);
                });
            } else {
                tableBody.html('<tr><td colspan="7" class="text-center">No complaints found for this user.</td></tr>');
            }

            // Attach event listeners for buttons
            $('#complaintsTable').on('click', '.view-complaint', function () {
                let complaintId = $(this).data('id');
                viewComplaint(complaintId);
            });

            $('#complaintsTable').on('click', '.view-user', function () {
                let userId = $(this).data('user-id');
                viewUserDetails(userId);
            });

            $('#complaintsTable').on('click', '.view-employee', function () {
                let employeeId = $(this).data('employee-id');
                viewEmployee(employeeId);
            });

            $('#complaintsTable').on('click', '.view-department', function () {
                let departmentId = $(this).data('department-id');
                loadDepartmentByDepartmentId(departmentId);
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

        function handleStatusChange() {
            const status = document.getElementById('status').value;

            if (status === 'Closed' || status === 'Not Resolved') {
                document.getElementById('otpSection').style.display = 'block';
                document.getElementById('commentSection').style.display = 'block';
            } else {
                document.getElementById('otpSection').style.display = 'none';
                document.getElementById('commentSection').style.display = 'none';
            }
        }

        function viewComplaint(complaintId) {
            $.ajax({
                url: '/complaintManagementSystem/getComplaintDetailsById',
                method: 'GET',
                dataType: 'json',
                data: { id: complaintId },
                success: function (response) {
                    const form = document.forms['complaintDetailsForm'];

                    form['complaintId'].value = response.complaintId || '';
                    form['complaintType'].value = response.complaintType || '';
                    form['country'].value = response.country || '';
                    form['state'].value = response.state || '';
                    form['city'].value = response.city || '';
                    form['cityArea'].value = response.cityArea || '';
                    form['complaintAddress'].value = response.complaintAddress || '';
                    form['complaintDetails'].value = response.complaintDetails || '';
                    form['status'].value = response.status || '';

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
                        form['createdAt'].value = createdAtDate.toLocaleString();
                    } else {
                        form['createdAt'].value = 'N/A';
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
                        form['updatedAt'].value = updatedAtDate.toLocaleString();
                    } else {
                        form['updatedAt'].value = 'N/A';
                    }

                    // Assign Department and Comments
                    form['status'].value = response.status || '';
                    form['departmentSelect'].value = response.departmentId || '';

                    // Handle null comment case
                    form['statusComments'].value = response.complaintComment || '';

                    const status = response.status;
                    const comments = response.complaintComment;

                    // Disable fields if status is "Closed" or "Not Resolved" and comments exist
                    if ((status === 'Closed' || status === 'Not Resolved') && comments) {
                        form['status'].disabled = true;
                        form['departmentSelect'].disabled = true;
                        form['statusComments'].disabled = true;
                        document.getElementById('otpSection').style.display = 'none';
                        document.getElementById('commentSection').style.display = 'block';
                        document.getElementById('submitAssignment').disabled = true;
                    } else {
                        form['status'].disabled = false;
                        form['departmentSelect'].disabled = false;
                        form['statusComments'].disabled = false;
                        document.getElementById('submitAssignment').disabled = false;
                        handleStatusChange(); // Trigger OTP visibility based on status
                    }

                    // Show the modal with complaint details
                    $('#viewComplaintModal').modal('show');
                },
                error: function (xhr, status, error) {
                    // Extract error message from the response
                    var errorMessage = xhr.responseText || 'An error occurred. Please try again.';
                    
                    // Show the error modal with the message
                    $('#errorMessage').text(errorMessage);
                    $('#errorModal').modal('show');
                }
            });
        }



        function sendOtp() {
            const complaintId = document.getElementById('complaintId').value;

            $.ajax({
                url: '/complaintManagementSystem/sendComplaintCloseOtp',
                method: 'POST',
                data: { complaintId: complaintId },
                success: function (response) {
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
                error: function (xhr, status, error) {
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
                success: function (response) {
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
                error: function (xhr, status, error) {
                    otpVerified = false;
                    otpError.style.display = 'block';  // Show OTP error message
                    alert("An error occurred while verifying OTP.");
                }
            });
        }



        function assignDepartment() {
            let complaintId = document.getElementById('complaintId').value;
            let assignedDepartmentId = document.getElementById('departmentSelect').value;
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

            if (status !== 'Closed' && status !== 'Not Resolved' && !assignedDepartmentId) {
                alert('Please assign an employee before submitting.');
                return;
            }

            $.ajax({
                url: '/complaintManagementSystem/updateComplaint/' + complaintId,
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    departmentId: assignedDepartmentId,
                    status: status,
                    comments: comments
                }),
                success: function (response) {
                    $('#viewComplaintModal').modal('hide');
                    $('#successMessage').text(response);
                    $('#successModal').modal('show');
                    fetchComplaints();
                },
                error: function (xhr, status, error) {
                    if (xhr.status === 400) {
                        $('#errorMessage').text(xhr.responseText || 'Error updating department assignment.');
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
        function populateDepartments() {
            $.ajax({
                url: '/complaintManagementSystem/department/getAllDepartmentNames',  // Adjust URL as needed
                method: 'GET',
                success: function (response) {

                    $('#departmentSelect').empty();

                    $('#departmentSelect').append(new Option('Select Department', '', true, true));

                    // Add department options from response
                    response.forEach(department => {
                        $('#departmentSelect').append(new Option(department.departmentName, department.departmentId));
                    });
                },
                error: function (xhr, status, error) {
                    // Extract error message from the response
                    var errorMessage = xhr.responseText || 'An error occurred. Please try again.';
                    
                    // Show the error modal with the message
                    $('#errorMessage').text(errorMessage);
                    $('#errorModal').modal('show');
                }
            });
        }
        $(document).ready(function () {
            populateDepartments();
        });

    </script>
    <!--------------------------------- ALL COMPLINT REALTED JAVA SCRIPT CODE END HERE ---------------->
    <!--------------------- search  Bar of Admin page start --------------->
    <script>
        const searchOptions = document.getElementById('search-options');
        const searchInput = document.getElementById('search-input');

        searchOptions.addEventListener('change', () => {
            const type = searchOptions.value;
            let placeholder = '';
            switch (type) {
                case 'department':
                    placeholder = 'Enter Department ID';
                    break;
                case 'complaint':
                    placeholder = 'Enter Complaint ID';
                    break;
                case 'user':
                    placeholder = 'Enter User ID';
                    break;
                case 'employee':
                    placeholder = 'Enter Employee ID';
                    break;
            }
            searchInput.placeholder = placeholder;
        });
    </script>
    <script type="text/javascript">
        $('#search-button').click(function () {
            const query = $('#search-input').val().trim();
            const type = $('#search-options').val();
            if (query === '') {
                alert('Please enter a search term.');
                return;
            }
            switch (type) {
                case 'user':
                    viewUserDetails(query);
                    break;
                case 'complaint':
                    viewComplaint(query);
                    break;
                case 'department':
                    loadDepartmentByDepartmentId(query);
                    break;
                case 'employee':
                    viewEmployee(query);
                    break;
                default:
                    alert('Please select a valid search option.');
            }
        });
    </script>
    <!--------------------- search  Bar of admin page End --------------->
    <!-------------------------------All Employee Script Codes Here  --------------------->
    <Script>
        const pageSize = 10;
        let currentPageEmployees = 1;

        function fetchEmployees(page) {
            const searchQuery = $('#employeeSearch').val();
            $.ajax({
                url: '/complaintManagementSystem/employee/getAllEmployees',
                type: 'GET',
                data: {
                    page: page,
                    size: pageSize,
                    query: searchQuery
                },
                dataType: 'json',
                success: function (response) {
                    populateEmployeeTable(response.employees);
                    updateEmployeePagination(response.totalPages);
                },
                error: function (xhr) {
                    console.error('Error fetching employees:', xhr);
                }
            });
        }

        function populateEmployeeTable(employees) {
            const tableBody = $('#viewAllEmployeeTableBody');
            tableBody.empty();

            if (!employees || employees.length === 0) {
                tableBody.append('<tr><td colspan="6" class="text-center">No employees found.</td></tr>');
                return;
            }

            employees.forEach((employee) => {
                const row = '<tr>' +
                    '<td>' + employee.employeeId + '</td>' +
                    '<td>' + employee.employeeName + '</td>' +
                    '<td>' + employee.employeeEmail + '</td>' +
                    '<td>' + employee.employeeContactNumber + '</td>' +
                    '<td>' + employee.employeeStatus + '</td>' +
                    '<td>' +
                    '<button class="btn btn-info view-employee" data-id="' + employee.employeeId + '"><i class="fas fa-eye"></i> View</button>' +
                    '</td>' +
                    '</tr>';
                tableBody.append(row);
            });

            // Ensure that the click handlers are bound correctly
            $('.view-employee').click(function () {
                const employeeId = $(this).data('id');
                viewEmployee(employeeId);
            });
        }

        function updateEmployeePagination(totalPages) {
            const pagination = $('#employeePagination');
            pagination.empty();

            if (totalPages <= 1) return;

            pagination.append(`<li class="page-item"><a class="page-link" href="#" onclick="prevPageEmployees()">Previous</a></li>`);

            for (let i = 1; i <= totalPages; i++) {
                const activeClass = (i === currentPageEmployees) ? 'active' : '';
                pagination.append('<li class="page-item ' + activeClass + '"><a class="page-link" href="#" onclick="goToPageEmployees(' + i + ')">' + i + '</a></li>');
            }


            pagination.append(`<li class="page-item"><a class="page-link" href="#" onclick="nextPageEmployees()">Next</a></li>`);
        }

        function prevPageEmployees() {
            if (currentPageEmployees > 1) {
                currentPageEmployees--;
                fetchEmployees(currentPageEmployees);
            }
        }

        function nextPageEmployees() {
            currentPageEmployees++;
            fetchEmployees(currentPageEmployees);
        }

        function goToPageEmployees(page) {
            currentPageEmployees = page;
            fetchEmployees(currentPageEmployees);
        }

        $(document).ready(function () {
            fetchEmployees(currentPageEmployees);
        });



        let employeeDepartmentId; // Global variable to hold departmentId// Function to view employee details
        function viewEmployee(employeeId) {
            $.ajax({
                url: '/complaintManagementSystem/employee/getEmployeeById',
                method: 'GET',
                data: { employeeId: employeeId },
                success: function (employee) {
                    $('#employeeIdDetail').text(employee.employeeId);
                    $('#employeeNameDetail').text(employee.employeeName);
                    $('#employeeEmailDetail').text(employee.employeeEmail);
                    $('#employeeContactNumberDetail').text(employee.employeeContactNumber);
                    $('#employeeStatusDetail').text(employee.employeeStatus);

                    // Dynamically set the employee's department ID
                    employeeDepartmentId = employee.departmentId;

                    // Dynamically set the image (fallback to a default if employeeImagePath is null/empty)
                    var imagePath = employee.employeeImagePath
                        ? "/complaintManagementSystem/display?imagePath=" + employee.employeeImagePath
                        : 'default-image-path';
                    document.getElementById('employeeImageDetail').src = imagePath;

                    // Show the employee details modal
                    $('#viewEmployeeModal').modal('show');
                },
                error: function (xhr, status, error) {
                    // Extract error message from the response
                    var errorMessage = xhr.responseText || 'An error occurred. Please try again.';
                    
                    // Show the error modal with the message
                    $('#errorMessage').text(errorMessage);
                    $('#errorModal').modal('show');
                }
            });
        }

        // Function to view employee's department
        function viewEmployeeDepartment() {
            if (employeeDepartmentId) {
                loadDepartmentByDepartmentId(employeeDepartmentId);
            } else {
                console.error("No department ID available.");
            }
        }


    </Script>
    <!-------------------------------All User Script Codes Here  --------------------->
    <script type="text/javascript">
        let currentPageUsers = 1;
        const pageSizeUsers = 10;

        function fetchAllUsers(page) {
            const searchQuery = $('#UserSearch').val();
            $.ajax({
                url: '/complaintManagementSystem/getAllUsers', // Adjust the URL if necessary
                type: 'GET',
                data: {
                    page: page,
                    size: pageSizeUsers,
                    query: searchQuery
                },
                dataType: 'json',
                success: function (response) {
                    populateUsersTable(response.users);
                    updateUsersPagination(response.totalPages);
                },
                error: function (xhr, status, error) {
                    // Extract error message from the response
                    var errorMessage = xhr.responseText || 'An error occurred. Please try again.';
                    
                    // Show the error modal with the message
                    $('#errorMessage').text(errorMessage);
                    $('#errorModal').modal('show');
                }
            });
        }

        function populateUsersTable(users) {
            const tableBody = $('#userDetailsTableBody');
            tableBody.empty();

            if (!users || users.length === 0) {
                tableBody.append('<tr><td colspan="6" class="text-center">No users found.</td></tr>');
                return;
            }

            users.forEach((user) => {
                var row = '<tr>' +
                    '<th scope="row">' + user.userId + '</th>' +
                    '<td>' + user.firstName + ' ' + user.lastName + '</td>' +
                    '<td>' + user.email + '</td>' +
                    '<td>' + user.contactNumber + '</td>' +
                    '<td>' + user.complaintsCount + '</td>' +
                    '<td><button class="btn btn-primary btn-sm view-user" data-id="' + user.userId + '">View</button></td>' +
                    '</tr>';
                tableBody.append(row);
            });

            // Ensure that the click handlers are bound correctly
            $('.view-user').click(function () {
                var userId = $(this).data('id');
                viewUserDetails(userId); // Implement viewUserDetails function to handle the user view
            });
        }

        function updateUsersPagination(totalPages) {
            const pagination = $('#usersPagination');
            pagination.empty();

            if (totalPages <= 1) return;

            pagination.append(`<li class="page-item"><a class="page-link" href="#" onclick="prevPageUsers()">Previous</a></li>`);

            for (let i = 1; i <= totalPages; i++) {
                const activeClass = (i == currentPageUsers) ? 'active' : '';
                pagination.append('<li class="page-item ' + activeClass + '"><a class="page-link" href="#" onclick="goToPageUsers(' + i + ')">' + i + '</a></li>');
            }


            pagination.append(`<li class="page-item"><a class="page-link" href="#" onclick="nextPageUsers()">Next</a></li>`);
        }

        function prevPageUsers() {
            if (currentPageUsers > 1) {
                currentPageUsers--;
                fetchAllUsers(currentPageUsers);
            }
        }

        function nextPageUsers() {
            currentPageUsers++;
            fetchAllUsers(currentPageUsers);
        }

        function goToPageUsers(page) {
            currentPageUsers = page;
            fetchAllUsers(currentPageUsers);
        }

        function searchUsers() {
            fetchAllUsers(1); // Reset to the first page on search
        }

        $(document).ready(function () {
            fetchAllUsers(currentPageUsers);

            // Bind search function to search input or button
            $('#UserSearch').on('keyup', function () {
                searchUsers();
            });
        });


        function viewUserDetails(userId) {
            $.ajax({
                url: '/complaintManagementSystem/getUserById',
                method: 'GET',
                data: { id: userId },
                success: function (user) {
                    document.getElementById('userIdDetail').textContent = user.userId;
                    document.getElementById('userNameDetail').textContent = user.firstName + user.lastName;
                    document.getElementById('userEmailDetail').textContent = user.email;
                    document.getElementById('userComplaintsCountDetail').textContent = user.complaintsCount;
                    document.getElementById('userContactNumberDetail').textContent = user.contactNumber;
                    document.getElementById('userAlterContactNumberDetail').textContent = user.alterContactNumber || "N/A";
                    document.getElementById('userAgreementDetail').textContent = user.agreement ? "Yes" : "No";

                    // Construct image URL with query parameter
                    var imagePath = "/complaintManagementSystem/display?imagePath=" + user.imagePath;
                    document.getElementById('userImageDetail').src = imagePath;

                    $('#userDetailsModal').modal('show');
                },
                error: function (xhr, status, error) {
                    // Extract error message from the response
                    var errorMessage = xhr.responseText || 'An error occurred. Please try again.';
                    
                    // Show the error modal with the message
                    $('#errorMessage').text(errorMessage);
                    $('#errorModal').modal('show');
                }
            });
        }
        // Fetch and display user complaints in modal
        viewUserComplaints = function () {
            var userId = $('#userIdDetail').text().trim(); // Ensure no extra spaces
         
            $.ajax({
                url: '/complaintManagementSystem/getAllComplaintsByUser',
                method: 'GET',
                data: { userId: userId },
                success: function (response) {
                    // Ensure response contains the necessary data
                    if (response) {
                        // Update complaint summary counts
                        $('#userTotalComplaintsCount').text(response.totalComplaints);
                        $('#userInProgressComplaintsCount').text(response.inProgressComplaints);
                        $('#userClosedComplaintsCount').text(response.closedComplaints);

                        // Clear existing rows
                        $('#userComplaintsBody').empty();

                        // Populate complaints table
                        if (response.complaints && response.complaints.length > 0) {
                            response.complaints.forEach(function (complaint) {
                            	const isDepartmentAssigned = complaint.departmentId ? true : false;
                            	const isEmployeeAssigned = complaint.employeeId ? true : false;

                            	const departmentButton = isDepartmentAssigned
                            	    ? "<button class='btn btn-info btn-sm' onclick='loadDepartmentByDepartmentId(\"" + complaint.departmentId + "\")'>" +
                            	      "<i class='fas fa-bulding'></i> Department" +
                            	      "</button>"
                            	    : "<button class='btn btn-secondary btn-sm' disabled>Not Assigned</button>";

                            	const employeeButton = isEmployeeAssigned
                            	    ? "<button class='btn btn-success btn-sm' onclick='viewEmployee(\"" + complaint.employeeId + "\")'>" +
                            	      "<i class='fas fa-eye'></i> Employee" +
                            	      "</button>"
                            	    : "<button class='btn btn-secondary btn-sm' disabled>Not Assigned</button>";

                            	// Use departmentButton and employeeButton in your HTML as needed


                                var row = '<tr>' +
                                    '<td>' + complaint.complaintId + '</td>' +
                                    '<td>' + complaint.complaintType + '</td>' +
                                    '<td>' + complaint.status + '</td>' +
                                    '<td>' + departmentButton + '</td>' +
                                    '<td>' + employeeButton + '</td>' +
                                    '<td>' +
                                    '<button class="btn btn-warning btn-sm view-complaints" data-id="' + complaint.complaintId + '"><i class="fas fa-eye"></i> View</button>' +
                                    '</td>' +
                                    '</tr>';

                                $('#userComplaintsBody').append(row);
                            });
                            $('#userComplaintsBody').on('click', '.view-complaints', function () {
                                var complaintId = $(this).data('id');
                                viewComplaint(complaintId);
                            });
                        } else {
                            $('#userComplaintsBody').html('<tr><td colspan="6" class="text-center">No complaints found for this user.</td></tr>');
                        }

                        // Show the user complaints modal
                        $('#userComplaintsModal').modal('show');
                    } else {
                        console.error("Unexpected response format.");
                    }
                },
                error: function (xhr, status, error) {
                    console.error("Error fetching user complaints: ", error);
                }
            });
        };




    </script>
    <script type="text/javascript">
        let currentPageComplaints = 1;
        let pageSizeComplaints = 10;
        let currentStatus = 'all';
        let currentSearchQuery = '';


        function fetchUserComplaintsbyId(userId, page = currentPageComplaints, status = currentStatus, query = currentSearchQuery) {
            $.ajax({
                url: '/complaintManagementSystem/getAllComplaintsByUser',
                type: 'GET',
                data: {
                    userId: userId,
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
                	    ? "<button class='btn btn-info btn-sm' onclick='loadDepartmentByDepartmentId(\"" + complaint.departmentId + "\")'>" +
                	      "<i class='fas fa-eye'></i> Department" +
                	      "</button>"
                	    : "<button class='btn btn-info btn-sm' disabled>Not Assigned</button>";

                	const employeeButton = isEmployeeAssigned
                	    ? "<button class='btn btn-info btn-sm' onclick='viewEmployee(\"" + complaint.employeeId + "\")'>" +
                	      "<i class='fas fa-eye'></i> Employee" +
                	      "</button>"
                	    : "<button class='btn btn-secondary btn-sm' disabled>Not Assigned</button>";

                	// Use departmentButton and employeeButton in your HTML as needed



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
                paginationContainer.append(
                    '<li class="page-item ' + activeClass + '">' +
                    '<a class="page-link" href="#" onclick="goToPageComplaints(' + i + ')">' + i + '</a>' +
                    '</li>'
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
            // Load countries and complaint types when the document is ready
            loadCountries();
            populateComplaintTypes();
        });

        $(document).ready(function () {
            // Load countries when the document is ready
            loadCountries();
        });

        function loadCountries() {
            $.ajax({
                url: 'https://api.countrystatecity.in/v1/countries',
                method: 'GET',
                headers: {
                    "X-CSCAPI-KEY": "ald3ZWVHZDNwOTZUY09KT3lLam9uQ2VkWWoyNHpBZTUwb3hjUkU0OQ=="
                },
                success: function (response) {
                    $('#registerDepartment #country').empty().append(new Option("Select Country", ""));
                    response.forEach(country => {
                        $('#registerDepartment #country').append(new Option(country.name, country.iso2));
                    });
                },
                error: function (xhr, status, error) {
                    console.error("Error loading countries:", error);
                }
            });
        }

        function loadStates(countryCode) {
            console.log("Received Country Code:", countryCode);

            if (!countryCode) {
                console.error("Country code is missing!");
                return;
            }

            $.ajax({
                url: 'https://api.countrystatecity.in/v1/countries/' + countryCode + '/states',
                method: 'GET',
                headers: {
                    "X-CSCAPI-KEY": "ald3ZWVHZDNwOTZUY09KT3lLam9uQ2VkWWoyNHpBZTUwb3hjUkU0OQ=="
                },
                success: function (response) {
                    $('#registerDepartment #state').empty().append(new Option("Select State", ""));
                    response.forEach(state => {
                        $('#registerDepartment #state').append(new Option(state.name, state.iso2));
                    });
                    $('#registerDepartment #city').empty().append(new Option("Select City", "")); // Reset cities
                },
                error: function (xhr, status, error) {
                    console.error("Error loading states:", error);
                }
            });
        }

        function loadCities(stateCode) {
            const countryCode = $('#registerDepartment #country').val(); // Fix the selector to match the country select

            if (!stateCode || !countryCode) {
                console.error("State code or Country code is missing!");
                return;
            }

            $.ajax({
                url: 'https://api.countrystatecity.in/v1/countries/' + countryCode + '/states/' + stateCode + '/cities',
                method: 'GET',
                headers: {
                    "X-CSCAPI-KEY": "ald3ZWVHZDNwOTZUY09KT3lLam9uQ2VkWWoyNHpBZTUwb3hjUkU0OQ=="
                },
                success: function (response) {
                    $('#registerDepartment #city').empty().append(new Option("Select City", ""));
                    response.forEach(city => {
                        $('#registerDepartment #city').append(new Option(city.name, city.name));
                    });
                },
                error: function (xhr, status, error) {
                    console.error("Error loading cities:", error);
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

        function togglePassword() {
            const passwordField = document.getElementById('departmentLoginPassword');
            const toggleIcon = document.querySelector('.toggle-password i');

            if (passwordField.type === "password") {
                passwordField.type = "text";
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordField.type = "password";
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }

    </script>

    <!-- Scripts -->
    <script>
        function toggleChatList() {
            var chatList = document.getElementById('chat-list');
            var chatWindows = document.querySelectorAll('.chat-window');
            var toggleBtn = document.getElementById('toggle-btn');
            var chatHeaderImg = document.querySelector('.chat-header-img');

            chatList.classList.toggle('closed');

            // Adjust the chat window margin based on the sidebar state
            chatWindows.forEach(function (window) {
                window.style.marginLeft = chatList.classList.contains('closed') ? '0' : chatList.offsetWidth + 'px';
            });

            if (chatList.classList.contains('closed')) {
                toggleBtn.innerText = '>';
                toggleBtn.classList.add('closed');
                toggleBtn.style.border = '1px solid red';
                toggleBtn.style.color = 'red';
                chatHeaderImg.style.marginLeft = '50px'; // Adjusted margin to align with the closed state
                toggleBtn.style.left = '0px';
            } else {
                toggleBtn.innerText = 'X';
                toggleBtn.classList.remove('closed');
                toggleBtn.style.border = 'none';
                toggleBtn.style.color = 'black';
                toggleBtn.style.left = '250px';

            }
        }


        function openChat(userId) {
            var chatWindows = document.querySelectorAll('.chat-window');
            chatWindows.forEach(function (window) {
                if (window.id === 'chat-' + userId) {
                    window.classList.add('active');
                } else {
                    window.classList.remove('active');
                }
            });
        }

        // Optional: Handle chat search functionality
        document.getElementById('chat-search-input').addEventListener('input', function () {
            var searchTerm = this.value.toLowerCase();
            var chatItems = document.querySelectorAll('.chat-item');
            chatItems.forEach(function (item) {
                var chatName = item.querySelector('div > strong').textContent.toLowerCase();
                if (chatName.includes(searchTerm)) {
                    item.style.display = '';
                } else {
                    item.style.display = 'none';
                }
            });
        });
    </script>

</body>

</html>