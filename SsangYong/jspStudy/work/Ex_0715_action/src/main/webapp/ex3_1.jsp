
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
  request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="pvo" class="test.vo.paramVO" scope="session"/>

<jsp:setProperty name="pvo" property="*"/> <%--ex3_form에서넘어오는 param 3개--%>
<h3><%=pvo.getS_name()%></h3>
<h3><%=pvo.getS_email()%></h3>
<h3><%=pvo.getS_age()%></h3>
<button type="button" on onclick="javascript:location.href='ex3_2.jsp'">다음페이지</button>
</body>
</html>
