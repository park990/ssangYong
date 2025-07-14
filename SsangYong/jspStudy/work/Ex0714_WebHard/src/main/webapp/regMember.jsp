<%@ page import="mybatis.vo.memberVO" %>
<%@ page import="mybatis.dao.memberDAO" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!
    //배열을 인자로 받아서 하나의 문자열로 변환하는 함수
    public String makeString(String[] ar, String delim) {
        StringBuffer sb = new StringBuffer();
        int i = 0;
        for (String str : ar) {
            sb.append(str);
            //구분자는 배열 마지막에는 추가하지 않아야 한다.
            if (i < ar.length - 1)
                sb.append(delim);
            i++;
        }
        return sb.toString();
    }
%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    //요청시 한글처리
    request.setCharacterEncoding("utf-8");

    //전달해오는 파라미터들 받기
    String id = request.getParameter("u_id");
    String pw = request.getParameter("u_pw");
    String name = request.getParameter("u_name");
    String[] phone = request.getParameterValues("u_phone");
    String Aphone=makeString(phone,"-");

    memberVO mvo = new memberVO();
    mvo.setMem_id(id);
    mvo.setMem_pw(pw);
    mvo.setMem_name(name);
    mvo.setMem_phone(Aphone);

    int cnt= memberDAO.registry(mvo);
    if (cnt > 0) {
    String path=application.getRealPath("/members/"+mvo.getMem_id());
//    out.println(path);
        File f = new File(path);
        if(!f.exists())
            f.mkdirs();
        response.sendRedirect("index.jsp");
    }
%>
</body>
</html>
