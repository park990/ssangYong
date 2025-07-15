<%@ page import="java.time.LocalDate" %><%--
  Created by IntelliJ IDEA.
  User: 쌍용교육센터
  Date: 2025-07-15
  Time: 오전 9:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
  LocalDate now = LocalDate.now();
%>
  <jsp:forward page="ex1_1.jsp">
    <jsp:param name="now" value="<%=now.toString()%>"/>
  </jsp:forward>
</body>
</html>
