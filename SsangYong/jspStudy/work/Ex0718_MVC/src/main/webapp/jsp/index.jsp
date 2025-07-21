<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css">
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

    #searchD {
        display: none;
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
                    <button type="button" id="all_btn">전체(비동기식)</button>
                    <button type="button" id="total_btn" onclick="javascript:location.href='Controller?type=total'">전체
                    </button>
                    <button type="button" id="search_btn">검색</button>
                    <button type="button" id="add_btn" onclick="javascript:location.href='Controller?type=add'">추가
                    </button>
                    <button type="button" id="dept_btn" onclick="javascript:location.href='Controller?type=dept'">부서목록
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
            <tbody></tbody>
        </table>
    </article>
</div>


<div id="searchD">
    <select id="searchType">
        <option value="0" name="searchType">사번</option>
        <option value="1" name="searchType">이름</option>
        <option value="2" name="searchType">직종</option>
        <option value="3" name="searchType">부서</option>
    </select>
    <input type="text" name="searchValue" id="searchValue"/>
    <button type="button" id="b">검색</button>
    <button type="button" id="b2">검색(json)</button>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script>

    $(function () {
        $("#all_btn").click(function () {
            $.ajax({
                url: "Controller",
                type: "post",
                data: {type: "all"}
                // 응답되는 all.jsp에서 반복수행 된 tr들

            }).done(function (res) {
                $("table.table>tbody").html(res)
            })

        });
        $("#search_btn").click(function () {

            $("#searchD").dialog({title: "검색"});
            $("#searchD").dialog("open")

        });


        $("#b2").click(function () {
            let s_type = $("#searchType").val();
            let s_value = $("#searchValue").val();

            $.ajax({
                url: "Controller",
                dataType: "json", // 서버측에서 응답하는 데이터 형식📍📍📍 중요 application/json
                type: "post",
                data: {
                    type: "search2",
                    searchType: s_type,
                    searchValue: s_value
                }
                // 응답되는 all.jsp에서 반복수행 된 tr들

            }).done(function (res) {
                console.log(res.items.length)
                let str = "";
                for (let i = 0; i < res.items.length; i++) {
                    str += "<tr><td>";
                    str += res.items[i].empno;
                    str += "</td><td>";
                    str += res.items[i].ename;
                    str += "</td><td>";
                    str += res.items[i].job;
                    str += "</td><td>";
                    str += res.items[i].sal;
                    str += "</td><td>";
                    str += res.items[i].hiredate;
                    str += "</td><td>";
                    str += res.items[i].deptno;
                    str += "</td></tr>";
                }
                $("table.table>tbody").html(str)

                $("#searchD").dialog("close")
            });
        });


        $("#b").click(function () {
            let s_type = $("#searchType").val();
            let s_value = $("#searchValue").val();

            $.ajax({
                url: "Controller",
                type: "post",
                data: {
                    type: "search",
                    searchType: s_type,
                    searchValue: s_value
                }
                // 응답되는 all.jsp에서 반복수행 된 tr들

            }).done(function (res) {
                $("table.table>tbody").html(res)
                $("#searchD").dialog("close")
            });
            console.log("찍힘")
        });
    });

</script>

</body>
</html>
