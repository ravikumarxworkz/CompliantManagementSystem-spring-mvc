package com.modal.complaintManagementSystem.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.modal.complaintManagementSystem.dto.ContactUsDTO;
import com.modal.complaintManagementSystem.service.ContactUsService;

@RestController
@RequestMapping("/")
public class ContactUsController {

	@Autowired
	private ContactUsService contactUsService;

	@PostMapping("/contact-us")
	public ResponseEntity<String> handleContactUs(@RequestBody ContactUsDTO contactUsDTO) {
		boolean isSaved = contactUsService.saveContactDetails(contactUsDTO);

		if (isSaved) {
			return ResponseEntity.ok("Thank you for contacting us. We will get back to you soon.");
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("There was an error submitting the form. Please try again later.");
		}
	}
}
