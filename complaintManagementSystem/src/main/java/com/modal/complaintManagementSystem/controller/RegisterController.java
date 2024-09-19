package com.modal.complaintManagementSystem.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.modal.complaintManagementSystem.dto.UserDto;
import com.modal.complaintManagementSystem.service.UserService;


@RestController
@RequestMapping("/")
@EnableWebMvc
public class RegisterController {

	@Autowired
	private UserService userService;

	@GetMapping(value = "/checkEmailExistence/{email}", produces = MediaType.APPLICATION_JSON_VALUE)
	public String checkEmailExistence(@PathVariable String email) {
		boolean existsByEmailId = userService.existsByEmail(email);
		if (existsByEmailId) {
			return "EmailIDexists";
		} else {
			return "EmailIDnotexists";
		}
	}

	@GetMapping(value = "/checkContactNumberExistence/{contactNumber}", produces = MediaType.APPLICATION_JSON_VALUE)
	public String checkContactNumberExistence(@PathVariable Long contactNumber) {
		boolean existsByContactNumber = userService.existsByContactNumber(contactNumber);
		if (existsByContactNumber) {
			return "contactNumberexists";
		} else {
			return "contactNumberNotExists";
		}
	}

	@PostMapping("/userRegister")
	public ResponseEntity<?> saveVendorDTO(@RequestBody @Valid UserDto dto, BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			System.out.println(dto);
			StringBuilder errorMessages = new StringBuilder();
			bindingResult.getAllErrors().forEach(error -> errorMessages.append(error.getDefaultMessage()).append(" "));
			return ResponseEntity.badRequest().body(errorMessages.toString());
		}

		UserDto savedUser = userService.validateAndSaveUserDto(dto);
		if (savedUser != null) {
			return ResponseEntity.ok("User registered successfully");
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("User registration failed. Please try again.");
		}
	}

}
