<%--<%@ page import="java.sql.Date" %>--%>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%--<c:set var="now" value="<%=new Date(System.currentTimeMillis())%>"/>--%>
    <c:set var="now2" value="<%=new Date()%>"/>
    <h2>${now}</h2>
    <h2><fmt:formatDate value="${now2}" pattern="yyyy-MM-dd"/> </h2>
    <h2><fmt:formatDate value="${now2}" pattern="(a)hh:mm:ss"/> </h2>
    <h2><fmt:formatDate value="${now2}" pattern="HH:mm:ss"/> </h2>
    <hr/>
    <h2>------- 숫자형식 -----------</h2>
    <h2><fmt:formatNumber value="1200000000"/></h2>
    <h2><fmt:formatNumber value="1200000000" groupingUsed="false"/></h2>
    <h2><fmt:formatNumber value="00001200000000" pattern="#,###.00"/></h2>
    <h2><fmt:formatNumber value="0.195" type="percent" pattern="0.00%"/></h2>
    <h2><fmt:formatNumber value="10000000000" type="currency"
                          currencySymbol="$"/></h2>
</body>
</html>
