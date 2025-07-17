<%@ page import="mybatis.vo.EmpVO" %>
<%@ page import="mybatis.vo.MemoVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
  <style>
    #table {
      width: 600px;
      border-collapse: collapse;
    }

    #table th, #table td {
      border: 1px solid black;
      padding: 5px;
    }

    #table caption {
      text-indent: -9999px;
    }
  </style>
</head>
<body>
<div id="wrap">
  <header><h2>메모목록</h2></header>
  <article>
    <table id="table">
      <caption>메모목록테이블</caption>

      <thead>
      <tr>
        <th>작성자</th>
        <th>내용</th>
        <th>등록일자</th>
        <th>IP</th>
      </tr>
      </thead>
      <tbody>
      <%
        //request에 emp라는 이름으로 저장된 객체를 가져온다.
        Object obj = request.getAttribute("emp");
        MemoVO[] ar = null;
        if (obj != null) {
          ar = (MemoVO[]) obj;

          for (MemoVO vo : ar) {
      %>
      <tr>
        <td><%=vo.getWriter()%>
        </td>
        <td><%=vo.getContent()%>
        </td>
        <td><%=vo.getReg_date()%>
        </td>
        <td><%=vo.getIp()%>
        </td>
      </tr>
      <% }
      }
      %>
      </tbody>
    </table>
  </article>
</div>
</body>
</html>
