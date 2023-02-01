package com.HBS;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;


public class HBSMailer {

	public static boolean sendMail(String recepient, String MailSubject, String MailBody) { 
		System.out.println("Preparing to send email");
		Properties properties = System.getProperties();
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.ssl.enable", "true");
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "587");
        
		String myAccountEmail = "dormzz.otp@gmail.com";
		String password = "hyoyxmlozsowsffd";
		System.out.println("Properties set successfully");
		
		Session session = Session.getInstance(properties, new Authenticator() {
            @Override 
			protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(myAccountEmail, password);
            }
        }); 
		System.out.println("Session Prepared successfully");
		if(prepareEmail(session, myAccountEmail, recepient, MailSubject, MailBody))
			return true;
		else
			return false; 	
	}
	
	public static boolean prepareEmail(Session session, String myAccountEmail, String recepient, String MailSubject, String MailBody)
	{
		try{ 
			Message message = new MimeMessage(session); 
			message.setFrom(new InternetAddress(myAccountEmail));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(recepient));
			message.setSubject(MailSubject); 
			message.setText(MailBody);
			System.out.println("Message Prepared successfully");			
			Transport.send(message);
			System.out.println("Message sent successfully");
			return true;
		} catch (Exception ex) {
			System.out.println("Error in Prepareing Message.");
			return false; 
		}
		
	}
}