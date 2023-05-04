package com.HBS;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class HBSRegEx {
	
	private static final Pattern VALID_EMAIL_ADDRESS_REGEX = Pattern.compile("^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$", Pattern.CASE_INSENSITIVE);
	private static final Pattern VALID_PHONE_NUMBER_REGEX = Pattern.compile("^\\d{10}$");
	
	public static boolean validatePhoneNumber(String phoneNumber) {
		Matcher matcher = VALID_PHONE_NUMBER_REGEX.matcher(phoneNumber);
	    return matcher.find();
	}
		  
	public static boolean validateEmail(String email) {
		Matcher matcher = VALID_EMAIL_ADDRESS_REGEX.matcher(email);
		return matcher.find();
	} 
}
