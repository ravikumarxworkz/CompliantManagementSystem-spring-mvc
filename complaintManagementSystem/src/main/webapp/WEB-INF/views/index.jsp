<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ResolveX</title>
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
 <link rel="stylesheet"
	href="/complaintManagementSystem/res/index.css">
	<style type="text/css">
	.circle-loader {
    display: flex;
    justify-content: center;
    align-items: center;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 200px;
    height: 200px;
}

/* Image in the center */
.circle-loader img {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 150px;
    height: 150px;
    border-radius: 50%;
}

/* Circle around the image */
.circle-loader::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    border-radius: 50%;
    border: 4px solid transparent;
    border-top: 4px solid  #ff1e00;
    border-right: 4px solid  #ff1e00;
    animation: drawCircle 3s linear forwards;
}

/* Glow effect on completion */
.circle-loader.glow::before {
    box-shadow: 0 0 15px 5px  #ff1e00;
}

/* Keyframes for drawing the circle */
@keyframes drawCircle {
    0% {
        transform: rotate(0deg);
        border-color: transparent;
    }

    100% {
        transform: rotate(360deg);
        border-color:  #ff1e00;
    }
}

/* Hide the main content initially */
.main-content {
    display: none;
    width: 100vw;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Arial, sans-serif;
    background-color: #f8f9fa;
    /* Ensures padding doesn't break the layout */
}

/* Show the main content after loading */
.show-content {
    display: block;
}

/* Responsiveness */
@media (max-width: 768px) {
    .circle-loader {
        width: 150px;
        height: 150px;
    }

    .circle-loader img {
        width: 100px;
        height: 100px;
    }
}
	
	
	
	</style>
</head>

<body>
<div class="circle-loader" id="loader">
        <img src="/complaintManagementSystem/res/companyLogo.jpg" alt="Loading Icon"> <!-- Add your icon image here -->
    </div>
    <div class="main-content" id="main-page">
	<div class="container-fluid">
		<header class="sticky-top py-1 shadow-sm bg-black">
			<div class="container-fluid">
				<div class="row align-items-center">
					<div class="col-md-12 text-end">
						<nav class="navbar navbar-expand-lg navbar-dark">
							<a class="navbar-brand" href="#"> <!-- <div class="logo-container"> -->
								<img src="/complaintManagementSystem/res/companyLogo.jpg"
								alt="Company Logo" width="50" height="40" class="nav-logo">
								<span class="company-name">ResolveX</span> <!-- </div> -->
							</a>
							<button class="navbar-toggler ms-auto" type="button"
								id="toggleSidebar">
								<i class="fas fa-bars"></i>
							</button>
							<div class="collapse navbar-collapse justify-content-end"
								id="navbarNav">
								<ul class="navbar-nav">
									<!-- User Dropdown -->
									<li class="nav-item dropdown"><a
										class="nav-link dropdown-toggle text-white" href="#"
										role="button" data-bs-toggle="dropdown" aria-expanded="false">
											USER </a>
										<ul class="dropdown-menu bg-dark border-0">
											<li><a class="dropdown-item " href="SignInPage">Sign
													In</a></li>
											<li><a class="dropdown-item " href="SignUpPage">Sign
													Up</a></li>
										</ul></li>

									<!-- Admin Link -->
									<li class="nav-item"><a class="nav-link "
										href="AdminLoginPage">ADMIN</a></li>

									<!-- Department Link -->
									<li class="nav-item"><a class="nav-link "
										href="departmentLoginPage">DEPARTMENT</a></li>

									<!-- Employee Link -->
									<li class="nav-item"><a class="nav-link "
										href="EmployeeLoginLoginPage">EMPLOYEE</a></li>
								</ul>
							</div>
						</nav>
					</div>
				</div>
			</div>
		</header>
		<div id="sidebar" class="offcanvas-sidebar">
			<div class="sidebar-content">
				<button type="button" class="btn-close-sidebar" id="closeSidebar">X</button>
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="SignInPage">Sign
							In</a></li>
					<li class="nav-item"><a class="nav-link" href="SignUpPage">Sign
							Up</a></li>
					<li class="nav-item"><a class="nav-link" href="AdminLoginPage">ADMIN</a></li>
					<li class="nav-item"><a class="nav-link"
						href="departmentLoginPage">DEPARTMENT</a></li>
					<li class="nav-item"><a class="nav-link"
						href="EmployeeLoginLoginPage">EMPLOYEE</a></li>
				</ul>
			</div>
		</div>


		<main class="container py-4">
			<!-- Home Section -->
			<section id="home" class="pb-5">
				<div class="row align-items-center">
					<div class="col-md-6 ">

						<img src="/complaintManagementSystem/res/companyLogo.jpg"
							alt="Compliance Management System Image"
							class="img-fluid company-logo">
					</div>
					<div class="col-md-6">
						<h1 class="mt-5 animated-heading">
							Welcome to Our <span class="highlight-text">ResolveX</span>
						</h1>
						<p class="lead styled-paragraph">Our system helps
							organizations streamline their compliance processes, ensuring
							adherence to regulations and best practices.</p>
					</div>
				</div>
			</section>

			<!-- About Us Section -->
			<section id="about-us" class="py-5">
				<div class="row align-items-center">
					<div class="col-md-6">
						<img src="/complaintManagementSystem/res/Untitled Project.png"
							alt="Company Logo" class="img-fluid company-logo">
					</div>
					<div class="col-md-6">
						<h2>
							About <span style="color: #ff1e00;"> Us </span>
						</h2>
						<p class="about-text">ResolveX is a cutting-edge solution
							designed to assist businesses in managing their compliance
							challenges efficiently. Our platform ensures that organizations
							adhere to industry regulations, helping them avoid penalties and
							fostering best practices.</p>
					</div>
				</div>
			</section>

			<!-- Our Services Section -->
			<section id="services" class="py-5">
				<h2 class="text-center mb-4">
					Our <span style="color: #ff1e00;"> Services</span>
				</h2>
				<div class="bg-light py-3 mt-4">
					<div class="row">
						<div class="col-md-12 text-center">
							<div class="row">
								<div class="col-md-4 mb-3">
									<div class="card">
										<img
											src="/complaintManagementSystem/res/Plumbing Services.webp"
											alt="Plumbing Services" class="card-img-top">
										<div class="card-body">
											<h5 class="card-title">Plumbing Services</h5>
											<ul class="list-group list-group-flush">
												<li class="list-group-item">Pipe installation and
													repair</li>
												<li class="list-group-item">Leak detection and repair</li>
												<li class="list-group-item">Drain cleaning</li>
												<li class="list-group-item">Water heater installation
													and repair</li>
												<li class="list-group-item">Sewer line repair and
													replacement</li>
												<li class="list-group-item">Bathroom and kitchen
													plumbing</li>
											</ul>
										</div>
									</div>
								</div>

								<div class="col-md-4 mb-3">
									<div class="card">
										<img
											src="/complaintManagementSystem/res/Electrical Services.webp"
											width="200" height="200" alt="Electrical Services"
											class="card-img-top">
										<div class="card-body">
											<h5 class="card-title">Electrical Services</h5>
											<ul class="list-group list-group-flush">
												<li class="list-group-item">Electrical wiring and
													rewiring</li>
												<li class="list-group-item">Circuit breaker
													installation and repair</li>
												<li class="list-group-item">Lighting installation and
													repair</li>
												<li class="list-group-item">Electrical panel upgrades</li>
												<li class="list-group-item">Outlet and switch
													installation</li>
												<li class="list-group-item">Emergency electrical
													services</li>
											</ul>
										</div>
									</div>
								</div>
								<div class="col-md-4 mb-3">
									<div class="card">
										<img
											src="/complaintManagementSystem/res/Car tire service tools.png"
											width="200" height="200" style="object-fit: cover;"
											alt="Mechanical Services" class="card-img-top">
										<div class="card-body">
											<h5 class="card-title">Mechanical Services</h5>
											<ul class="list-group list-group-flush">
												<li class="list-group-item">HVAC (Heating, Ventilation,
													and Air Conditioning) installation and repair</li>
												<li class="list-group-item">Furnace and boiler
													maintenance</li>
												<li class="list-group-item">Air conditioning unit
													installation and repair</li>
												<li class="list-group-item">Duct cleaning and repair</li>
												<li class="list-group-item">Thermostat installation and
													repair</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-4 mb-3">
									<div class="card">
										<img
											src="/complaintManagementSystem/res/handyman services.webp"
											alt="General Handyman Services" class="card-img-top">
										<div class="card-body">
											<h5 class="card-title">General Handyman Services</h5>
											<ul class="list-group list-group-flush">
												<li class="list-group-item">Furniture assembly</li>
												<li class="list-group-item">Home repairs (doors,
													windows, drywall)</li>
												<li class="list-group-item">Painting and touch-ups</li>
												<li class="list-group-item">Fixture installation
													(shelves, cabinets)</li>
												<li class="list-group-item">Minor carpentry work</li>
											</ul>
										</div>
									</div>
								</div>
								<div class="col-md-4 mb-3">
									<div class="card">
										<img
											src="/complaintManagementSystem/res/Appliance Repair Services.webp"
											alt="Appliance Repair Services" class="card-img-top">
										<div class="card-body">
											<h5 class="card-title">Appliance Repair Services</h5>
											<ul class="list-group list-group-flush">
												<li class="list-group-item">Refrigerator repair</li>
												<li class="list-group-item">Washing machine and dryer
													repair</li>
												<li class="list-group-item">Dishwasher repair</li>
												<li class="list-group-item">Oven and stove repair</li>
												<li class="list-group-item">Microwave repair</li>
											</ul>
										</div>
									</div>
								</div>
								<div class="col-md-4 mb-3">
									<div class="card">
										<img
											src="/complaintManagementSystem/res/Landscaping and Lawn Care.webp"
											alt="Landscaping and Lawn Care" class="card-img-top">
										<div class="card-body">
											<h5 class="card-title">Landscaping and Lawn Care</h5>
											<ul class="list-group list-group-flush">
												<li class="list-group-item">Lawn mowing and maintenance</li>
												<li class="list-group-item">Tree trimming and removal</li>
												<li class="list-group-item">Garden planting and
													maintenance</li>
												<li class="list-group-item">Irrigation system
													installation and repair</li>
												<li class="list-group-item">Landscape design</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-4 mb-3">
									<div class="card">
										<img
											src="/complaintManagementSystem/res/Cleaning Services.webp"
											alt="Cleaning Services" class="card-img-top">
										<div class="card-body">
											<h5 class="card-title">Cleaning Services</h5>
											<ul class="list-group list-group-flush">
												<li class="list-group-item">Residential cleaning</li>
												<li class="list-group-item">Commercial cleaning</li>
												<li class="list-group-item">Carpet cleaning</li>
												<li class="list-group-item">Window cleaning</li>
												<li class="list-group-item">Post-construction cleaning</li>
											</ul>
										</div>
									</div>
								</div>
								<div class="col-md-4 mb-3">
									<div class="card">
										<img
											src="/complaintManagementSystem/res/Pest Control Services.webp"
											alt="Pest Control Services" class="card-img-top">
										<div class="card-body">
											<h5 class="card-title">Pest Control Services</h5>
											<ul class="list-group list-group-flush">
												<li class="list-group-item">Termite control</li>
												<li class="list-group-item">Rodent control</li>
												<li class="list-group-item">Insect extermination</li>
												<li class="list-group-item">Bed bug treatment</li>
												<li class="list-group-item">Wildlife removal</li>
											</ul>
										</div>
									</div>
								</div>
								<div class="col-md-4 mb-3">
									<div class="card">
										<video
											src="/complaintManagementSystem/res/roofing-construction-site-animation-download-in-lottie-json-gif-static-svg-file-formats--roof-contractor-framing-install-labour-roofer-workers-on-pack-people-animations-8838985.webm"
											autoplay></video>

										<div class="card-body">
											<h5 class="card-title">Roofing Services</h5>
											<ul class="list-group list-group-flush">
												<li class="list-group-item">Roof installation and
													replacement</li>
												<li class="list-group-item">Roof repair and maintenance</li>
												<li class="list-group-item">Gutter installation and
													cleaning</li>
												<li class="list-group-item">Skylight installation and
													repair</li>
											</ul>
										</div>
									</div>
								</div>
							</div>

						</div>
					</div>
				</div>
			</section>
			<section id="contact-and-directions" class="py-5">
				<div class="container">
					<div class="row">
						<!-- Contact Us Section (Left Side) -->
						<div class="col-md-6">
							<h2>Contact Us</h2>
							<p>
								<strong>Address:</strong> 123 ResolveX Street,vijyaanagar,
								Bengaluru City, INDIA<br> <strong>Phone:</strong> +91 812
								315 7890<br> <strong>Email:</strong>
								resolvexsolution@gmail.com
							</p>
							<p>
								<strong>Business Hours:</strong><br> Monday - Friday: 9 AM
								- 6 PM<br> Saturday: 10 AM - 4 PM<br> Sunday: Closed
							</p>
						</div>

						<!-- Directions Section (Right Side) -->
						<div class="col-md-6">
							<h2>Directions</h2>
							<div class="embed-responsive embed-responsive-16by9">
								<!-- Replace the src value with your Google Maps embed link -->
								<iframe
									src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d31104.15513322791!2d77.51214271479682!3d12.970610890027862!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bae3dd95efc3ae7%3A0xc90db791aedd9aad!2sVijayanagar%2C%20Bengaluru%2C%20Karnataka!5e0!3m2!1sen!2sin!4v1724524298495!5m2!1sen!2sin"
									width="600" height="450" style="border: 0;" allowfullscreen=""
									loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
							</div>
						</div>
					</div>
				</div>
			</section>
			<section id="contactUs" class="py-5">
				<div class="container">
					<h4 class="text-center mb-4">Want to Know More? Drop Us a Mail</h4>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="firstName">First Name</label> <input type="text"
									class="form-control" id="firstName" placeholder="First Name"
									required>
							</div>
							<div class="form-group">
								<label for="email">Email</label> <input type="email"
									class="form-control" id="email" placeholder="Email" required>
							</div>
							<div class="form-group">
								<label for="message">Your message here...</label>
								<textarea class="form-control" id="message"
									placeholder="Your message here..." rows="3" required
									style="resize: none; height: 150px; width: 100%;"></textarea>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="lastName">Last Name</label> <input type="text"
									class="form-control" id="lastName" placeholder="Last Name"
									required>
							</div>
							<div class="form-group">
								<label for="contactNumber">Contact Number</label> <input
									type="text" class="form-control" id="contactNumber"
									placeholder="Contact Number" required>
							</div>
						</div>
					</div>
					<div class="text-center mt-4">
						<button type="submit" class="btn btn-custom" id="submitBtn">SUBMIT</button>
					</div>
				</div>
			</section>


		</main>
		<footer class="py-3 my-4">
			<div class="container-fluid p-0 m-0">
				<div class="row">
					<!-- Left side (Footer Logo) -->
					<div
						class="col-md-4 col-sm-12 d-flex justify-content-center justify-content-md-start align-items-center mb-3 mb-md-0">
						<img src="/complaintManagementSystem/res/companyLogo.jpg"
							alt="ResolveX Logo" class="img-fluid footer-logo">
					</div>

					<!-- Center side (Social Icons) -->
					<div class="col-md-4 col-sm-12 text-center">
						<h5 class="text-white">
							Follow <span style="color: #ff1e00;">us</span>
						</h5>
						<div class="d-flex justify-content-center mt-3">
<ul class="wrapper">
  <li class="icon facebook">
  <a href="https://www.facebook.com" target="_blank">
    <span class="tooltip">Facebook</span>
    <svg
      viewBox="0 0 320 512"
      height="1.2em"
      fill="currentColor"
      xmlns="http://www.w3.org/2000/svg"
    >
      <path
        d="M279.14 288l14.22-92.66h-88.91v-60.13c0-25.35 12.42-50.06 52.24-50.06h40.42V6.26S260.43 0 225.36 0c-73.22 0-121.08 44.38-121.08 124.72v70.62H22.89V288h81.39v224h100.17V288z"
      ></path>
    </svg></a>
  </li>
  <li class="icon twitter">
   <a href="https://www.twitter.com" target="_blank">
    <span class="tooltip">Twitter</span>
    <svg
      height="1.8em"
      fill="currentColor"
      viewBox="0 0 48 48"
      xmlns="http://www.w3.org/2000/svg"
      class="twitter"
    >
      <path
        d="M42,12.429c-1.323,0.586-2.746,0.977-4.247,1.162c1.526-0.906,2.7-2.351,3.251-4.058c-1.428,0.837-3.01,1.452-4.693,1.776C34.967,9.884,33.05,9,30.926,9c-4.08,0-7.387,3.278-7.387,7.32c0,0.572,0.067,1.129,0.193,1.67c-6.138-0.308-11.582-3.226-15.224-7.654c-0.64,1.082-1,2.349-1,3.686c0,2.541,1.301,4.778,3.285,6.096c-1.211-0.037-2.351-0.374-3.349-0.914c0,0.022,0,0.055,0,0.086c0,3.551,2.547,6.508,5.923,7.181c-0.617,0.169-1.269,0.263-1.941,0.263c-0.477,0-0.942-0.054-1.392-0.135c0.94,2.902,3.667,5.023,6.898,5.086c-2.528,1.96-5.712,3.134-9.174,3.134c-0.598,0-1.183-0.034-1.761-0.104C9.268,36.786,13.152,38,17.321,38c13.585,0,21.017-11.156,21.017-20.834c0-0.317-0.01-0.633-0.025-0.945C39.763,15.197,41.013,13.905,42,12.429"
      ></path>
    </svg>  </a>
  </li>
  <li class="icon instagram">
    <a href="https://www.instagram.com" target="_blank">
    <span class="tooltip">Instagram</span>
    <svg
      xmlns="http://www.w3.org/2000/svg"
      height="1.2em"
      fill="currentColor"
      class="bi bi-instagram"
      viewBox="0 0 16 16"
    >
      <path
        d="M8 0C5.829 0 5.556.01 4.703.048 3.85.088 3.269.222 2.76.42a3.917 3.917 0 0 0-1.417.923A3.927 3.927 0 0 0 .42 2.76C.222 3.268.087 3.85.048 4.7.01 5.555 0 5.827 0 8.001c0 2.172.01 2.444.048 3.297.04.852.174 1.433.372 1.942.205.526.478.972.923 1.417.444.445.89.719 1.416.923.51.198 1.09.333 1.942.372C5.555 15.99 5.827 16 8 16s2.444-.01 3.298-.048c.851-.04 1.434-.174 1.943-.372a3.916 3.916 0 0 0 1.416-.923c.445-.445.718-.891.923-1.417.197-.509.332-1.09.372-1.942C15.99 10.445 16 10.173 16 8s-.01-2.445-.048-3.299c-.04-.851-.175-1.433-.372-1.941a3.926 3.926 0 0 0-.923-1.417A3.911 3.911 0 0 0 13.24.42c-.51-.198-1.092-.333-1.943-.372C10.443.01 10.172 0 7.998 0h.003zm-.717 1.442h.718c2.136 0 2.389.007 3.232.046.78.035 1.204.166 1.486.275.373.145.64.319.92.599.28.28.453.546.598.92.11.281.24.705.275 1.485.039.843.047 1.096.047 3.231s-.008 2.389-.047 3.232c-.035.78-.166 1.203-.275 1.485a2.47 2.47 0 0 1-.599.919c-.28.28-.546.453-.92.598-.28.11-.704.24-1.485.276-.843.038-1.096.047-3.232.047s-2.39-.009-3.233-.047c-.78-.036-1.203-.166-1.485-.276a2.478 2.478 0 0 1-.92-.598 2.48 2.48 0 0 1-.6-.92c-.109-.281-.24-.705-.275-1.485-.038-.843-.046-1.096-.046-3.233 0-2.136.008-2.388.046-3.231.036-.78.166-1.204.276-1.486.145-.373.319-.64.599-.92.28-.28.546-.453.92-.598.282-.11.705-.24 1.485-.276.738-.034 1.024-.044 2.515-.045v.002zm4.988 1.328a.96.96 0 1 0 0 1.92.96.96 0 0 0 0-1.92zm-4.27 1.122a4.109 4.109 0 1 0 0 8.217 4.109 4.109 0 0 0 0-8.217zm0 1.441a2.667 2.667 0 1 1 0 5.334 2.667 2.667 0 0 1 0-5.334z"
      ></path>
    </svg>  </a>
  </li>
</ul>
						   
							
						</div>
					</div>

					<!-- Right side (Subscribe Form) -->
					<div class="col-md-4 col-sm-12 text-center">
						<h5 style="color: #ff1e00;">Subscribe</h5>
						<p class="mt-3 text-white">Don't miss to subscribe to our new
							feeds, kindly fill the form below.</p>
						<form action="" id="subscriptionForm">
							<div class="input-group mt-3">
								<input type="text"
									style="background-color: black; color: white;"
									class="form-control" placeholder="Email Address"
									id="subscribeEmail" aria-label="Email Address"
									aria-describedby="basic-addon2">
								<div class="input-group-append">
									<button class="btn btn-outline-secondary"
										style="background-color: #ff1e00;" type="button"
										id="subscribeButton">
										<i style="color: white;" class="fas fa-paper-plane"></i>
									</button>
								</div>
							</div>
						</form>

					</div>
				</div>

				<!-- Footer Links and Copyright -->
				<div class="row mt-3">
					<div class="col-12 text-center">
						<ul class="nav justify-content-center">
							<li class="nav-item"><a class="nav-link text-white"
								href="#home">Home</a></li>
							<li class="nav-item"><a class="nav-link text-white"
								href="#about-us">About</a></li>
							<li class="nav-item"><a class="nav-link text-white"
								href="#services">Our Services</a></li>
							<li class="nav-item"><a class="nav-link text-white"
								href="#contact-and-directions">Contact Us</a></li>
							<li class="nav-item"><a class="nav-link text-white"
								href="#contact-and-directions">Directions</a></li>
						</ul>
						
							 <div class="text-center">
                <p class="copy mt-2 text-white">&copy; Copyright 2024, All Right Reserved</p>
                <p class="text-white">Made with ❤️ by <a class="link-danger" href="https://ravikumarxworkz.github.io/"
                        target="_blank">Ravikumar S Kumbar</a></p>
            </div>
					</div>
				</div>
			</div>
		</footer>

	</div>
	</div>
	<script>
    // Function to add glow effect and hide loader to show main content
    window.addEventListener('load', () => {
        // Simulate a loading time of 6 seconds (matches the CSS animation)
        document.body.style.backgroundColor = 'black';
        setTimeout(() => {
            const loader = document.getElementById('loader');
            loader.classList.add('glow'); // Add glow effect
            
            setTimeout(() => {
                loader.style.display = 'none'; // Hide the loader
                document.getElementById('main-page').classList.add('show-content');
                document.body.style.backgroundColor = '#ecf0f3';
            }, 1000); // Wait 1 second for the glow effect before showing content
        }, 3000); // 6 seconds for the initial animation
    });
</script>
	<script>
		$(document)
				.ready(
						function() {
							$('#submitBtn')
									.click(
											function(event) {
												event.preventDefault(); // Prevent the default form submission

												// Capture form data
												var firstName = $('#firstName')
														.val().trim();
												var lastName = $('#lastName')
														.val().trim();
												var email = $('#email').val()
														.trim();
												var contactNumber = $(
														'#contactNumber').val()
														.trim();
												var message = $('#message')
														.val().trim();

												// Simple validation
												if (firstName === ""
														|| lastName === ""
														|| email === ""
														|| contactNumber === ""
														|| message === "") {
													alert("Please fill in all required fields.");
													return;
												}

												// Perform the AJAX request
												$
														.ajax({
															url : '/complaintManagementSystem/contact-us', // The URL to send the request to
															type : 'POST', // The HTTP method to use
															contentType : 'application/json',
															data : JSON
																	.stringify({
																		firstName : firstName,
																		lastName : lastName,
																		email : email,
																		contactNumber : contactNumber,
																		message : message
																	}),
															success : function(
																	response) {
																alert('Thank you for contacting us. We will get back to you soon.');
																// Optionally, clear the form fields
																$('#firstName')
																		.val('');
																$('#lastName')
																		.val('');
																$('#email')
																		.val('');
																$(
																		'#contactNumber')
																		.val('');
																$('#message')
																		.val('');
															},
															error : function(
																	xhr,
																	status,
																	error) {
																alert('There was an error submitting the form. Please try again later.');
															}
														});
											});
						});
	</script>


	<script>
		// Handle Sidebar Toggle
		// Handle Sidebar Toggle
		document.getElementById("toggleSidebar").addEventListener("click",
				function() {
					document.getElementById("sidebar").classList.add("show");
				});

		// Handle Sidebar Close with Red Button
		document.getElementById("closeSidebar")
				.addEventListener(
						"click",
						function() {
							document.getElementById("sidebar").classList
									.remove("show");
						});
	</script>

	<script>
		$(document)
				.ready(
						function() {
							$('#subscribeButton')
									.click(
											function(event) {
												event.preventDefault(); // Prevent the default action

												// Capture the email value
												var subscribeEmail = $(
														'#subscribeEmail')
														.val().trim(); // Use .trim() to remove any leading/trailing whitespace

												// Check if the email field is empty
												if (subscribeEmail === "") {
													alert("Please enter your email address.");
													return; // Stop the function if the email is empty
												}

												// Perform the AJAX request
												$
														.ajax({
															url : '/complaintManagementSystem/subscribe', // The URL to send the request to
															type : 'POST', // The HTTP method to use
															data : { // Data to be sent to the server
																email : subscribeEmail
															},
															success : function(
																	response) {
																// Handle the success response from the server
																alert(response); // Show the success message returned by the server

																// Clear the form input fields
																$(
																		'#subscribeEmail')
																		.val(''); // Clear the email input field
															},
															error : function(
																	xhr,
																	status,
																	error) {
																// Handle the error response from the server
																if (xhr.status === 409) {
																	alert("This email is already subscribed."); // Conflict, email already exists
																} else {
																	alert('Subscription failed. Please try again later.');
																}
															}
														});
											});
						});
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
