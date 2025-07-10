package com.sist.ex_0710_pm;

import mybatis.dao.EmpDAO;
import mybatis.vo.EmpVO;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/Ex2")
public class Ex2Servlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        String empno =request.getParameter("empno_tx");
        EmpVO vo = EmpDAO.getemp(empno);

        //한번에 쓰기 위해 스트링버퍼로
        StringBuffer sb= new StringBuffer("<ol>");
        if(vo!=null) {
            sb.append("<li>");
            sb.append(vo.getEmpno());
            sb.append(",");
            sb.append(vo.getEname());
            sb.append(",");
            sb.append(vo.getJob());
            sb.append(",");
            sb.append(vo.getDeptno());
            sb.append("</li>");

            sb.append("</ol>");
        }
        //응답을 위한 스트림 생성
        PrintWriter out = response.getWriter();
        out.println("<h2>사원목록</h2>");
        out.println("<hr/>");
        out.println(sb.toString());
        out.close();

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
