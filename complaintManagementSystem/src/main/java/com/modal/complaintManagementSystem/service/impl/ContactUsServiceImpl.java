package com.modal.complaintManagementSystem.service.impl;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modal.complaintManagementSystem.dto.ContactUsDTO;
import com.modal.complaintManagementSystem.entity.ContactUs;
import com.modal.complaintManagementSystem.mailSending.MailSending;
import com.modal.complaintManagementSystem.repository.ContactUsRepository;
import com.modal.complaintManagementSystem.service.ContactUsService;
import com.modal.complaintManagementSystem.utils.ExcelUtils;

@Service
public class ContactUsServiceImpl implements ContactUsService {

	@Autowired
	private ContactUsRepository contactUsRepository;

	@Autowired
	private MailSending mailSending;

	public boolean saveContactDetails(ContactUsDTO contactUsDTO) {
		try {
			ContactUs contactUs = createContactUsEntity(contactUsDTO);
			contactUsRepository.save(contactUs);
			// Send confirmation email
			ExcelUtils.writeToExcel(contactUs);
			boolean sendEmail = mailSending.sendContactUsConfirmation(contactUsDTO.getEmail(),
					contactUsDTO.getFirstName());
			if (sendEmail) {
				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return false;
	}

	private ContactUs createContactUsEntity(ContactUsDTO contactUsDTO) {
		ContactUs contactUs = new ContactUs();
		contactUs.setFirstName(contactUsDTO.getFirstName());
		contactUs.setLastName(contactUsDTO.getLastName());
		contactUs.setEmail(contactUsDTO.getEmail());
		contactUs.setContactNumber(contactUsDTO.getContactNumber());
		contactUs.setMessage(contactUsDTO.getMessage());
		contactUs.setCreatedAt(LocalDateTime.now());
		return contactUs;
	}

}
