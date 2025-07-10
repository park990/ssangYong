package com.sist.ex_0710_pm;

import mybatis.dao.EmpDAO;
import mybatis.vo.MemVO;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/Ex5")
public class Ex5_Servlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String mid=request.getParameter("id_tx");
        String mpw=request.getParameter("pw_tx");

        MemVO mvo = EmpDAO.login(mid,mpw);

        if(mvo !=null){
            HttpSession session= request.getSession();
            session.setAttribute("mvo",mvo);

            //페이지 이동
            response.sendRedirect("/ex1_emp.html");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
     doGet(request, response);
    }
}
