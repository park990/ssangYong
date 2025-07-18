<%@ page import="mybatis.vo.empVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  Object obj = request.getAttribute("ar");
  if (obj != null) {
    empVO[] ar = (empVO[]) obj;
    for (empVO vo : ar) {
%>
<tr>
  <td><%=vo.getEmpno()%>
  </td>
  <td><%=vo.getEname()%>
  </td>
  <td><%=vo.getJob()%>
  </td>
  <td><%=vo.getSal()%>
  </td>
  <td><%=vo.getHiredate()%>
  </td>
  <td><%=vo.getDeptno()%>
  </td>
</tr>
<%
    }
  }
%>