package com.modal.complaintManagementSystem.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.modal.complaintManagementSystem.dto.ChangePasswordDto;
import com.modal.complaintManagementSystem.dto.ProfileDto;
import com.modal.complaintManagementSystem.exception.InvalidPasswordException;
import com.modal.complaintManagementSystem.exception.PasswordMismatchException;
import com.modal.complaintManagementSystem.exception.ResourceNotFoundException;
import com.modal.complaintManagementSystem.exception.UserNotFoundException;
import com.modal.complaintManagementSystem.response.UsersResponse;
import com.modal.complaintManagementSystem.service.UserService;

@RestController
@SessionAttributes("profileDto")
@RequestMapping("/")
public class UserController {

	@Autowired
	private UserService userService;

	@GetMapping("/getUserProfile")
	public ResponseEntity<ProfileDto> getProfilePage(HttpSession session) {
		ProfileDto profileDto = (ProfileDto) session.getAttribute("profileDto");
		if (profileDto != null) {
			return new ResponseEntity<>(profileDto, HttpStatus.OK);
		} else {
			return new ResponseEntity<>(HttpStatus.NO_CONTENT);
		}
	}

	@PostMapping("/updateProfile")
	public ResponseEntity<String> updateProfile(@Valid @ModelAttribute ProfileDto dto, HttpSession session) {
		try {
			ProfileDto profileDto = (ProfileDto) session.getAttribute("profileDto");
			if (profileDto == null) {
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Profile data not found in session");
			}
			int userId = profileDto.getUserId();
			if (userId == 0) {
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User ID not found in profile data");
			}

			ProfileDto updatedProfileDto = userService.validateAndUpdateUserProfile(dto);

			session.setAttribute("profileDto", updatedProfileDto);

			return ResponseEntity.ok().body("Profile updated successfully");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating profile");
		}
	}

	@GetMapping("/display")
	public void displayUserImageByImagePath(HttpServletResponse response, @RequestParam String imagePath)
			throws IOException {
		String profileImagePath = imagePath;
		File file = new File("D:\\complaintSystemMangement\\" + profileImagePath);
		InputStream in = new BufferedInputStream(new FileInputStream(file));
		ServletOutputStream out = response.getOutputStream();
		IOUtils.copy(in, out);
		response.flushBuffer();
	}

	@PostMapping("/changePassword")
	public ResponseEntity<?> changePassword(@RequestBody ChangePasswordDto changePasswordDto, HttpSession session) {
		try {
			ProfileDto profileDto = (ProfileDto) session.getAttribute("profileDto");
			if (profileDto == null) {
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Profile data not found in session");
			}
			int userId = profileDto.getUserId();
			changePasswordDto.setUserId(userId);
			ProfileDto updatedProfile = userService.changeUserPassword(changePasswordDto);
			return ResponseEntity.ok(updatedProfile);
		} catch (UserNotFoundException | InvalidPasswordException | PasswordMismatchException ex) {
			return ResponseEntity.badRequest().body(ex.getMessage());
		} catch (Exception ex) {
			// Handle unexpected exceptions
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An unexpected error occurred.");
		}
	}

	@GetMapping("/getAllUsers")
	public ResponseEntity<UsersResponse> getAllUsers(@RequestParam(value = "page", defaultValue = "1") int page,
			@RequestParam(value = "size", defaultValue = "10") int size,
			@RequestParam(value = "query", defaultValue = "") String query) {
		try {
			UsersResponse userResponse = userService.getAllUsers(page, size, query);
			return ResponseEntity.ok(userResponse);
		} catch (Exception e) {
			// Log error details
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}
	}

	@GetMapping("/getUserById")
	public ResponseEntity<ProfileDto> getUserById(@RequestParam int id) {
		try {
			// Fetch user profile from the service
			ProfileDto profileDto = this.userService.getUserProfile(id);
			if (profileDto == null) {
				// Return 404 Not Found if user profile is null
				return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
			}
			return ResponseEntity.ok(profileDto);
		} catch (ResourceNotFoundException e) {
			// Return 404 Not Found if a ResourceNotFoundException is thrown
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
		}
	}

	@GetMapping("/getUserDetailsByUserId")
	public ResponseEntity<ProfileDto> getUserDetailsByUserId(@RequestParam int userId) {
		try {
			// Get user details from the service
			ProfileDto profileDto = this.userService.getUserDetailsByUserId(userId);
			return ResponseEntity.ok(profileDto);
		} catch (ResourceNotFoundException e) {
			// Return 404 Not Found if user is not found
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
		}
	}

}
