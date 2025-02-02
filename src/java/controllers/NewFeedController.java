package controllers;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import dao.AccountDAO;
import dao.ClassObjectDAO;
import dao.CommentDAO;
import dao.EnrollmentDAO;
import dao.PostDAO;
import dao.ResourceDAO;
import dto.Account;
import dto.ClassObject;
import dto.Post;
import helpers.Constant;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.UUID;

@WebServlet(name = "NewFeedController", urlPatterns = {"/teacher/class/newfeed", "/student/class/newfeed"})
public class NewFeedController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Account account = (Account) req.getAttribute("account");
            String classCode = req.getParameter("code");
            if (classCode == null) {
                resp.sendRedirect(req.getContextPath() + (account.getRole() == 1 ? "/teacher" : "/student") + "/class");
                return;
            }
            if (classCode.isEmpty()) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Class with code " + classCode + " is not exist");
                return;
            }

            ClassObject classObject = new ClassObjectDAO().getClassByCode(classCode);
            if (classObject == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Class with code " + classCode + " is not exist");
                return;
            }

            if (account.getRole() == 2 && !new EnrollmentDAO().isJoined(account.getAccountId(), classObject.getClassId())) {
                resp.sendRedirect(req.getContextPath() + "/student/class");
                return;
            }

            if (account.getRole() == 1 && !account.getAccountId().equals(classObject.getAccountId())) {
                resp.sendRedirect(req.getContextPath() + "/teacher/class");
                return;
            }

            ArrayList<Post> posts = new PostDAO().getPostsInClass(classObject.getClassId());
            HashMap<UUID, Account> otherAccount = new HashMap<>();
            ResourceDAO resourceDAO = new ResourceDAO();
            AccountDAO accountDAO = new AccountDAO();
            CommentDAO commentDAO = new CommentDAO();
            for (Post post : posts) {
                String content = post.getContent();
                content = new String(Base64.getEncoder().encode(content.getBytes()));
                post.setContent(content);
                post.resources = resourceDAO.getResourcesByPost(post.getPostId());
                Account postOwner = otherAccount.get(post.getAccountId());
                if (postOwner == null) {
                    postOwner = accountDAO.getAccountById(post.getAccountId());
                    otherAccount.put(postOwner.getAccountId(), postOwner);
                }
                post.account = postOwner;
                post.commentCount = commentDAO.countCommentInPost(post.getPostId());
            }

            Gson gson = new GsonBuilder().excludeFieldsWithoutExposeAnnotation().setDateFormat(Constant.FORMAT_DATETIME).create();
            String postArr = gson.toJson(posts);

            req.setAttribute("postObject", postArr);
            req.setAttribute("classObject", classObject);
            req.setAttribute("activeNF", "active");
            if (account.getRole() == 1) {
                req.setAttribute("teacher", account);
            } else {
                req.setAttribute("teacher", accountDAO.getAccountById(classObject.getAccountId()));
            }
            req.getRequestDispatcher("/newfeed.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }

}
