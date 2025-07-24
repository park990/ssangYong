<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%-- JSTL로 변수 선언 --%>
<c:set var="res" value="10" scope="page"/>
<%-- int res=10; --%>

<c:forEach begin="1" end="${res}" varStatus="vs">
  <h3>${vs.index}</h3>
</c:forEach>
</body>
</html>
