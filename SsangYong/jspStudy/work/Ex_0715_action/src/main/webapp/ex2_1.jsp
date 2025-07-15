<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    request.setCharacterEncoding("utf-8");
    LocalDate now = LocalDate.now();
    int cYear = now.getYear();
    String b_year = request.getParameter("b_year");
    int byear = Integer.parseInt(b_year);
    int age = cYear - byear+1;
%>
<jsp:forward page="ex2.jsp">
    <jsp:param name="age" value="<%=age%>"/>
</jsp:forward>