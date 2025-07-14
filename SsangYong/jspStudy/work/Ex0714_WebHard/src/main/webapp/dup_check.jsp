<%@ page import="mybatis.vo.memberVO" %>
<%@ page import="mybatis.dao.memberDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String id = request.getParameter("u_id");

    memberVO mvo = memberDAO.isdup(id);
    if (mvo != null) //아이디가 데이터베이스에 존재한다면
        response.sendRedirect("reg.jsp?m_id=" + id + "mode=1");
    else
        response.sendRedirect("reg.jsp?m_id=" + id + "mode=0");
%>
