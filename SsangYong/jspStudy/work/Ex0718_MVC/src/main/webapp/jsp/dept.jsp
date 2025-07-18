<%@ page import="mybatis.vo.empVO" %>
<%@ page import="mybatis.vo.deptVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
</head>
<style>
  .table {
    width: 600px;
    border-collapse: collapse;
    text-align: center;
  }

  .noborder {
    border: none !important;
  }

  .table th, .table td {
    border: 1px solid #000;
    padding: 5px;
  }

  .table caption {
    text-indent: -9999px;
    height: 0px;
  }

  .txt_R {
    text-align: right;

  }
</style>
<body>
<div id="wrap">
  <header><h1>부서 목록</h1></header>
  <article>
    <table class="table">
      <caption>부서 목록 테이블</caption>
      <thead>
      <tr>
        <td colspan="6" class="txt_R noborder">
          <button type="button" id="total_btn" onclick="location.href='Controller?type=total'">전체</button>
          <button type="button" id="search_btn">검색</button>
          <button type="button" id="add_btn" onclick="javascript:location.href='Controller?type=add'">추가
          </button>
        </td>
      </tr>
      <tr>
        <th>사번</th>
        <th>부서</th>
        <th>지역코드</th>
        <th>도시명</th>

      </tr>
      </thead>
      <tbody>
      <%
        Object obj = request.getAttribute("ar");
        if (obj != null) {
          deptVO[] ar = (deptVO[]) obj;
          for (deptVO vo : ar) {
      %>
      <tr>
        <td><%=vo.getDeptno()%></td>
        <td><%=vo.getDname()%></td>
        <td><%=vo.getLoc_code()%></td>
        <td><%=vo.getCity()%></td>
      </tr>
      <%
        }
      }else{
      %>
      <Tr>
        <td colspan="6">현재 등록된 정보 없습니다.</td>
      </Tr>
      <%
        }

      %>
      </tbody>
    </table>
  </article>
</div>
</body>
</html>
