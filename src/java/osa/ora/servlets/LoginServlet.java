/**
 * =================================================
 * Copyright (c) 2019 : Osama Oransa
 * =================================================
 * This class is responsible for user's login.
 */
package osa.ora.servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import osa.ora.beans.Services;
import osa.ora.beans.User;
import osa.ora.utils.InvokeRest;
import com.google.gson.Gson;
import osa.ora.beans.Customer;
/**
 * LoginServlet
 * @author ooransa
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/Login"})
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private Services services=Services.getInstance();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String loginName = request.getParameter("username");
        String password = request.getParameter("password");
        if (loginName == null || password == null) {
            response.sendRedirect("error.jsp");
            return;
        }
        User user = new User(1,loginName,password,"");
        String output=InvokeRest.invokePost(new Gson().toJson(user)
                , services.getUserAccountService());
        
        System.out.println("User output:"+output);
        if (output == null) {
            request.getSession().setAttribute("LOGIN_FAILED", "TRUE");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            user=new Gson().fromJson(output, User.class);
            output=InvokeRest.invokeGet(services.getCustomerDataService()+user.getEmail());
            System.out.println("Customer data output:"+output);
            Customer customer=new Gson().fromJson(output, Customer.class);
            request.getSession().setAttribute("USER", user);
            request.getSession().setAttribute("CUSTOMER", customer);
            //audit trail need to be added here
            request.getRequestDispatcher("main.jsp").forward(request, response);
        }
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
