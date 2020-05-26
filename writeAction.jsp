<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty property="bbsTitle" name="bbs"/>
<jsp:setProperty property="bbsContent" name="bbs"/>

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
		if(userID == null){
			PrintWriter outter = response.getWriter();
			outter.println("<script> alert('Please log in'); location.href = 'login.jsp'; </script>");
		} else {
	 		if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
	 		 			PrintWriter script = response.getWriter();
	 		 			script.println("<script>alert('Please fill in the form'); history.back();</script>");

	 				} 
	 		 		else {
	 					BbsDAO bbsDAO = new BbsDAO();
	 					int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
	 					if (result == -1) {
	 						PrintWriter script = response.getWriter();
	 						script.println("<script>alert('Failed'); history.back();</script>");
	 					}
	 					else {
	 						PrintWriter script = response.getWriter();
	 						script.println("<script> location.href='bbs.jsp';</script>");
	 			 		}
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