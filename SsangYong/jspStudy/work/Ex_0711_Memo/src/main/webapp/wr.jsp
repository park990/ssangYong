<%@ page import="mybatis.dao.memoDAO" %><%--
  Created by IntelliJ IDEA.
  User: 쌍용교육센터
  Date: 2025-07-11
  Time: 오후 5:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
  //요청시 한글처리는 되어있지 않음
  request.setCharacterEncoding("utf-8");

  //파라미터값 받기
  String writer =request.getParameter("writer");
  String content =request.getParameter("content");


  int cnt= memoDAO.addMemo(writer,content);
%>

<script>
  <%
  if(cnt>0){
  %>
  alert("저장완료");
  <%
  }else{
  %> alert("실패");
  <%
  }%>
</script>
</body>
</html>
