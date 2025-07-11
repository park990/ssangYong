
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
  String id =request.getParameter("s_id");
  String pw =request.getParameter("s_pw");
%>
<h2>아이디: <%=id%></h2>
<h2>비밀번호: <%=pw%></h2>
</body>
</html>
