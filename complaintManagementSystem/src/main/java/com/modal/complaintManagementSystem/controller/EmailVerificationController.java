package com.modal.complaintManagementSystem.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.modal.complaintManagementSystem.service.EmailIdValidationService;


@RestController
@RequestMapping("/")
@EnableWebMvc
public class EmailVerificationController {

    @Autowired
    private EmailIdValidationService emailIdValidationService;

    @GetMapping("/genrateOTPAndSave")
    public ResponseEntity<String> genrateOTPAndSave(@RequestParam String email) {
        boolean emailExistsInDatabase = emailIdValidationService.saveOTPByEmailId(email);
        if (emailExistsInDatabase) {
            return ResponseEntity.ok("Exists");
        } else {
            return ResponseEntity.ok("not exists");
        }
    }

    @PostMapping("/validateEmailVerificationOTP")
    public ResponseEntity<String> validateOTP(@RequestParam String email, @RequestParam String otp) {
        boolean validate = emailIdValidationService.validateOTP(email, otp);
        if (validate) {
            return ResponseEntity.ok("valid");
        } else {
            return ResponseEntity.ok("not valid");
        }
    }
}
