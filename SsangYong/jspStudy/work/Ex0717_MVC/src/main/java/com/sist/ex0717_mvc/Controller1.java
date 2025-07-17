package com.sist.ex0717_mvc;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/Controller1")
public class Controller1 extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // type이라는 파라미터를 받는다.
        String type = request.getParameter("type");

        String viewPath = null; //JSP경로를 저장할 변수

        //type이 null이거나 "greet"면 view1.jsp
        if (type == null || type.equalsIgnoreCase("greet")) {
            viewPath = "view1.jsp";
            request.setAttribute("v1", "Hello~~");

            //type이 not null이 greet가 아니면 view2.jsp
        } else if (type.equalsIgnoreCase("hi")) {
            viewPath = "view2.jsp";

            //요청객체에 특정 객체를 저장할 수 있다.
            request.setAttribute("v1", "안녕하세요");
        }
        //MVC패턴에서는 뷰페이지 이동을 반드시 forward를 시킨다.
        RequestDispatcher disp = request.getRequestDispatcher(viewPath);
        disp.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
