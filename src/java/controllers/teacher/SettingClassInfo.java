package controllers.teacher;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import dao.ClassObjectDAO;
import dto.Account;
import dto.ClassObject;
import helpers.FormValidator;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "SettingClassInfo", urlPatterns = {"/teacher/class/setting"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 15
)
public class SettingClassInfo extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath()+"/teacher/setting.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String classCode = req.getParameter("code");
        Part profilePicture = req.getPart("txtImg");
        boolean txtStudentApprove = (boolean) req.getAttribute("txtStudentApprove");
        boolean txtHideClass = (boolean) req.getAttribute("txtHideClass");
        String name = (String) req.getAttribute("txtName");
        // picture
        FormValidator formValidator = new FormValidator(req);
        boolean validForm = formValidator.isValid();
        if (profilePicture.getSize() > 5 * 1024 * 1024) {
            validForm = false;
        }
        Account account = (Account) req.getAttribute("account");
        String urlToDB = null;
        if (profilePicture.getSize() > 0) {
            String fileName = profilePicture.getSubmittedFileName();
            String fileExtension = fileName.substring(fileName.lastIndexOf("."));
            String urlImg = "/profile/" + account.getAccountId().toString() + fileExtension;
            profilePicture.write(System.getProperty("leon.updir") + urlImg);
            urlToDB = "/files" + urlImg;
            
        }
        try {
            ClassObject classobj = new ClassObjectDAO().getClassByCode(classCode);
            ClassObject clob = new ClassObject();
            clob.setClassPicture(urlToDB);
            clob.setAccountId(account.getAccountId());
            clob.setClassId(classobj.getClassId());
            if (txtStudentApprove == true) {
                clob.setEnrollApprove(true);
            } else {
                clob.setEnrollApprove(false);
            }
            
            if (txtHideClass == true) {
                clob.setHidden(true);
            } else {
                clob.setHidden(false);
            }
            if(!(name.trim().equals(" "))) {
                clob.setName(name);
            }
            int clo = new ClassObjectDAO().updateClass(clob);
            req.getRequestDispatcher("newfeed.jsp").forward(req, resp);
        } catch (Exception ex) {
            Logger.getLogger(SettingClassInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
        // checkbox 

    }

}
