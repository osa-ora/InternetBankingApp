<%@page import="osa.ora.beans.Services"%>
<%@page import="osa.ora.beans.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
Services services=Services.getInstance();
String userName="Guest";
if(session.getAttribute("USER")!=null) {
    User user = (User) session.getAttribute("USER");
    userName=user.getEmail();
}
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Acme Internet Banking - Contact us</title>
        <link rel="stylesheet" href="css/w3.css">
        <link rel='stylesheet' href='css/style.css'>
    </head>
    <body>
        <div class="navbar">
            <a href="index.jsp"><i class="fa fa-fw"></i><img style="width: 25px; height: 25px;" src="images/home.png"> Home Page</a>
            <a class="active" href="openAPI.jsp"><i class="fa fa-fw"></i><img style="width: 25px; height: 25px;" src="images/group.png"> Open APIs</a>
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
            <table>
                <tr><td>Here You can find all our public API Documentation<br> Sample documentation from the Source: https://www.ibanfirst.com/open-api/</td></tr>
                        <tr><td>
                                <img src="images/document-1.png"/><br>
                                <img src="images/document-2.png"/><br>
                                <img src="images/document-3.png"/><br>
                    </td><td></td></tr>
                    <tr><td>User Account Service
                    <%=services.getUserAccountService()%></td></tr>
                    <tr><td>Customer Data Service
                    <%=services.getCustomerDataService()%></td></tr>
                    <tr><td>Banking Service
                    <%=services.getBankingService()%></td>
                    </tr><tr><td>Loan Service
                    <%=services.getLoanServiceService()%></td>
                    </tr><tr><td>Exchange Rate Service
                    <%=services.getExchangeRateService()%></td></tr>                    
            </table>
        <!-- documentation -->
        
        
        <!-- end of documentation -->
        <%@include file="footer.jsp" %>
    </body>
</html>