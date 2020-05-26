<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>

<%@ page import="java.io.PrintWriter" %>

<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty property="userID" name="user"/>
<jsp:setProperty property="userPassword" name="user"/>

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
		
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());

		if (result == 1){
			session.setAttribute("userID", user.getUserID());
			PrintWriter outter = response.getWriter();
			outter.println("<script> alert('Log-in Success'); location.href = 'main.jsp'; </script>");
		}
		else if (result == 0) {
			PrintWriter outter = response.getWriter();
			outter.println("<script> alert('Password Error'); history.back(); </script>");
		}
		else if (result == -1) {
			PrintWriter outter = response.getWriter();
			outter.println("<script> alert('ID doesn't exist'); history.back(); </script>");
		}
		else if (result == -2) {
			PrintWriter outter = response.getWriter();
			outter.println("<script> alert('Database Error'); history.back(); </script>");
		}
		
	%>
	
	 	<%--
<%
  UserDAO userDAO = new UserDAO();
  int result = userDAO.login(user.getUserID(), user.getUserPassword());
 %>
 <script type="text/javascript">
  var result = <%=result%>;
  if(result == 1){
	   alert('Log-in Success');
   location.href = 'main.jsp';
  }else if(result == 0){
   alert('Password Error');
   history.back();
  }else if(result == -1){
   alert('ID do not exist');
   history.back();
  }else if(result == -2){
   alert('Database Error');
   history.back();
  }
 </script>
 --%>
</body>
</html>
