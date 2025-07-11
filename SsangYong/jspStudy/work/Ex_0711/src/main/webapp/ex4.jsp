<%--
  Created by IntelliJ IDEA.
  User: 쌍용교육센터
  Date: 2025-07-11
  Time: 오전 11:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
  String num =request.getParameter("in_txt");
  int n= Integer.parseInt(num);
%>
<% for(int i=1;i<10;i++) { %>
  <%= n+"*"+i+"="+(n*i)+"<br/>" %>
<% } %>

</body>
</html>
