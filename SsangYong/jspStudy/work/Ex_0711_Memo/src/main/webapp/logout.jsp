
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  session.removeAttribute("mvo");
  response.sendRedirect("index.jsp");
%>