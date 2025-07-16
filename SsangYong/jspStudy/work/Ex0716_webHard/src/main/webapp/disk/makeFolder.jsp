<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  request.setCharacterEncoding("utf-8");
  String cPath=request.getParameter("cPage");
  String f_name=request.getParameter("f_name");

  String realpath=application.getRealPath("/members/"+cPath+"/"+f_name);

  //절대경로를 가지고 File객체 생성
  File f= new File(realpath);
  if (!f.exists()){
    f.mkdirs();
    response.sendRedirect("myDisk.jsp?cPath="+cPath);
  }else{ //폴더가 이미 존재할 경우.
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
  <button type="button" onclick="goBack()">돌아가기</button>
<script>
  alert("폴더가 이미 존재합니다")
  function goBack(){
    location.href="myDisk.jsp?cPath=<%=cPath%>";
  }
</script>
</body>
</html>
<%
  }
%>