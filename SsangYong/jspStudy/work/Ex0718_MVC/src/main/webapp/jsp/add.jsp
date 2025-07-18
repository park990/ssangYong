<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
</head>
<style>
  .table{
    width:600px;
    border-collapse: collapse;

  }
  .noborder{
    border: none !important;
  }
  .table th, .table td{
    border: 1px solid #000;
    padding: 5px;
  }
  .table caption{
    text-indent: -9999px;
    height: 0px;
  }
  .txt_R{
    text-align: right;

  }
</style>
<body>
<div id="wrap">
  <header><h1>사원 목록</h1></header>
  <article>
    <form action="Controller" method="post">
      <input type="hidden" name="type" value="add"/><%--***************타입 전달************--%>
    <table class="table">
      <caption>사원 추가 테이블</caption>
      <tbody>
      <tr>
        <td>사번:</td>
        <td><input type="text" id="empno" name="empno"/></td>
      </tr>
      <tr>
        <td>이름:</td>
        <td><input type="text" id="ename" name="ename"/></td>
      </tr>
      <tr>
        <td>직종:</td>
        <td><input type="text" id="job" name="job"/></td>
      </tr>
      <tr>
        <td colspan="2">
          <button type="button" id="send_btn" onclick="send(this.form)">보내기</button>
        </td>
      </tr>
      </tbody>
    </table>
    </form>
  </article>
</div>
<script>
  function send(frm){
    frm.submit();
  }
</script>
</body>
</html>
