<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.io.*,java.util.*,javax.mail.*"%>
<%@ page import = "javax.mail.internet.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ page import = "com.HBS.*" %>

<%
int otp = (int)(Math.random() * ((999999 - 100000) + 1)) + 100000;
String email = "20bscit001@gmail.com";
String MailSubject = "Dormzz : Sign In Verification";
String MailBody = "Your OTP to Login is :" + otp + "<br><br>Thank You.<br>Team Dormzz";
String result="";
out.println(email);
out.println(MailSubject);
out.println(MailBody);
try{
	
result="Success, Mail Sent";
} catch (Exception e){
	result="Error, Mail Not Sent";
}
%>

<html>
   <head>
      <title>Send Email using JSP</title>
   </head>
   
   <body>
         <h1>Send Email using JSP</h1>
      
      <p align = "center">
         <% 
            out.println("Result: " + result + "\n");
         %>
      </p>
   </body>
</html>