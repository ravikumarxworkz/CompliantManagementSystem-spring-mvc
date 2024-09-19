package com.modal.complaintManagementSystem.utils;

import lombok.Data;
import java.security.SecureRandom;
import org.springframework.stereotype.Component;

@Data
@Component
public class GeneratePassword {

    private static final String CHAR_LOWER = "abcdefghijklmnopqrstuvwxyz";
    private static final String CHAR_UPPER = CHAR_LOWER.toUpperCase();
    private static final String DIGITS = "0123456789";
    private static final String SPECIAL_CHARS = "!@#$%&*()_+-=[]|,./?><";

    private static final String PASSWORD_CHARS = CHAR_LOWER + CHAR_UPPER + DIGITS + SPECIAL_CHARS;
    private static SecureRandom random = new SecureRandom();
    private static final int length = 8;

    public String generatePassword() {
        StringBuilder sb = new StringBuilder(length);
        for (int i = 0; i < length; i++) {
            int randomIndex = random.nextInt(PASSWORD_CHARS.length());
            sb.append(PASSWORD_CHARS.charAt(randomIndex));
        }
        return sb.toString();
    }
}
