package com.modal.complaintManagementSystem.service.impl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.modal.complaintManagementSystem.dto.ChangePasswordDto;
import com.modal.complaintManagementSystem.dto.DashboardDataDto;
import com.modal.complaintManagementSystem.dto.ProfileDto;
import com.modal.complaintManagementSystem.dto.UserDto;
import com.modal.complaintManagementSystem.entity.Complaint;
import com.modal.complaintManagementSystem.entity.UserEntity;
import com.modal.complaintManagementSystem.exception.InvalidPasswordException;
import com.modal.complaintManagementSystem.exception.InvalideEmailException;
import com.modal.complaintManagementSystem.exception.PasswordMismatchException;
import com.modal.complaintManagementSystem.exception.ResourceNotFoundException;
import com.modal.complaintManagementSystem.exception.UserNotFoundException;
import com.modal.complaintManagementSystem.mailSending.MailSending;
import com.modal.complaintManagementSystem.repository.ComplaintRepository;
import com.modal.complaintManagementSystem.repository.UserRepository;
import com.modal.complaintManagementSystem.response.UsersResponse;
import com.modal.complaintManagementSystem.service.UserService;
import com.modal.complaintManagementSystem.utils.GeneratePassword;


@Service
@Transactional
public class UserServiceImpl implements UserService {

	@Autowired
	private UserRepository userRepository;

	@Autowired
	private MailSending mailSending;

	@Autowired
	private GeneratePassword generatePassword;

	@Autowired
	private ComplaintRepository complaintRepository;

	@Override
	public boolean existsByEmail(String email) {

		return this.userRepository.existsByEmail(email);
	}

	@Override
	public boolean existsByContactNumber(long contactNumber) {
		return this.userRepository.existsByContactNumber(contactNumber);
	}

	@Override
	public UserDto validateAndSaveUserDto(UserDto userDto) {
		UserEntity entity = new UserEntity();
		userDto.setPassword(generatePassword.generatePassword());
		userDto.setImagePath("user-default.png");
		userDto.setCreatedAt(LocalDateTime.now());
		BeanUtils.copyProperties(userDto, entity);
		UserEntity saveResult = this.userRepository.save(entity);

		if (saveResult != null) {
			boolean sendResult = mailSending.sendEmailRegisterSuccessfully(userDto); // sending method
			if (sendResult) {
				return userDto;
			}
		}

		return null;
	}

	@Override
	public ProfileDto loginUser(String email, String password) throws InvalideEmailException, InvalidPasswordException {
		if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
			throw new InvalideEmailException("Email Id and Password must not be empty");
		}

		UserEntity userEntity = this.userRepository.findByEmail(email);

		if (userEntity == null) {
			throw new InvalideEmailException("Email Id does not exist");
		}

		if (!userEntity.getPassword().equals(password)) {
			throw new InvalidPasswordException("Password is incorrect");
		}
		ProfileDto profileDto = new ProfileDto();
		BeanUtils.copyProperties(userEntity, profileDto);
		profileDto.setUpdatedAt(userEntity.getUpdatedAt());
		return profileDto;
	}

	@Override
	public DashboardDataDto dashboardDataOfUser(int userId) {
		UserEntity userEntity = this.userRepository.getById(userId);
		List<Complaint> complaints = this.complaintRepository.findByUser(userEntity);

		// Initialize counters for the different complaint statuses
		int totalComplaints = complaints.size();
		int newComplaints = (int) complaints.stream().filter(c -> c.getStatus().equalsIgnoreCase("Registered")).count();
		int pendingComplaints = (int) complaints.stream().filter(c -> c.getStatus().equalsIgnoreCase("Pending"))
				.count();
		int inProgressComplaints = (int) complaints.stream().filter(c -> c.getStatus().equalsIgnoreCase("In Progress"))
				.count();
		int closedComplaints = (int) complaints.stream().filter(c -> c.getStatus().equalsIgnoreCase("Closed")).count();

		// Create a DTO to hold the dashboard data
		DashboardDataDto dashboardDataDto = new DashboardDataDto();
		dashboardDataDto.setTotalComplaints(totalComplaints);
		dashboardDataDto.setNewComplaints(newComplaints);
		dashboardDataDto.setPendingComplaints(pendingComplaints);
		dashboardDataDto.setClosedComplaints(closedComplaints);
		dashboardDataDto.setInProgressComplaints(inProgressComplaints);

		return dashboardDataDto;
	}

	@Override
	public ProfileDto getUserProfile(int userId) {
		UserEntity userEntity = userRepository.findById(userId)
				.orElseThrow(() -> new ResourceNotFoundException("User not found"+userId));

		ProfileDto profileDto = new ProfileDto();

		BeanUtils.copyProperties(userEntity, profileDto);
		int complaintsCount = this.complaintRepository.countByUser(userEntity);
		profileDto.setComplaintsCount(complaintsCount);

		return profileDto;
	}

	@Override
	public ProfileDto validateAndUpdateUserProfile(ProfileDto profileDto) throws IOException, UserNotFoundException {
		// Save the image and get the file path
		String imagePath = saveImages(profileDto);

		UserEntity existingUser = userRepository.findByEmail(profileDto.getEmail());

		if (existingUser != null) {
			if (profileDto.getFirstName() != null) {
				existingUser.setFirstName(profileDto.getFirstName());
			}
			if (profileDto.getLastName() != null) {
				existingUser.setLastName(profileDto.getLastName());
			}
			if (profileDto.getEmail() != null) {
				existingUser.setEmail(profileDto.getEmail());
			}
			if (profileDto.getContactNumber() != 0) {
				existingUser.setContactNumber(profileDto.getContactNumber());
			}
			if (profileDto.getAlterContactNumber() != 0) {
				existingUser.setAlterContactNumber(profileDto.getAlterContactNumber());
			}
			if (profileDto.getAddress() != null) {
				existingUser.setAddress(profileDto.getAddress());
			}
			if (profileDto.isAgreement()) {
				existingUser.setAgreement(profileDto.isAgreement());
			}
			// Update the image path if a new image was uploaded
			if (imagePath != null) {
				existingUser.setImagePath(imagePath);
				profileDto.setImagePath(imagePath); // Set the image path in the DTO as well
			}
			// Set the updatedAt timestamp
			profileDto.setUpdatedAt(LocalDateTime.now());
			existingUser.setUpdatedAt(profileDto.getUpdatedAt());

			// Save the updated user entity
			userRepository.save(existingUser);
		} else {
			// Handle the case where the user is not found, if necessary
			throw new UserNotFoundException("User with email " + profileDto.getEmail() + " not found.");
		}

		return profileDto;
	}

	private String saveImages(ProfileDto profileDto) throws IOException {
		if (profileDto.getImageFile() != null && !profileDto.getImageFile().isEmpty()) {
			// Define the directory where images will be saved
			String directoryPath = "D:\\complaintSystemMangement\\";
			// Use employeeId to create a unique file name
			String fileName = "User_" + profileDto.getUserId() + "_" + profileDto.getImageFile().getOriginalFilename();
			String filePath = directoryPath + fileName;

			// Create the file path
			File newFile = new File(filePath);
			Path path = Paths.get(newFile.getAbsolutePath());

			// Write the image file to the directory
			byte[] fileBytes = profileDto.getImageFile().getBytes();
			Files.write(path, fileBytes);

			// Return the relative path to store in the database
			return fileName;
		}
		return null; // Return null if no image is provided
	}

	@Override
	public ProfileDto changeUserPassword(ChangePasswordDto changePasswordDto)
			throws PasswordMismatchException, InvalidPasswordException, UserNotFoundException {

		Optional<UserEntity> optionalUser = userRepository.findById(changePasswordDto.getUserId());
		if (!optionalUser.isPresent()) {
			throw new UserNotFoundException("User not found with ID: " + changePasswordDto.getUserId());
		}

		UserEntity existingUser = optionalUser.get();

		// Validate old password
		if (!existingUser.getPassword().equals(changePasswordDto.getOldPassword())) {
			// Handle incorrect old password
			throw new InvalidPasswordException("The old password is incorrect.");
		}

		// Validate new password and confirm password
		if (!changePasswordDto.getNewPassword().equals(changePasswordDto.getConfirmPassword())) {
			// Handle new password and confirm password mismatch
			throw new PasswordMismatchException("New password and confirm password do not match.");
		}

		// Update user password
		existingUser.setPassword(changePasswordDto.getNewPassword());
		userRepository.save(existingUser);
		ProfileDto profileDto = new ProfileDto();
		BeanUtils.copyProperties(existingUser, profileDto);

		return profileDto; // Assuming a method to convert UserEntity to ProfileDto
	}

	@Override
	public List<ProfileDto> getAllUsers() {
		List<UserEntity> userEntity = this.userRepository.findAll();
		return userEntity.stream().map(users -> {
			ProfileDto profileDto = new ProfileDto();
			int complaintsCount = this.complaintRepository.countByUser(users);
			BeanUtils.copyProperties(users, profileDto);
			profileDto.setComplaintsCount(complaintsCount);
			return profileDto;
		}).collect(Collectors.toList());
	}

	@Override
	public ProfileDto getUserDetailsByUserId(int userId) {
	    // Fetch the user entity by ID
	    UserEntity userEntity = userRepository.findById(userId)
	            .orElseThrow(() -> new ResourceNotFoundException("User not found with ID: " + userId));

	    // Map the user entity to ProfileDto
	    ProfileDto profileDto = new ProfileDto();
	    profileDto.setFirstName(userEntity.getFirstName());
	    profileDto.setContactNumber(userEntity.getContactNumber());
	    profileDto.setEmail(userEntity.getEmail());
	    profileDto.setUserId(userEntity.getUserId());
	    profileDto.setAddress(userEntity.getAddress());

	    return profileDto;
	}


	public UsersResponse getAllUsers(int page, int size, String query) {
		Pageable pageable = PageRequest.of(page - 1, size);
		Page<UserEntity> usersPage;

		if (query.isEmpty()) {
			usersPage = userRepository.findAll(pageable);
		} else {
			usersPage = userRepository.findByEmailContainingIgnoreCase(query, pageable);
		}

		List<ProfileDto> users = usersPage.getContent().stream().map(this::convertToDto).collect(Collectors.toList());

		int totalPages = usersPage.getTotalPages();

		return new UsersResponse(users, totalPages);
	}

	private ProfileDto convertToDto(UserEntity user) {
		ProfileDto dto = new ProfileDto();
		dto.setUserId(user.getUserId());
		dto.setFirstName(user.getFirstName());
		dto.setLastName(user.getLastName());
		dto.setEmail(user.getEmail());
		dto.setContactNumber(user.getContactNumber());

		int complaintsCount = this.complaintRepository.countByUser(user);
		dto.setComplaintsCount(complaintsCount);
		return dto;
	}

}
