<%--
  Created by IntelliJ IDEA.
  User: 쌍용교육센터
  Date: 2025-07-11
  Time: 오전 11:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
<article>
  <header><h2>폼 연습</h2></header>
  <div>
      <FORM action="ex3.jsp" method="post" name="ff">
          <label for="s_id">아이디</label>
          <input type="text" id="s_id" name="s_id"><br/>
          <label for="s_pw">비밀번호</label>
          <input type="text" id="s_pw" name="s_pw"><br/>
          <button type="button" onclick="exe()">로그인</button>
      </FORM>
  </div>
</article>

<script>
    function exe(){
        //유효성검사 생략
        document.ff.submit();
    }
</script>

</body>
</html>
