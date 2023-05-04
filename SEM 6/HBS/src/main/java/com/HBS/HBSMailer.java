package com.HBS;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;


public class HBSMailer {

	protected static final String host="smtp.gmail.com";  
	protected static final String FromEmailID="dormzz.otp@gmail.com";//change accordingly  
	protected static final String password="lkssmhpczqjfajus";//change accordingly  
	protected static final String port = "587";
	protected static String to="dormzz.otp@gmail.com";//change accordingly  
	protected static String Subject = "Test";
	protected static String Body = "This is simple program of sending email using JavaMail API.";
	
	
	public static boolean sendMail(String recepient, String MailSubject, String MailBody) { 
			
			
			//Get the session object  
			Properties props = new Properties();  
			props.setProperty("mail.smtp.host",host);  
			props.setProperty("mail.smtp.port", port);
			props.setProperty("mail.smtp.user", FromEmailID);
			props.setProperty("mail.smtp.auth", "true");  
			props.setProperty("mail.smtp.starttls.enable", "true");
			
		    try {
		    	Session oSession; 
				oSession = Session.getInstance(props,new javax.mail.Authenticator() {  
				     protected PasswordAuthentication getPasswordAuthentication() {  
							  return new PasswordAuthentication(FromEmailID,password);  
				     }  
				   });  
			  
				//Compose the message  
			    to = recepient;
			    Subject = MailSubject;
			    Body = MailBody;
			    
		    	MimeMessage message = new MimeMessage(oSession);  
		    	message.setFrom(new InternetAddress(FromEmailID));  
		    	message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));  
		    	message.setSubject(Subject);  
		    	message.setText(Body);
		       
		    	//send the message  
		    	Transport.send(message);  
		  
		    	System.out.println("message sent successfully...");  
		    	return true;
		    } catch (MessagingException e) {
		    	 System.out.println(e.toString());
		    	return false; 
		    }  
	}
	
	public static boolean sendMailAnvi(String recepient, String MailSubject, String MailBody) { 
		
		//Get the session object  
		Properties props = new Properties();  
		props.setProperty("mail.smtp.host",host);  
		props.setProperty("mail.smtp.port", port);
		props.setProperty("mail.smtp.user", "regbusutu@gmail.com");
		props.setProperty("mail.smtp.auth", "true");  
		props.setProperty("mail.smtp.starttls.enable", "true");
		
	    try {
	    	Session oSession; 
			oSession = Session.getInstance(props,new javax.mail.Authenticator() {  
			     protected PasswordAuthentication getPasswordAuthentication() {  
						  return new PasswordAuthentication("regbusutu@gmail.com","whpmtpuitrcojckd");  
			     }  
			   });  
		  
			//Compose the message  
		    to = recepient;
		    Subject = MailSubject;
		    Body = MailBody;
		    
	    	MimeMessage message = new MimeMessage(oSession);  
	    	message.setFrom(new InternetAddress("regbusutu@gmail.com"));  
	    	message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));  
	    	message.setSubject(Subject);  
	    	message.setText(Body);
	       
	    	//send the message  
	    	Transport.send(message);  
	  
	    	System.out.println("message sent successfully...");  
	    	return true;
	    } catch (MessagingException e) {
	    	 System.out.println(e.toString());
	    	return false; 
	    }  
}
	
	
}