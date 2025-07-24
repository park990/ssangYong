<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
  request.setCharacterEncoding("utf-8");
%>
  <h2>이름:${param.u_name}</h2>
  <h2>전화:${param.u_phone}</h2><%-- 여러개 중 하나만 받는다 --%>

  <%--  for(String str : ar) --%>
  <c:forEach items="${paramValues.u_phone}" var="str">
      <h3>${str}</h3>
  </c:forEach>

</body>
</html>
