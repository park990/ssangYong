<%@ page import="mybatis.dao.memberDAO" %>
<%@ page import="mybatis.vo.memberVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--  사용자가 입력하여 현재 페이지로 전달하는 아이디와 비밀번호를
파라미터로 받는다--%>
<%

    String mid = request.getParameter("u_id");
    String mpw = request.getParameter("u_pw");
    if (mid != null && mpw != null) {
        memberVO mvo = memberDAO.login(mid, mpw);
        int mode = 0;
        if (mvo != null) {
            session.setAttribute("mvo", mvo);
            mode = 1;
        }
        response.sendRedirect("index.jsp?mode="+mode);
    }else
        response.sendRedirect("index.jsp");//id와 pw 가 없는 경우
%>