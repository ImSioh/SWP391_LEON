package controllers.teacher;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import dao.AnswerDAO;
import dao.ClassObjectDAO;
import dao.QuestionDAO;
import dao.TestDAO;
import dto.Account;
import dto.Answer;
import dto.ClassObject;
import dto.Question;
import dto.Test;
import helpers.TimestampDeserializer;
import helpers.UUIDDeserializer;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.UUID;

@WebServlet(name = "CreateExerciseController", urlPatterns = {"/teacher/class/exercise/create"})
public class CreateExerciseController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Account account = (Account) req.getAttribute("account");
            ClassObject classObject = new ClassObjectDAO().getClassByCode(req.getParameter("code"));
            System.out.println(classObject);
            System.out.println(account);
            if (classObject == null || !account.getAccountId().equals(classObject.getAccountId())) {
                resp.sendRedirect(req.getContextPath() + "/teacher/class");
                return;
            }
            req.setAttribute("classObject", classObject);
            req.getRequestDispatcher("/teacher/create-exercise.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String json = getBodyString(req);
            Gson gson = new GsonBuilder()
                    .registerTypeAdapter(Timestamp.class, new TimestampDeserializer())
                    .registerTypeAdapter(UUID.class, new UUIDDeserializer())
                    .create();
            Test test = gson.fromJson(json, Test.class);
            ClassObject classObject = new ClassObjectDAO().getClassById(test.getClassId());
            test.setTestId(UUID.randomUUID());
            test.setCreateTime(new Timestamp(System.currentTimeMillis()));
            if (test.getStartAt() == null) {
                test.setStartAt(test.getCreateTime());
            }
            ArrayList<Answer> allAnswers = new ArrayList<>();
            
            for (Question question : test.questions) {
                allAnswers.addAll(question.answers);
                question.setQuestionId(UUID.randomUUID());
                question.setTestId(test.getTestId());
                
                for (Answer answer : question.answers) {
                    answer.setAnswerId(UUID.randomUUID());
                    answer.setQuestionId(question.getQuestionId());
                }
            }
            
            int result = new TestDAO().insertTest(test);
            if (result > 0) {
                result = new QuestionDAO().insertMultipleQuestions(test.questions);
            }
            if (result > 0) {
                result = new AnswerDAO().insertMultipleAnswers(allAnswers);
            }
            if (result > 0) {
                resp.sendRedirect(req.getContextPath() + "/teacher/class/exercise?code=" + classObject.getCode());
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private String getBodyString(HttpServletRequest req) throws IOException {
        ArrayList<String> lines = new ArrayList<>();
        InputStream inputStream = req.getInputStream();
        Scanner scanner = new Scanner(inputStream);
        while (scanner.hasNextLine()) {
            lines.add(scanner.nextLine());
        }
        return String.join("\n", lines);
    }

}
