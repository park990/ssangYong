
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <style>
        table{
            width: 600px;
            border-collapse: collapse;
        }
        table th, table td{
            border: 1px solid #000;
            padding: 5px;
        }
        table caption{
            text-indent: -9999px;
            height: 0;
        }
    </style>
</head>
<body>
<header>
    <h1>회원목록</h1>
</header>
<article>
    <table>
        <caption>행사목록테이블</caption>
        <thead>
        <tr>
            <th>번호</th>
            <th>이미지</th>
            <th>제목</th>
            <th>전화번호</th>
            <th>주소</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="vo" items="${requestScope.ar}" varStatus="vs">
            <tr>
                <td>${vs.index+1}</td>
                <td><img src="${vo.firstimage2}"/></td>
                <td>${vo.title}</td><%-- vo.getName() --%>
                <td>${vo.tel}</td>
                <td>${vo.addr1} &nbsp; ${vo.addr2}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</article>
</body>
</html>
