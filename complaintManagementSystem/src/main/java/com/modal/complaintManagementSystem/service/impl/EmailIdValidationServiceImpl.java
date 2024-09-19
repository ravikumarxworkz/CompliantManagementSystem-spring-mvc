package com.modal.complaintManagementSystem.service.impl;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.Random;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.modal.complaintManagementSystem.entity.EmailValidationEntity;
import com.modal.complaintManagementSystem.mailSending.MailSending;
import com.modal.complaintManagementSystem.repository.EmailIdValidationRepo;
import com.modal.complaintManagementSystem.service.EmailIdValidationService;

@Service
@Transactional
public class EmailIdValidationServiceImpl implements EmailIdValidationService {

	@Autowired
	private EmailIdValidationRepo emailIdValidationRepo;

	@Autowired
	private MailSending mailSending;

    @Override
    public boolean saveOTPByEmailId(String email) {
        if (email != null) {
            Random random = new Random();
            int generatedOtp = random.nextInt(900000) + 100000;
            String OTP = String.valueOf(generatedOtp);

            EmailValidationEntity entity = new EmailValidationEntity();
            entity.setEmail(email);
            entity.setOtp(OTP); // Correctly sets OTP using setter method
            entity.setCreatedAt(LocalDateTime.now());

            entity = emailIdValidationRepo.save(entity);

            if (entity != null) {
                boolean sent = mailSending.sendEmailVerificationOTP(email, OTP);
                if (sent) {
                    return true;
                }
            }
        }

        return false;
    }

	@Override
	public boolean validateOTP(String email, String otp) {
		System.out.println("service");
		if (email != null && otp != null) {
			Optional<EmailValidationEntity> optionalEmailValidationEntity = emailIdValidationRepo
					.findFirstByEmailOrderByCreatedAtDesc(email);
			System.out.println(optionalEmailValidationEntity);
			if (optionalEmailValidationEntity.isPresent()) {
				EmailValidationEntity emailValidationEntity = optionalEmailValidationEntity.get();
				if (emailValidationEntity.getOtp().equals(otp)) {
					LocalDateTime now = LocalDateTime.now();
					LocalDateTime otpCreationTime = emailValidationEntity.getCreatedAt();
					Duration duration = Duration.between(otpCreationTime, now);
					if (duration.toMinutes() <= 2) {
						emailIdValidationRepo.deleteByEmail(email);
						return true;
					}
				}
			}
		}
		return false;
	}
}
