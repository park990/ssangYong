<%--
  Created by IntelliJ IDEA.
  User: 쌍용교육센터
  Date: 2025-07-11
  Time: 오후 2:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<article>
    <header><h2>사원추가</h2></header>

    <div>
        <form action="ex6_add.jsp" method="post" name="f">
            <label for="empno_tx">사번:</label>
            <input type="text" id="empno_tx" name="empno"/><br/>
            <label for="ename_tx">이름:</label>
            <input type="text" id="ename_tx" name="ename"/><br/>
            <label for="empno_tx">직종:</label>
            <input type="text" id="job_tx" name="job"/><br/>
            <label for="hdate_tx">입사일:</label>
            <input type="text" id="hdate_tx" name="hdate"/><br/>
            <button type="button" onclick="exe()">보내기</button>
        </form>
    </div>
</article>
<script>
    function exe() {
        let no = document.getElementById("empno_tx")
        if (no.value.trim().length == 0) {
            alert("사번입력하셍요")
            no.value="";
            no.focus();
            return;
        }
    document.f.submit()}
</script>
</body>
</html>
