<%@page import="osa.ora.beans.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String userName="Guest";
if(session.getAttribute("USER")!=null) {
    User user = (User) session.getAttribute("USER");
    userName=user.getEmail();
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Acme Internet Banking - Error Page</title>
        <link rel="stylesheet" href="css/w3.css">
        <link rel='stylesheet' href='css/style.css'>
</head>
<body>
        <div class="navbar">
            <a href="index.jsp"><i class="fa fa-fw"></i><img style="width: 25px; height: 25px;" src="images/home.png"> Home Page</a>
            <a href="openAPI.jsp"><i class="fa fa-fw"></i><img style="width: 25px; height: 25px;" src="images/group.png"> Open APIs</a>
            <a href="contact.jsp"><i class="fa fa-fw"></i><img style="width: 25px; height: 25px;" src="images/notification.png"> Contact Us</a>
<% if(session.getAttribute("USER")==null) { %>            
            <a href="login.jsp"><i class="fa fa-fw"></i><img style="width: 25px; height: 25px;" src="images/members.png"> Members Login</a>
<% } else { %>
            <a href="main.jsp"><i class="fa fa-fw"></i><img style="width: 25px; height: 25px;" src="images/menu.png"> Main Menu</a>
            <a href="LogoutServlet"><i class="fa fa-fw"></i><img style="width: 25px; height: 25px;" src="images/members.png"> Logout</a>
<% } %>
         </div> 
	<h1>&nbsp;Sorry, <%=userName%></h1>
	<br>&nbsp;You have encountered unexpected error due to missing privileges or session timeout.
        <% if(session.getAttribute("ERROR_MSG")!=null) { %>            
        <br><br>&nbsp;&nbsp;Error Message: <font color="red"><%=session.getAttribute("ERROR_MSG") %></font>
        <%  session.removeAttribute("ERROR_MSG");
           } %>
        <br><br>
        &nbsp;Check with the system administrator or contact our support team.
	<br><br>
<% if(session.getAttribute("USER")==null) { %>            
            <tr><td colspan=2>Login from <a href="login.jsp">Here</a></td></tr>
<% } else { %>
            <tr><td colspan=2>Go To Main Menu from <a href="main.jsp">Here</a></td></tr>
<% } %>            

    <%@include file="footer.jsp" %>
</body>
</html>