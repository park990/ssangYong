import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/MyServlet4")
public class MyServlet4 extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //한글처리
        request.setCharacterEncoding("utf-8");

        String ids = request.getParameter("id");
        String names = request.getParameter("name");
        String[] phones = request.getParameterValues("phone");
        String[] hobbys = request.getParameterValues("chk");

        //응답을 위한 한글
        response.setContentType("text/html; charset=utf-8");// text인데 html형식

        PrintWriter ot = response.getWriter();
        ot.println("ID: " + ids + "<br/>");
        ot.println("이름: " + names + "<br/>");

        for (int i = 0; i < phones.length; i++) {
            ot.println(phones[i]);
            if(i<phones.length-1) //i가 2보다 작으면 "-"를 출력한다.
                ot.println("-");
        }
        ot.println("<br/>");

        if(hobbys!=null) {
            for (int i = 0; i < hobbys.length; i++) {
                ot.println(hobbys[i]);
                if (i < hobbys.length - 1) //i가 2보다 작으면 ","를 출력한다.
                    ot.println(","); // 마지막에는 쉼표
            }
        }
        ot.close();
    }
}
