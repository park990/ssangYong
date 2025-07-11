
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%! int cnt=10; %>
<html>
<head>
    <title>Title</title>
</head>
<body>
  <H1> 스크립트 요소: 스크립트릿 연습</H1>
  <p> 스크립트 릿은 자바의 제어문과 연산식 등을 기술한다.</p>
  <ul>
  <% for (int i=0;i<cnt;i++){ %>
    <li><%=(i+1)%></li>
    <% } %>
  </ul>
</body>
</html>
