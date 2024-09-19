package com.modal.complaintManagementSystem.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.modal.complaintManagementSystem.dto.DashboardDataDto;
import com.modal.complaintManagementSystem.exception.AdminNotFoundException;
import com.modal.complaintManagementSystem.exception.InvalidPasswordException;
import com.modal.complaintManagementSystem.service.AdminService;


@Controller
@RequestMapping("/")
public class AdminController {

	@Autowired
	private AdminService adminService;

	@GetMapping("AdminLoginPage")
	public String AdminLoginPage() {
		return "Adminlogin";

	}

	@GetMapping("/dashboardData")
	@ResponseBody
	public DashboardDataDto getDashboardData() {
		DashboardDataDto response = this.adminService.getDashboardData();
		return response;
	}

	@PostMapping("adminLogin")
	public String adminLogin(@RequestParam String email, @RequestParam String password, Model model)
			throws InvalidPasswordException {
		try {
			// Check if email or password is null
			if (email == null || password == null) {
				model.addAttribute("error", "Email or password cannot be null");
				return "Adminlogin";
			}

			// Check if admin login is valid
			boolean login = adminService.adminLogin(email, password);
			if (login) {
				return "AdminDashboard";
			} else {
				model.addAttribute("error", "Invalid password");
				return "Adminlogin";
			}

		} catch (AdminNotFoundException e) {
			// Handle case where admin is not found
			model.addAttribute("error", "Admin not found");
			return "Adminlogin";
		} catch (NullPointerException e) {
			// Handle unexpected null pointer exception
			model.addAttribute("error", "An unexpected error occurred");
			return "Adminlogin";
		} catch (Exception e) {
			// Handle any other unexpected exceptions
			model.addAttribute("error", "An unexpected error occurred");
			return "Adminlogin";
		}
	}

}
