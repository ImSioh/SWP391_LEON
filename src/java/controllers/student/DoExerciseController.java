package controllers.student;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import dao.DoTestDAO;
import dao.QuestionDAO;
import dao.StudentAnswerDAO;
import dao.TestDAO;
import dto.Account;
import dto.DoTest;
import dto.Question;
import dto.StudentAnswer;
import dto.Test;
import helpers.UUIDDeserializer;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.lang.reflect.Type;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.text.StringEscapeUtils;

@WebServlet(name = "DoExerciseController", urlPatterns = {"/student/class/exercise/do"})
public class DoExerciseController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {

            Account account = (Account) req.getAttribute("account");
            TestDAO tdao = new TestDAO();
            String testid = req.getParameter("testid");
            String code = req.getParameter("code");
            Test test = tdao.getTestWithAllData(UUID.fromString(testid));
            Gson gson = new Gson();
            String json = gson.toJson(test);
            json = StringEscapeUtils.escapeEcmaScript(json);
            int status;
            Timestamp now = new Timestamp(System.currentTimeMillis());

            //check xem den gio hay da qua han lam bai chua
            if (test == null || now.before(test.getStartAt()) || (test.getEndAt() != null && now.after(test.getEndAt()))) {
                resp.sendRedirect(req.getContextPath() + "/student/class/exercise?code=" + code);
            } else {
                DoTest dotest = new DoTestDAO().getDoTestById(account.getAccountId(), UUID.fromString(testid));
                if (dotest == null) {
                    dotest = new DoTest(UUID.fromString(testid), account.getAccountId(), new Timestamp(System.currentTimeMillis()), null, null);
                    status = new DoTestDAO().insertDoTest(dotest);
                }
                // xem dã hoàn thành bài tap chua
                if (dotest.getFinishTime() != null) {
                    //neu lam roi
                    resp.sendRedirect(req.getContextPath() + "/student/exercise/view-detail-test?Tid=" + testid + "&Sid=" + account.getAccountId());
                } else {
                    //neu chua nop
                    Timestamp endTime;
                    Timestamp startTime = dotest.getStartTime();
                    if (test.getDuration() != null) {
                        long durationTime = test.getDuration() * 60 * 1000;
                        endTime = new Timestamp(startTime.getTime() + durationTime);
                    } else {
                        endTime = test.getEndAt();
                    }

                    //tu dong update end time khi het gio neu khong bam nop bai
                    if (endTime.before(now)) {
                        dotest.setFinishTime(endTime);
                        status = new DoTestDAO().updateDoTest(dotest);
                    }

                    req.setAttribute("endTime", endTime.getTime());
                }
                req.setAttribute("test", test);
                req.setAttribute("json", json);
                req.setAttribute("code", code);

                req.getRequestDispatcher("/student/do-test.jsp").forward(req, resp);
            }

        } catch (Exception ex) {
            Logger.getLogger(DoExerciseController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            Account account = (Account) req.getAttribute("account");
            String testid = req.getParameter("testid");
            Timestamp now = new Timestamp(System.currentTimeMillis());

            String json = getBodyString(req);
            Gson gson = new GsonBuilder()
                    .registerTypeAdapter(UUID.class, new UUIDDeserializer())
                    .create();
            Type listType = new TypeToken<ArrayList<StudentAnswer>>() {
            }.getType();

            ArrayList<StudentAnswer> listStudentAnswer = gson.fromJson(json, listType);

            DoTest dotest = new DoTestDAO().getDoTestById(account.getAccountId(), UUID.fromString(testid));
            int status1 = new StudentAnswerDAO().insertStudentAnswer(listStudentAnswer);

            ArrayList<Question> listWrongQuestion = new QuestionDAO().getWrongQuestionFromStudentAnswer(UUID.fromString(testid), listStudentAnswer);

            double totalQuestion = new QuestionDAO().getQuestionByTestID(UUID.fromString(testid)).size();
            double wrongAnswer = listWrongQuestion.size();
            double score = (totalQuestion - wrongAnswer) / totalQuestion * 10;

            System.out.println("total question: " + totalQuestion);
            System.out.println("wrong answer: " + wrongAnswer);
            System.out.println("score: " + score);

            dotest.setFinishTime(now);
            dotest.setScore(Math.round(score * 100.0) / 100.0);
            int status2 = new DoTestDAO().updateDoTest(dotest);

        } catch (Exception ex) {
            throw new ServletException(ex);
        }

    }

    private String getBodyString(HttpServletRequest req) throws IOException {
        ArrayList<String> lines = new ArrayList<>();
        InputStream inputStream = req.getInputStream();
        Scanner scanner = new Scanner(inputStream, "UTF-8");
        while (scanner.hasNextLine()) {
            lines.add(scanner.nextLine());
        }
        return String.join("\n", lines);
    }

}
