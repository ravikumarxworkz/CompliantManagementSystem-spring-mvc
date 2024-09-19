package com.modal.complaintManagementSystem.utils;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.security.GeneralSecurityException;
import java.util.Arrays;
import java.util.Collections;

import org.springframework.stereotype.Component;

import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.services.sheets.v4.Sheets;
import com.google.api.services.sheets.v4.SheetsScopes;
import com.google.api.services.sheets.v4.model.ValueRange;
import com.google.auth.http.HttpCredentialsAdapter;
import com.google.auth.oauth2.GoogleCredentials;
import com.modal.complaintManagementSystem.entity.ContactUs;

@Component
public class ExcelUtils {

    private static final String APPLICATION_NAME = "Complaint Management System";
    private static final String SPREADSHEET_ID = "Replace with your Google Sheet ID"; // 
    private static final String RANGE = " Sheet name and range"; //

    public static Sheets getSheetsService() throws IOException, GeneralSecurityException {
        // Load the service account key JSON file.
        InputStream in = ExcelUtils.class.getClassLoader().getResourceAsStream("");
        if (in == null) {
            throw new FileNotFoundException("Resource not found: ");
        }

        GoogleCredentials credentials = GoogleCredentials.fromStream(in)
                .createScoped(Collections.singleton(SheetsScopes.SPREADSHEETS));

        // Build the Sheets service.
        return new Sheets.Builder(GoogleNetHttpTransport.newTrustedTransport(), JacksonFactory.getDefaultInstance(), new HttpCredentialsAdapter(credentials))
                .setApplicationName(APPLICATION_NAME)
                .build();
    }

    public static void writeToExcel(ContactUs contactUs) throws IOException, GeneralSecurityException {
        Sheets sheetsService = getSheetsService();

        ValueRange appendBody = new ValueRange()
                .setValues(Arrays.asList(
                        Arrays.asList(
                                contactUs.getFirstName(),
                                contactUs.getLastName(),
                                contactUs.getEmail(),
                                contactUs.getContactNumber(),
                                contactUs.getMessage(),
                                contactUs.getCreatedAt().toString() // Ensure this is properly formatted
                        )
                ));

        sheetsService.spreadsheets().values()
                .append(SPREADSHEET_ID, RANGE, appendBody)
                .setValueInputOption("RAW")
                .execute();
    }
}
