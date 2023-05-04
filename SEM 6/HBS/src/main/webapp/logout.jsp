<%@ page language="java" pageEncoding="UTF-8"%>
<%
	response.setHeader("Pragma","no-cache");
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Expires","0");
	response.setDateHeader("Expires",-1);
	
	Cookie cookie = new Cookie("enrollment","");
		response.addCookie(cookie);
		
		cookie = new Cookie("Name","");
		response.addCookie(cookie);
		
	session=request.getSession();  
	session.removeAttribute("enrollmentNo");
	session.invalidate();
    response.sendRedirect("form/login.jsp");
%>