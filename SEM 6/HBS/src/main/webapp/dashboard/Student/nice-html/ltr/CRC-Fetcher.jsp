<%@include file="../../../../DBConnection.jsp" %>

<%

PreparedStatement stmt = null;
ResultSet rs = null;


String type = request.getParameter("RecType");

stmt = con.prepareStatement("SELECT * FROM tblcomplain_type WHERE ReC_Type = ?");
stmt.setString(1, type);

rs = stmt.executeQuery();
%>

<option value="" disabled selected>Select SubType</option>
<%
while (rs.next()) {
%>
<option value="<%= rs.getInt("Cmp_Type_id") %>"><%= rs.getString("Cmp_Type") %></option>
<%
}
%>