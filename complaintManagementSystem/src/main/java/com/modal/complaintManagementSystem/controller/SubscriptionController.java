package com.modal.complaintManagementSystem.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.modal.complaintManagementSystem.service.SubscriptionService;

@RestController
@RequestMapping("/")
public class SubscriptionController {

	@Autowired
	private SubscriptionService subscriptionService;

	@PostMapping("/subscribe")
	public ResponseEntity<String> subscribe(@RequestParam("email") String email) {
		boolean isSubscribed = subscriptionService.subscribeUser(email);
		if (isSubscribed) {
			return ResponseEntity.ok("Thank you for Subscription❤️!");
		} else {
			return ResponseEntity.status(HttpStatus.CONFLICT).body("This email is already subscribed.");
		}
	}

}
