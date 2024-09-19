package com.modal.complaintManagementSystem.mailSending;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;
import com.modal.complaintManagementSystem.dto.UserDto;

@Service
public class MailSending {

	@Autowired
	private JavaMailSender mailSender;

	// Send email verification OTP
	public boolean sendEmailVerificationOTP(String email, String otp) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom("resolvexsolution@gmail.com"); // Set your email here
		message.setTo(email);
		message.setSubject("Email Verification OTP");
		message.setText("Dear User,\n\n" + "Your OTP for email verification is: " + otp + "\n\n"
				+ "Please use this OTP to verify your email address.\n\n" + "Best regards,\n"
				+ "resolvexsolution Team");

		try {
			mailSender.send(message);
			System.out.println("Email verification OTP sent successfully");
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// Send registration success email
	public boolean sendEmailRegisterSuccessfully(UserDto userDto) {
	    try {
	        MimeMessage message = mailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

	        helper.setFrom("resolvexsolution@gmail.com");
	        helper.setTo(userDto.getEmail());
	        helper.setSubject("Thank you for Registering");

	        String content = "<p>Dear " + userDto.getFirstName() + ",</p>" +
	                "<p>Welcome to our community!</p>" +
	                "<p>We are committed to ensuring your satisfaction and addressing any concerns you may have. " +
	                "At the heart of our operations lies our complaint management system, designed to resolve issues swiftly and effectively.</p>" +
	                "<p>The complaint management process is crucial for us to maintain the highest standards of service. " +
	                "Whether it's an issue with a product, service, or any aspect of your experience, our team is dedicated to resolving it promptly.</p>" +
	                "<p>Here's how our complaint management system works:</p>" +
	                "<ul>" +
	                "<li>You can submit a complaint through our website or customer service channels.</li>" +
	                "<li>Each complaint is assigned a unique reference number for easy tracking.</li>" +
	                "<li>Our team will investigate your complaint thoroughly and provide a resolution within the specified timeframe.</li>" +
	                "<li>We prioritize transparency throughout the process, keeping you informed of the status and progress of your complaint.</li>" +
	                "</ul>" +
	                "<p>Your security and satisfaction are paramount to us. We handle all complaints with the utmost confidentiality and professionalism.</p>" +
	                "<p>Below are your registration details:</p>" +
	                "<ul>" +
	                "<li>Owner Name: " + userDto.getFirstName() + "</li>" +
	                "<li>Email: " + userDto.getEmail() + "</li>" +
	                "<li>Contact Number: " + userDto.getContactNumber() + "</li>" +
	                "<li>Alternate Contact Number: " + userDto.getAlterContactNumber() + "</li>" +
	                "<li>Address: " + userDto.getAddress() + "</li>" +
	                "</ul>" +
	                "<p><strong>Your login details:</strong></p>" +
	                "<p>Username: <strong>" + userDto.getEmail() + "</strong></p>" +
	                "<p>Password: <strong><span style='background-color:yellow;'>" + userDto.getPassword() + "</span></strong></p>" +
	                "<p>We look forward to serving you and resolving any concerns you may have. Your feedback is invaluable as we strive to improve our services.</p>" +
	                "<p>Thank you for choosing us. We are here to ensure your experience with us is nothing short of excellent.</p>" +
	                "<p>Best regards,<br>The resolvex Team</p>";

	        helper.setText(content, true);  // Set the second argument to 'true' to indicate HTML content

	        mailSender.send(message);
	        System.out.println("Mail sent successfully");
	        return true;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	// Send password reset link
	public boolean sendPasswordResetLink(String email, String resetLink) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom("resolvexsolution@gmail.com");
		message.setTo(email);
		message.setSubject("Password Reset Request");
		message.setText("Dear User,\n\n"
				+ "We received a request to reset your password. Please use the following link to reset your password:\n\n"
				+ resetLink + "\n\n" + "If you did not request this password reset, please ignore this email.\n\n"
				+ "Best regards,\n" + "The resolvex Team");

		try {
			mailSender.send(message);
			System.out.println("Password reset link sent successfully to " + email);
			return true;
		} catch (Exception e) {
			System.err.println("Error sending password reset link to " + email);
			e.printStackTrace();
			return false;
		}
	}

	// Send OTP for complaint closure
	public boolean sendOtpToUser(String email, String otp) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom("resolvexsolution@gmail.com");
		message.setTo(email);
		message.setSubject("OTP for Complaint Closure");
		message.setText("Dear User,\n\n"
				+ "An employee has updated the complaint status. To finalize the complaint closure, please provide the following OTP to the employee:\n\n"
				+ otp + "\n\n" + "If you did not request this, please contact us immediately.\n\n" + "Best regards,\n"
				+ "The resolvex Team");

		try {
			mailSender.send(message);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// Send subscription confirmation
	public boolean sendSubscriptionConfirmation(String email) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom("resolvexsolution@gmail.com");
		message.setTo(email);
		message.setSubject("Welcome to resolvex – Thank You for Subscribing!");
		message.setText("Dear Subscriber,\n\n"
				+ "Thank you for subscribing to resolvex! We're excited to have you onboard.\n\n"
				+ "At resolvex, our mission is to help you resolve your complaints online with ease and efficiency.\n\n"
				+ "By subscribing, you'll receive the latest updates, tips, and exclusive content directly to your inbox.\n\n"
				+ "If you ever have any questions or need assistance, don't hesitate to reach out. We're here to help!\n\n"
				+ "Best regards,\n" + "The resolvex Team");

		try {
			mailSender.send(message);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// Send contact us confirmation
	public boolean sendContactUsConfirmation(String email, String firstName) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom("resolvexsolution@gmail.com");
		message.setTo(email);
		message.setSubject("Thank You for Contacting Us");
		message.setText("Dear " + firstName + ",\n\n"
				+ "Thank you for reaching out to us. We have received your message and will get back to you as soon as possible.\n\n"
				+ "Best regards,\n" + "The resolvex Team");

		try {
			mailSender.send(message);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean sendResetLink(String email, String role, String newPassword) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setFrom("resolvexsolution@gmail.com");
		message.setTo(email);
		message.setSubject("Reset Password");
		message.setText("Dear " + role + ",\n\n" + "Your password has been reset. Your new password is: " + newPassword
				+ "\n\n" + "Please change your password after logging in.\n\n" + "Best regards,\n" + "ResolveX Team");

		try {
			mailSender.send(message);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

}
