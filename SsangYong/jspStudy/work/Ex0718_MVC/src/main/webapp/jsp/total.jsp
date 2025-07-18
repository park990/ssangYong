<%@ page import="mybatis.vo.empVO" %>
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
    <header><h1>사원 목록</h1></header>
    <article>
        <table class="table">
            <caption>사원 테이블</caption>
            <thead>
            <tr>
                <td colspan="6" class="txt_R noborder">
                    <button type="button" id="search_btn">검색</button>
                    <button type="button" id="add_btn" onclick="javascript:location.href='Controller?type=add'">추가
                    <button type="button" id="dept_btn" onclick="javascript:location.href='Controller?type=dept'">부서목록</button>
                    </button>
                </td>
            </tr>
            <tr>
                <th>사번</th>
                <th>이름</th>
                <th>직종</th>
                <th>급여</th>
                <th>입사일</th>
                <th>부서코드</th>
            </tr>
            </thead>
            <tbody>
            <%
                Object obj = request.getAttribute("ar");
                if (obj != null) {
                    empVO[] ar = (empVO[]) obj;
                    for (empVO vo : ar) {
            %>
            <tr>
                <td><%=vo.getEmpno()%></td>
                <td><%=vo.getEname()%></td>
                <td><%=vo.getJob()%></td>
                <td><%=vo.getSal()%></td>
                <td><%=vo.getHiredate()%></td>
                <td><%=vo.getDeptno()%></td>
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
