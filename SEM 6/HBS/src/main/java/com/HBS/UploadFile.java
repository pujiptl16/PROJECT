package com.HBS;

import java.io.File;
import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@WebServlet("/upload")
@MultipartConfig
public class UploadFile extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


	    // Get the user ID from the session
	    HttpSession session = req.getSession();
	    
		
		if(session.getId() == null || session.getAttribute("username") == null){
			//session.setAttribute("username", username);
			resp.getWriter().println("<script>location.href='../../../../form/login.jsp'</script>");
		}else{
			// Get the uploaded file part
			Part filePart = req.getPart("ProfilePic");
			session.setAttribute("flag", 1);
		    if(filePart != null) {
			    String fileName = filePart.getSubmittedFileName();
			    String userId = (String) session.getAttribute("userid");
			    String name = "User_"+session.getAttribute("FirstName")+""+session.getAttribute("LastName")+"_"+session.getAttribute("username");
			    String userType = req.getParameter("userType");
			    
			    // Get the upload directory path
			    String uploadPath="", redirectURL="";
			    
			    
			    if(userType.equals("Admin"))
			    {
			    	uploadPath = "C:\\Users\\Parth\\eclipse-workspace\\HBS\\src\\main\\webapp\\dashboard\\Admin\\nice-html\\ltr\\Image";
			    	redirectURL = "dashboard/Admin/nice-html/ltr/pages-profile.jsp";
			    }else if(userType.equals("Student"))
			    {
			    	uploadPath = "C:\\Users\\Parth\\eclipse-workspace\\HBS\\src\\main\\webapp\\dashboard\\Student\\nice-html\\ltr\\Image";
			    	redirectURL = "dashboard/Student/nice-html/ltr/pages-profile.jsp";
				}else if(userType.equals("Staff"))
				{
			    	uploadPath = "C:\\Users\\Parth\\eclipse-workspace\\HBS\\src\\main\\webapp\\dashboard\\Staff\\nice-html\\ltr\\Image";
			    	redirectURL = "dashboard/Staff/nice-html/ltr/pages-profile.jsp";
				}
			    
			    // Generate a unique file name
			    String fileExtension = fileName.substring(fileName.lastIndexOf("."));
			    String newFileName =  name + fileExtension;
			    
			    // Get the file size in bytes
			    long fileSize = filePart.getSize();
			    
			    // Check if the file size is less than or equal to 5 MB
			    if (fileSize > 15 * 1024 * 1024) {
			    	session.setAttribute("message", "File size must be less than or equal to 15 MB.");
			    	resp.sendRedirect(redirectURL);
			    }
			    
			    // Check if the file type is either jpg or png
			    String fileType = filePart.getContentType();
			    if (!fileType.equals("image/jpeg") && !fileType.equals("image/png")) {
			    	session.setAttribute("message", "File type must be either jpg or png.");
			    	resp.sendRedirect(redirectURL);
			    }
			    
			    		
			    // Create the upload directory if it doesn't exist
			    File uploadDir = new File(uploadPath);
			    if (!uploadDir.exists()) {
			        uploadDir.mkdirs();
			    }
			    
			    // Write the uploaded file to the upload directory
			    filePart.write(uploadPath + File.separator + newFileName);
			    session.setAttribute("message", "Profile Pic Updated.");
			    
			    System.out.println(userId+"\n"+name+"\n"+userType+"\n"+uploadPath+"\n"+redirectURL+"\n"+newFileName);
			    
			    // Update the user profile image in the database
			    Connection conn = null;
			    PreparedStatement stmt = null;
			    
			    try {
		
					conn = DatabaseConnection.InitializeDatabase("dormzz");
		
					String sql = "UPDATE tblstudent SET Profile_img = ? WHERE user_id = ?";
				    stmt = conn.prepareStatement(sql);
				    stmt.setString(1, "./Image/"+newFileName);
				    stmt.setString(2, userId);
				    stmt.executeUpdate();
				    
				    // Update the user's session with the new profile picture
				    ResultSet rs = stmt.executeQuery("SELECT Profile_img FROM tblstudent WHERE user_id = " + userId);
				    if (rs.next()) {
				        session.setAttribute("ProfilePic", rs.getString("Profile_img"));
				    }
				    
				    resp.sendRedirect(redirectURL);
				     
		
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			    
		    }
		}
	    

	}

}