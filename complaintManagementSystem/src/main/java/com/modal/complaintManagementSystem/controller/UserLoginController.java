package com.modal.complaintManagementSystem.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.modal.complaintManagementSystem.dto.DashboardDataDto;
import com.modal.complaintManagementSystem.dto.ProfileDto;
import com.modal.complaintManagementSystem.exception.InvalidPasswordException;
import com.modal.complaintManagementSystem.exception.InvalideEmailException;
import com.modal.complaintManagementSystem.service.UserService;


@Controller
@RequestMapping("/")
public class UserLoginController {
	
	
	private static final Logger logger = LoggerFactory.getLogger(ComplaintController.class);

	@Autowired
	UserService userService;

	@PostMapping("/userlogin")
	public String login(@RequestParam String email, @RequestParam String password, HttpSession session, Model model) {
		if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
			model.addAttribute("error", "Email and Password are required.");
			return "signin";
		}

		try {
			ProfileDto profileDto = userService.loginUser(email, password);
			session.setAttribute("profileDto", profileDto);
			session.setAttribute("loggedInUserEmail", email);
            session.setAttribute("loggedInUserId", profileDto.getUserId());
			return "profile";
		} catch (InvalideEmailException | InvalidPasswordException e) {
			model.addAttribute("error", e.getMessage());
			return "signin";
		}
	}
	@GetMapping("/dashboardDataOfUser")
	@ResponseBody
	public ResponseEntity<?> getDashboardDataOfUser( HttpSession session) {
		try {
			ProfileDto profileDto = (ProfileDto) session.getAttribute("profileDto");
			if (profileDto == null) {
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
						.body("User not logged in or session has expired.");
			} else {
				 DashboardDataDto response=this.userService.dashboardDataOfUser(profileDto.getUserId());
				return ResponseEntity.ok(response);
			}
		} catch (Exception e) {
			logger.error("Error fetching complaints", e);
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("An error occurred while fetching complaints. Please try again later.");
		}
	}
	
	

	@GetMapping("/signOut")
	public String logout(HttpSession session, HttpServletResponse response) {
		session.setAttribute("profileDto", null);
		session.invalidate(); 
		return "redirect:/HomePage"; 
	}

	public static class LoginRequest {
		private String email;
		private String password;

		// Getters and setters
		public String getEmail() {
			return email;
		}

		public void setEmail(String email) {
			this.email = email;
		}

		public String getPassword() {
			return password;
		}

		public void setPassword(String password) {
			this.password = password;
		}
	}
}
