package ex3;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;


@WebServlet("/Controller3")
public class Controller3 extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        String viewPath = null;
        Action action = null;

        if (type != null) {
            switch (type) {
                case "emp":
                    action = new EmpAction();
                    break;

                case "dept":
                    action = new deptAction();
                    break;

                case "memo":
                    action = new MemoAction();
                    break;

                default:
            }
        }
/*        if (type == null || type.equalsIgnoreCase("emp")) {
            action = new EmpAction();


        } else if (type != null && type.equalsIgnoreCase("dept")) {
            action = new deptAction();

        }
*/
        viewPath = action.execute(request, response);

        //forward를 하자
        RequestDispatcher disp = request.getRequestDispatcher(viewPath);
        disp.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
