package com.modal.complaintManagementSystem.service;

import java.io.IOException;
import java.util.List;

import com.modal.complaintManagementSystem.dto.ChangePasswordDto;
import com.modal.complaintManagementSystem.dto.DashboardDataDto;
import com.modal.complaintManagementSystem.dto.ProfileDto;
import com.modal.complaintManagementSystem.dto.UserDto;
import com.modal.complaintManagementSystem.exception.InvalidPasswordException;
import com.modal.complaintManagementSystem.exception.InvalideEmailException;
import com.modal.complaintManagementSystem.exception.PasswordMismatchException;
import com.modal.complaintManagementSystem.exception.UserNotFoundException;
import com.modal.complaintManagementSystem.response.UsersResponse;

public interface UserService {

	boolean existsByEmail(String email);

	boolean existsByContactNumber(long contactNumber);

	UserDto validateAndSaveUserDto(UserDto userDto);

	ProfileDto loginUser(String email, String password) throws InvalideEmailException, InvalidPasswordException;

	ProfileDto validateAndUpdateUserProfile(ProfileDto profileDto) throws IOException ,UserNotFoundException;

	ProfileDto getUserProfile(int userId);
	
	ProfileDto getUserDetailsByUserId(int userId);

	ProfileDto changeUserPassword(ChangePasswordDto changePasswordDto)
			throws PasswordMismatchException, InvalidPasswordException, UserNotFoundException;

	List<ProfileDto> getAllUsers();
	
	UsersResponse getAllUsers(int page, int size, String query);
	
	DashboardDataDto dashboardDataOfUser(int userId);

}
