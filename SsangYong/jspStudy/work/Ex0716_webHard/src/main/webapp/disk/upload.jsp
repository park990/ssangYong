<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--enctype이 multipart.form데이터로(첨부파일) 전달한다면 request.getparamater로 받지 못한다.
해결은 꼭 multipartRequest를 통해 받아야 한다. but 라이브러리가 필요하다.--%>



    <%
        /*multipartformdata로 지정돼서 전달됐다면 절대로 request로 파라미터 못받음 그래서 session에
        * 경로(현재위치)를 저장해서 담아 보냄*/
        String dir= (String)session.getAttribute("dir");

        //파일을 저장할 위치값을 절대경로로 준비하자.
        String realpath=application.getRealPath("/members/"+dir);

        MultipartRequest mr =new MultipartRequest(request,realpath,1024*1024*5,
                new DefaultFileRenamePolicy());
        //여기까지만 해도 전달되는 첨부파일이 realpath경로에 저장된다.

        //이제 폼에있는 자원들을 받을 수 있다
        File f=mr.getFile("upload");
        //파일의 이름이 변경될 수 있으므로 원래 이름을 알아낼 수 있다.
        String ori_name=mr.getOriginalFileName("upload");

        //파일의 현재이름
        String f_name=f.getName();

//        response.sendRedirect("myDisk.jsp?cPath="+dir);

    %>
<html>
<head>
    <title>Title</title>
</head>
<body onload="movePage()">

<form action="myDisk.jsp" method="post">
    <input type="hidden" name="cPath" value="<%=dir%>"/>
    <script>
        function movePage(){
            document.forms[0].submit();
        }
    </script>
</form>
</body>
</html>
