package com.modal.complaintManagementSystem.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.modal.complaintManagementSystem.entity.AdminEntity;
import com.modal.complaintManagementSystem.entity.DepartmentLogin;
import com.modal.complaintManagementSystem.entity.Employee;
import com.modal.complaintManagementSystem.entity.UserEntity;
import com.modal.complaintManagementSystem.mailSending.MailSending;
import com.modal.complaintManagementSystem.repository.AdminRepository;
import com.modal.complaintManagementSystem.repository.DepartmentLoginRepository;
import com.modal.complaintManagementSystem.repository.EmployeeRepository;
import com.modal.complaintManagementSystem.repository.UserRepository;
import com.modal.complaintManagementSystem.service.ResetPasswordService;
import com.modal.complaintManagementSystem.utils.GeneratePassword;

@Service
public class ResetPasswordServiceImpl implements ResetPasswordService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AdminRepository adminRepository;

    @Autowired
    private DepartmentLoginRepository departmentLoginRepository;

    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    private MailSending emailService;

    @Autowired
    private GeneratePassword generatePassword;

    @Override
    public boolean checkUserExistence(String email, String role) {
        switch (role.toLowerCase()) {
            case "user":
                UserEntity user = userRepository.findByEmail(email);
                if (user != null) {
                    // Generate and set a new password for the user
                    String newPassword = generatePassword.generatePassword();
                    user.setPassword(newPassword);
                    userRepository.save(user);
                    // Send an email with the reset password details
                    emailService.sendResetLink(email, role, newPassword);
                    return true;
                }
                break;

            case "admin":
                AdminEntity admin = adminRepository.findByEmail(email);
                if (admin != null) {
                    String adminPassword = generatePassword.generatePassword();
                    admin.setPassword(adminPassword);
                    adminRepository.save(admin);
                    emailService.sendResetLink(email, role, adminPassword);
                    return true;
                }
                break;

            case "department":
                DepartmentLogin departmentLogin = departmentLoginRepository.findByDepartmentLoginEmail(email);
                if (departmentLogin != null) {
                    String departmentPassword = generatePassword.generatePassword();
                    departmentLogin.setDepartmentLoginPassword(departmentPassword);
                    departmentLoginRepository.save(departmentLogin);
                    emailService.sendResetLink(email, role, departmentPassword);
                    return true;
                }
                break;

            case "employee":
                Employee employee = employeeRepository.findByEmployeeEmail(email);
                if (employee != null) {
                    String employeePassword = generatePassword.generatePassword();
                    employee.setEmployeePassword(employeePassword);
                    employeeRepository.save(employee);
                    emailService.sendResetLink(email, role, employeePassword);
                    return true;
                }
                break;

            default:
                return false;  // Return false if the role is invalid
        }
        return false; // User not found
    }

}
