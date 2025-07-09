import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet ("/MyServlet3")
public class MyServlet3 extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //요청시 한글처리
        request.setCharacterEncoding("utf-8");
        //파라미터들 받기// 파라미터 이름이 같은 것들은 배열로 받아야한다.
        String[] names=request.getParameterValues("m_name");

        //request.getParameter("name")
        //reques.getParameterValues("name")



        //응답을 위한 한글처리도 해야함
        response.setContentType("text/html; charset=utf-8");

        //응답을 위한 스트림 생성
        PrintWriter ot = response.getWriter();
        ot.println("<h2>받은값:</h2>");
        ot.println("<ul>");
        for(int i=0;i<names.length;i++){
            ot.println("<li>");
            ot.println("아아");
            ot.println(names[i]);
            ot.println("</li>");

        }
        ot.println("</ul>");
        ot.close();
    }
}
