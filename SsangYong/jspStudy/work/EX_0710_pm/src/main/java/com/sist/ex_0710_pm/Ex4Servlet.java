package com.sist.ex_0710_pm;

import mybatis.vo.MemVO;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/Ex4")
public class Ex4Servlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");

        //응답을 위한 스트림 준비
        PrintWriter out =response.getWriter();

        //로그인 여부를 확인 하자
        //로그인 체크를 하기위해 요청객체로 부터 세션정보를 알아낸다.
        HttpSession session=request.getSession();

        //로그인을 했는지 알아내기 위해 얻어낸 session으로부터 값을 하나 검색
        //이름이 "mvo"인 객체를 얻어낸다.
        Object obj=session.getAttribute("mvo");

        if(obj==null){
            //로그인이 안된경우
            response.sendRedirect("/ex1_emp.html");
        }else{
            //로그인이 된경우
            MemVO mvo= (MemVO) obj;
            out.println("<h2>"+mvo.getMem_name()+"님 환영합니다</h2>");
        }
        out.close();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
