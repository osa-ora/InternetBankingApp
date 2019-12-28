<%@page import="osa.ora.beans.Accounts"%>
<%@page import="osa.ora.beans.Customer"%>
<%@page import="osa.ora.beans.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
String userName="Guest";
User user=null;
Customer customer=null;
if(session.getAttribute("USER")!=null) {
    user = (User) session.getAttribute("USER");
    userName = user.getEmail();
}
if(session.getAttribute("CUSTOMER")!=null) {
    customer = (Customer)session.getAttribute("CUSTOMER");
}
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Acme Internet Banking - Main Menu</title>
        <link rel="stylesheet" href="css/w3.css">
        <link rel='stylesheet' href='css/style.css'>
        <link rel='stylesheet' href='css/style2.css'>
        <script src="js/ajax_check_loan.js"></script>  
        <script src="js/ajax_get_exchange.js"></script>  
        <script src="js/ajax_view_details.js"></script>  
        <script src="js/ajax_transfer.js"></script>  
    </head>
    <body>
        <div class="navbar">
            <a href="index.jsp"><i class="fa fa-fw"></i><img style="width: 25px; height: 25px;" src="images/home.png"> Home Page</a>
            <a href="openAPI.jsp"><i class="fa fa-fw"></i><img style="width: 25px; height: 25px;" src="images/group.png"> Open APIs</a>
            <a href="contact.jsp"><i class="fa fa-fw"></i><img style="width: 25px; height: 25px;" src="images/notification.png"> Contact Us</a>
<% if(session.getAttribute("USER")==null) { %>            
            <a href="login.jsp"><i class="fa fa-fw"></i><img style="width: 25px; height: 25px;" src="images/members.png"> Members Login</a>
<% } else { %>
            <a class="active" href="main.jsp"><i class="fa fa-fw"></i><img style="width: 25px; height: 25px;" src="images/menu.png"> Main Menu</a>
            <a href="LogoutServlet"><i class="fa fa-fw"></i><img style="width: 25px; height: 25px;" src="images/members.png"> Logout</a>
<% } %>
        </div> 
        &nbsp;&nbsp;<h2>&nbsp;Welcome <%=userName%></h2>
        <center>
        <form method="post" action="Login">
            <table style="vertical-align: top;">
                <tr>
                    <td></td>
                    <td>
                        <table border="1" style="border-color: red;">
                            <tr><td colspan="2"><b>Customer Basic Details</b></td></tr>
                            <% if(customer!=null){ %>
                            <tr><td>Name:</td><td><%=customer.getFirstName()+" "+customer.getLastName()%></td></tr>
                            <tr><td>Email:</td><td><%=customer.getEmail()%></td></tr>
                            <tr><td>Address:</td><td><%=customer.getCity()%></td></tr>
                            <tr><td>Birth date:</td><td><%=customer.getBirthday()%></td></tr>
                            <tr><td>On Payroll:</td><td><%=customer.getState()%></td></tr>
                            <% } else { %>
                                <td colspan="3">Service currently not available</td>                            
                            <% } %>
                        </table>
                        <br>
                        <table border="1" style="border-color: red;">
                            <tr><td colspan="4"><b>Request Loan</b></td></tr>
                            <td>Loan Amount <input type="text" id="loanAmount" name="loanAmount" size="10" maxlength="10" value=""/><td>
                            <td>Monthly Income <input type="text" id="monthlyIncome" name="monthlyIncome" size="10" maxlength="10" value=""/></td>
                            <td><a class="w3-btn w3-ripple w3-green" href='javascript:checkLoan();'>Check</a></td>
                            </tr>
                            <tr><td colspan="4"><div id="loanResult" name="loanResult"></div></td></tr>
                        </table>
                    </td>
                    <td>
                        <table border="1" style="border-color: red;">
                            <tr><td colspan="3"><b>Customer Bank Accounts</b></td></tr>
                            <tr><th>Account Number</th><th>Account Type</th><th>Action</th></tr>
                            <% if(customer!=null){
                                for(Accounts account:customer.getCustomerAccounts()){%>
                                <tr>
                                    <td>Account Number: <%=account.getAccountNumber()%></td>
                                    <td>Account Type: <%=account.getAccountType()%></td>
                                    <td><a class="w3-btn w3-ripple w3-green" href='javascript:viewDetails("<%=account.getAccountNumber()%>")'>View Details</a></td>
                                </tr>
                            <% }}else { %>
                                <tr>
                                    <td colspan="3">Service currently not available</td>
                                </tr>
                            <% } %>
                        </table> 
                        <br>
                        <table border="1" style="border-color: red;">
                           <tr><td colspan="5">International Transfers</td></tr>
                                <tr>
                                    <% if(customer!=null){ %>
                                    <td>From Account:
                                        <select id="fromAccount" name="fromAccount"/>
                                         <% for(Accounts account:customer.getCustomerAccounts()){%>
                                                <option value="<%=account.getAccountNumber()%>"><%=account.getAccountNumber()%></option>
                                          <% } %>
                                        </select>
                                    </td>
                                    <td>To Account <input type="text" name="toAccount" id="toAccount" size="20" maxlength="20" value=""/>
                                    </td>
                                    <td>Amount <input type="text" name="transferAmount" id="transferAmount" size="20" maxlength="20" value=""/>
                                    </td>
                                    <td>Transfer Notes <input type="text" name="notes" id="notes" size="20" maxlength="20" value=""/>
                                    </td>
                                    <td><a class="w3-btn w3-ripple w3-red" href='javascript:doTransfer()'>Transfer Now</a></td>
                                    <% } else { %>
                                    <td colspan="4">Service currently not available</td>                            
                                    <% } %>
                                </tr>
                                <tr><td colspan="5"><div id="transferResult" name="transferResult"></div></td></tr>
                        </table> 
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="5">
                        <table border="1" style="border-color: red;">
                            <tr>
                                <tr><th>Account Number</th><th>Account Balance</th><th>Currency</th></tr>                                
                            </tr>
                            <tr id="account_details" name="account_details">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        <div id="transaction_details">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="5">
                        <table border="1" style="border-color: red;">
                           <tr><td colspan="5">Exchange Rate</td></tr>
                                <tr>
                                    <td>From Currency
                                        <select name="exchangeFrom" id="exchangeFrom"/>
                                            <option value="USD">USD</option>
                                            <option value="GBP">GBP</option>
                                            <option value="EGP">EGP</option>
                                            <option value="EUR">EUR</option>
                                        </select>
                                    </td>
                                    <td>To Currency 
                                        <select name="exchangeTo" id="exchangeTo"/>
                                            <option value="USD">USD</option>
                                            <option value="GBP">GBP</option>
                                            <option value="EGP">EGP</option>
                                            <option value="EUR">EUR</option>
                                        </select>
                                    </td>
                                    <td>Amount <input type="text" name="exchangeAmount" id="exchangeAmount" size="10" maxlength="10" value=""/>
                                    </td>
                                    <td>Total <div id="exchangeResult" name="exchangeResult"></div></td>
                                    <td><a class="w3-btn w3-ripple w3-blue" href='javascript:checkExchange()'>Calculate</a></td>
                                </tr>
                        </table> 
                    </td>
                </tr>
            </table>
        </form>
        </center>
        <%@include file="footer.jsp" %>
    </body>
</html>