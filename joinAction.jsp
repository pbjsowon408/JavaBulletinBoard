<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>

<%@ page import="java.io.PrintWriter" %>

<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty property="userID" name="user"/>
<jsp:setProperty property="userName" name="user"/>
<jsp:setProperty property="userGender" name="user"/>
<jsp:setProperty property="userEmail" name="user"/>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP Bulletin Board Website</title>
</head>
<body>


 	


<%
	String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID != null){
			PrintWriter outter = response.getWriter();
			outter.println("<script> alert('logged In Already'); location.href = 'main.jsp'; </script>");
		}
 		if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null 
		|| user.getUserGender() == null || user.getUserEmail() == null) {
 			PrintWriter script = response.getWriter();
 			script.println("<script>alert('Please fill in the form'); history.back();</script>");

		} 
 		else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>alert('ID Exists'); history.back();</script>");
			}
			else {
				session.setAttribute("userID", user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script> location.href='main.jsp';</script>");
	 		}
		}
	
	%>
	
	 	<%--
	--------------------------------------
	 	<script type="text/javascript">
 	
 	if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null 
			|| user.getUserGender() == null || user.getUserEmail() == null) {
			alert('Please fill in the form');
			history.back();

		}
		else {
	 		<%
	 		UserDAO userDAO = new UserDAO();
	 		int result = userDAO.join(user);
	 		%>
  		var result = <%=result%>;
 		 if(result == -1){
	  		 alert('ID Exists');
	  		 history.back();
  			}
 		 else{
   			location.href = 'main.jsp';
  			}
		}
</script>
 	--%>

</body>
</html>