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
        <title>Acme Internet Banking Home Page</title>
        <link rel="stylesheet" href="css/w3.css">
        <link rel='stylesheet' href='css/style.css'>
    </head>
    <body>
        <div class="navbar">
            <a class="active" href="index.jsp"><i class="fa fa-fw"></i><img style="width: 25px; height: 25px;" src="images/home.png"> Home Page</a>
            <a href="openAPI.jsp"><i class="fa fa-fw"></i><img style="width: 25px; height: 25px;" src="images/group.png"> Open APIs</a>
            <a href="contact.jsp"><i class="fa fa-fw"></i><img style="width: 25px; height: 25px;" src="images/notification.png"> Contact Us</a>
<% if(session.getAttribute("USER")==null) { %>            
            <a href="login.jsp"><i class="fa fa-fw"></i><img style="width: 25px; height: 25px;" src="images/members.png"> Members Login</a>
<% } else { %>
            <a href="main.jsp"><i class="fa fa-fw"></i><img style="width: 25px; height: 25px;" src="images/menu.png"> Main Menu</a>
            <a href="LogoutServlet"><i class="fa fa-fw"></i><img style="width: 25px; height: 25px;" src="images/members.png"> Logout</a>
<% } %>
        </div> 
        &nbsp;&nbsp;<h3>&nbsp;Welcome <%=userName%></h3>
        <br>
        <form method="post" action="Login">
            <table>
                <tr><td>&nbsp;Acme bank provides modern internet banking services which enable you to use the internet services any where in the world.</td></tr>
                <tr><td></td><td></td></tr>
<% if(session.getAttribute("USER")==null) { %>            
            <tr><td colspan=2>&nbsp;Login from <a href="login.jsp">Here</a></td></tr>
<% } else { %>
            <tr><td colspan=2>&nbsp;Go To Main Menu from <a href="main.jsp">Here</a></td></tr>
<% } %>            
            </table>
        </form>
        <%@include file="footer.jsp" %>
    </body>
</html>