<%--
  Created by IntelliJ IDEA.
  User: 쌍용교육센터
  Date: 2025-07-11
  Time: 오전 11:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<article>
  <header><h2>문제</h2></header>
  <div>
  <form action="ex4.jsp" method="post" name="f">
    <label for="in_txt">숫자입력:</label>
    <input type="text" id="in_txt" name="in_txt"><br/>
    <button type="button" id="send_btn">보내기</button>
  </form>
  </div>
</article>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

<script>
  $("#send_btn").on("click",function (){
    let

    document.f.submit()
  })


</script>
</body>

</html>
