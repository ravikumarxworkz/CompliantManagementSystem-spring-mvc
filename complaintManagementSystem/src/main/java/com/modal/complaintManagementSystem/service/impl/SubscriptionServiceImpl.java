package com.modal.complaintManagementSystem.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modal.complaintManagementSystem.entity.Subscription;
import com.modal.complaintManagementSystem.mailSending.MailSending;
import com.modal.complaintManagementSystem.repository.SubscriptionRepository;
import com.modal.complaintManagementSystem.service.SubscriptionService;

@Service
public class SubscriptionServiceImpl implements SubscriptionService {

	@Autowired
	private SubscriptionRepository subscriptionRepository;

	@Autowired
	private MailSending mailSending;

	public boolean subscribeUser(String email) {
		// Check if the email already exists
		if (subscriptionRepository.existsByEmail(email)) {
			return false; // Email already exists
		}

		Subscription subscription = new Subscription();
		subscription.setEmail(email);
		subscriptionRepository.save(subscription);
		boolean sendEmail = this.mailSending.sendSubscriptionConfirmation(email);
		if (sendEmail) {
			return true;
		}
		return false;
	}

}
