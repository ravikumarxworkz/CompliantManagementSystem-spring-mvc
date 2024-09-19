package com.modal.complaintManagementSystem.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.modal.complaintManagementSystem.dto.DepartmentLoginDto;
import com.modal.complaintManagementSystem.exception.PasswordMismatchException;
import com.modal.complaintManagementSystem.exception.UserNotFoundException;
import com.modal.complaintManagementSystem.service.DepartmentService;

@Controller
@RequestMapping("/")
public class DepartmentLoginController {

	@Autowired
	private DepartmentService departmentService;

	@PostMapping("/departmentAdminLogin")
	public String login(@RequestParam("email") String email, @RequestParam("password") String password, Model model,
			HttpSession session) {
		try {
			DepartmentLoginDto response = departmentService.DepartmentLogin(email, password);
			if (response != null) {
				model.addAttribute("departmentLoginResponse", response);
				session.setAttribute("loggedInUserEmail", email);
				session.setAttribute("loggedInUserDepartmentId", response.getDepartmentId());
				return "DepartmentDashboard";
			} else {
				model.addAttribute("error", "Login failed. Please check your credentials.");
				return "DepartmentLogin";
			}
		} catch (UserNotFoundException | PasswordMismatchException e) {
			model.addAttribute("error", e.getMessage());
			return "DepartmentLogin";
		}
	}

	@GetMapping("/departmentAdminLogOut")
	public String logout(HttpSession session, HttpServletResponse response) {
		session.invalidate();
		return "redirect:/HomePage";
	}

}
