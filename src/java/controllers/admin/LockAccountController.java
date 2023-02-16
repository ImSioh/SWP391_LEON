/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers.admin;

import dao.AccountDAO;
import dto.Account;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.UUID;

/**
 *
 * @author Asus
 */
@WebServlet(name = "LockAccountServlet", urlPatterns = {"/admin/lock"})
public class LockAccountController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LockAccountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LockAccountServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        try {
//            Account account = (Account) request.getAttribute("account");
            AccountDAO accountDAO = new AccountDAO();

            int check = 0;
            boolean status = Boolean.valueOf(request.getParameter("status"));
            //student
            if (request.getServletPath().contains("student-account-list")) {
                String id = request.getParameter("sid");
                Account account = accountDAO.getAccountById(UUID.fromString(id));

                check = accountDAO.lockAccount(account, status, id);
                if (check > 0) {
                    request.getRequestDispatcher("/admin/manageS.jsp").forward(request, response);
                }
            } //teacher
            else if (request.getServletPath().contains("teacher-account-list")) {
                String id = request.getParameter("tid");
                Account account = accountDAO.getAccountById(UUID.fromString(id));

                check = accountDAO.lockAccount(account, status, id);
                if (check > 0) {
                    request.getRequestDispatcher("/admin/manageS.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
        }

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
