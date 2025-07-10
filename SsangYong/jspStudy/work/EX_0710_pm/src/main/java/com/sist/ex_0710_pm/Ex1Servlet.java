package com.sist.ex_0710_pm;

import mybatis.dao.EmpDAO;
import mybatis.vo.EmpVO;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/Ex1")
public class Ex1Servlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //응답시 한글처리
        response.setContentType("text/html;charset=utf-8");

        EmpVO[] list = EmpDAO.getAll();//static이라 직접호출 가능
        //한번에 쓰기 위해 스트링버퍼로
        StringBuffer sb= new StringBuffer("<ol>");
        for(EmpVO vo:list){
            sb.append("<li>");
            sb.append(vo.getEmpno());
            sb.append(",");
            sb.append(vo.getEname());
            sb.append(",");
            sb.append(vo.getJob());
            sb.append(",");
            sb.append(vo.getDeptno());
            sb.append("</li>");
        }
        sb.append("</ol>");

        //응답을 위한 스트림 생성
        PrintWriter out=response.getWriter();
        out.println("<h2>전체사원목록</h2>");
        out.println("<hr/>");
        out.println(sb.toString());
        out.close();

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
