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
import org.springframework.web.bind.annotation.ResponseBody;

import com.modal.complaintManagementSystem.dto.DashboardDataDto;
import com.modal.complaintManagementSystem.dto.EmployeeDto;
import com.modal.complaintManagementSystem.exception.InvalidPasswordException;
import com.modal.complaintManagementSystem.exception.InvalideEmailException;
import com.modal.complaintManagementSystem.service.EmployeeService;

@Controller
@RequestMapping("/")
public class EmployeeLoginController {

	@Autowired
	private EmployeeService employeeService;

	@PostMapping("/employeeLogin")
	public String login(@RequestParam String email, @RequestParam String password, HttpSession session, Model model) {
		if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
			model.addAttribute("error", "Email and Password are required.");
			return "EmployeeLogin";
		}

		try {
			EmployeeDto employeeDto = employeeService.loginEmployee(email, password);
			session.setAttribute("employeeDto", employeeDto);
			session.setAttribute("loggedInEmployeeEmail", email);
			session.setAttribute("loggedInEmployeeId", employeeDto.getEmployeeId());
			return "EmployeeProfile";
		} catch (InvalideEmailException | InvalidPasswordException e) {
			model.addAttribute("error", e.getMessage());
			return "EmployeeLogin";
		}
	}

	@GetMapping("/employeeLogOut")
	public String logout(HttpSession session, HttpServletResponse response) {
		session.invalidate();
		return "redirect:/HomePage";
	}

	@GetMapping("/dashboardDataOfEmployee")
	@ResponseBody
	public DashboardDataDto dashboardDataOfEmployee(@RequestParam int employeeId) {
		DashboardDataDto response = this.employeeService.dashboardDataOfEmployee(employeeId);
		return response;
	}

}
