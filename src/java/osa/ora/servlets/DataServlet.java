/**
 * =================================================
 * Copyright (c) 2019 : Osama Oransa
 * =================================================
 * This class is used for some ajax interaction to 
 */
package osa.ora.servlets;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import osa.ora.beans.Services;
import osa.ora.beans.TransferRequest;
import osa.ora.beans.User;
import osa.ora.utils.InvokeRest;

/**
 * DataServlet
 * @author ooransa
 */
@WebServlet(name = "DataServlet", urlPatterns = {"/DataServlet"})
public class DataServlet extends HttpServlet {
    private Services services=Services.getInstance();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getSession().getAttribute("USER") == null) {
            response.sendRedirect("error.jsp");
        } else {
            User user = (User) request.getSession().getAttribute("USER");
            String action = request.getParameter("action");
            String output = "";
            if (action != null) {
                int actionVal = Integer.parseInt(action);
                switch (actionVal) {
                    case 1:
                        //call loan service
                        String loanAmount = request.getParameter("amount");
                        String monthlyIncome = request.getParameter("monthlyIncome");
                        output=InvokeRest.invokeGet(services.getLoanServiceService()+"?loanAmount="+loanAmount+
                                "&creditValue="+monthlyIncome);
                        if(output==null){
                            output="-1";
                        }
                        break;
                    case 2:
                        //call exchange rate service
                        String exchAmount = request.getParameter("amount");
                        String from = request.getParameter("from");
                        String to = request.getParameter("to");
                        output=InvokeRest.invokeGet(services.getExchangeRateService()+from+"/"+to);
                        try{
                            double rate=Double.parseDouble(output);
                            double amount=Double.parseDouble(exchAmount);
                            double total= rate*amount;
                            output=""+total+" "+to;
                        }catch(Throwable t){
                            t.printStackTrace();
                            output="Exchange Rate Not Available";
                        }
                        break;
                    case 3:
                        //call banking service
                        String account_no = request.getParameter("account_no");
                        output=InvokeRest.invokeGet(services.getBankingService()+account_no);
                        if(output==null){
                            output="-1";
                        }
                        break;
                    case 4:
                        //call banking service to do transfer
                        String transferFrom = request.getParameter("from");
                        String transferTo = request.getParameter("to");
                        String amount = request.getParameter("amount");
                        String notes = request.getParameter("notes");
                        TransferRequest transferRequest=new TransferRequest();
                        transferRequest.setFromAccount(transferFrom);
                        transferRequest.setToAccount(transferTo);
                        double transferAmount=0;
                        try{
                            transferAmount=Double.parseDouble(amount);
                        }catch(Throwable t){
                            //should return error to the user
                            System.out.println("Error: transfer amount is not valid, will reset to 0.0");
                        }
                        transferRequest.setAmount(transferAmount);
                        transferRequest.setNote(notes);
                        if(transferAmount>0){
                            output=InvokeRest.invokePost(new Gson().toJson(transferRequest),services.getBankingService());
                        }else{
                            output=null;
                        }
                        if(output==null){
                            output="{\"result\":\"Transfer Failed, enter correct amount!\"}";
                        }
                        break;
                    default:
                        break;
                }
            }else{
                output = "Error!";
            }
            response.setContentType("application/json;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.println(output);
            }
        }
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
