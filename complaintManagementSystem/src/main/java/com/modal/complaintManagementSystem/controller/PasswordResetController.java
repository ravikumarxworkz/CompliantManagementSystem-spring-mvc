package com.modal.complaintManagementSystem.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.modal.complaintManagementSystem.service.ResetPasswordService;


@RestController
@RequestMapping("/")
public class PasswordResetController {

	  @Autowired
	    private ResetPasswordService resetPasswordService;

	    @PostMapping("reset-password")
	    public ResponseEntity<String> sendResetPasswordLink(@RequestParam("email") String email, 
	                                                        @RequestParam("role") String role) {
	        boolean userExists = resetPasswordService.checkUserExistence(email, role);
	        
	        if (userExists) {
	            return ResponseEntity.ok("Exists");
	        } else {
	            return ResponseEntity.ok("Does Not Exist");
	        }
	    }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*
	 * @Autowired private PasswordResetTokenService tokenService;
	 * 
	 * // This controller is Handle sending rest Password link to user email
	 * 
	 * @PostMapping("/rest-password-link") public ResponseEntity<String>
	 * sendRestPasswordLink(@RequestParam String email) throws UserNotFoundException
	 * { log.info("Received request to generate password reset link for email: {}",
	 * email); if (email == null || email.isEmpty()) { return
	 * ResponseEntity.badRequest().body("Email is empty"); }
	 * 
	 * boolean sendResetLink = this.tokenService.initiatePasswordReset(email); if
	 * (sendResetLink) { log.info("Password reset link sent for email: {}", email);
	 * return ResponseEntity.ok("Exists"); } else {
	 * log.warn("Email does not exist in the database: {}", email); return
	 * ResponseEntity.ok("Not exists"); } }
	 * 
	 * // This controller is Handle when user click link in this email its redirect
	 * to // rest Password page
	 * 
	 * 
	 * // this controller is going to take password and token from newRestPassword
	 * page // and save to databse;
	 * 
	 * @PostMapping("/reset-password") public ResponseEntity<String>
	 * resetPassword(@RequestParam("token") String token,
	 * 
	 * @RequestParam("newPassword") String
	 * newPassword, @RequestParam("confirmPassword") String confirmPassword) {
	 * 
	 * if(token!=null) { return ResponseEntity.badRequest().body("toen is null"); }
	 * 
	 * // Check if new password and confirm password match if
	 * (!newPassword.equals(confirmPassword)) { return
	 * ResponseEntity.badRequest().body("Passwords do not match"); }
	 * 
	 * 
	 * try { boolean resetPassword = tokenService.resetPassword(token, newPassword);
	 * if (resetPassword) { return
	 * ResponseEntity.ok("Password has been reset successfully"); } else { return
	 * ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).
	 * body("Password reset failed"); } } catch (InvalideToken e) { return
	 * ResponseEntity.badRequest().body("Invalid or expired token"); } catch
	 * (Exception e) { return
	 * ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	 * .body("An error occurred while resetting the password"); } }
	 */

}
