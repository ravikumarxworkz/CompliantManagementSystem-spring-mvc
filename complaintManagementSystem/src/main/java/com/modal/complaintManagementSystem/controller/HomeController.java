package com.modal.complaintManagementSystem.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;



@Controller
public class HomeController {

	

	@GetMapping("/")
	public String index() {
		return "index";
	}

	@GetMapping("/HomePage")
	public String HomePage() {
		return "index";
	}

	@GetMapping("/SignInPage")
	public String signin() {
		return "signin";
	}

	@GetMapping("/SignUpPage")
	public String signup() {
		return "signup";
	}

	@GetMapping("/ResetPasswordPage")
	public String ResetPassword() {
		return "ResetPassword";
	}
	
	@GetMapping("/departmentLoginPage")
	public String departmentLoginPage() {
		return "DepartmentLogin";
	}
	
	@GetMapping("/EmployeeLoginLoginPage")
	public String employeeLoginPage() {
		return "EmployeeLogin";
	}


}
