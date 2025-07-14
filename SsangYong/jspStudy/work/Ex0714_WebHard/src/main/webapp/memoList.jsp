<%@ page import="mybatis.dao.memoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="mybatis.vo.memoVO" %>
<%@ page import="mybatis.vo.memberVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    // 1. 인코딩 설정을 가장 먼저 실행
    request.setCharacterEncoding("utf-8");

    // 2. 그 다음에 파라미터를 받음
    String writer = request.getParameter("writer");
    String content = request.getParameter("content");
    String ip = request.getRemoteAddr();

    if (writer != null && !writer.isEmpty()) {
        int cnt = memoDAO.addMemo(writer, content, ip);
        response.sendRedirect("memoList.jsp?cmd=" + cnt);
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">

    <style>
        #list_table {
            border-collapse: collapse;
            width: 400px;
        }

        #list_table th, #list_table td {
            border: 1px solid #27a;
            padding: 3px;
        }

        #list_table thead th {
            background: #5ad;
            color: #fff;
        }

        #list_table caption {
            font-size: 30px;
            font-weight: bold;
            padding-bottom: 20px;
        }

        .btn {
            width: 70px;
            height: 20px;
            text-align: center;
            padding: 0px;
        }

        .btn a {
            display: block;
            width: 100%;
            padding: 4px;
            height: 20px;
            line-height: 20px;
            background: #27a;
            color: #fff;
            border-radius: 3px;
            text-decoration: none;
            font-size: 12px;
            font-weight: bold;
        }

        .btn a:hover {
            background: #fff;
            color: #27a;
            border: 1px solid #27a;
        }

        #list_table thead tr:first-child td {
            border: none;
        }

        #writer {
            background-color: #dedede;
            border: 1px solid #ababab;
        }

        /*다이얼로그%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
        .show_content {
            cursor: pointer;
        }

        .show_content:hover {
            background-color: #f0f8ff; /* 연한 하늘색 */
        }

        /*다이얼로그%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/

        .show {
            display: block;
        }

        #cmd_win {
            display: none;
        }
    </style>
</head>
<body>
<%
    //index.jsp에서 현재 페이지로 넘어왔다면cmd는 null
    String cmd = request.getParameter("cmd");
    Object obj =session.getAttribute("mvo");
    if(obj==null)
        response.sendRedirect("index.jsp"); // 강제 페이지 이동
    memberVO mvo =(memberVO) obj;

    String msg = null;
    if (cmd != null && cmd.equals("1"))
        msg = "저장완료";
    else if (cmd != null && cmd.equals("0")) {
        msg = "저장실패!";
    }
%>

<div id="wrap">
    <table id="list_table">
        <caption>메모 리스트</caption>
        <colgroup>
            <col width="50px">
            <col width="*">
            <col width="80px">
            <col width="90px">
        </colgroup>
        <thead>
        <tr>
            <td colspan="4">
                <p class="btn">
                    <a href="javascript:writeMemo()">
                        글쓰기
                    </a>
                </p>
            </td>
        </tr>
        <tr>
            <th>번호</th>
            <th>내용</th>
            <th>글쓴이</th>
            <th>등록일</th>
        </tr>
        </thead>
        <tbody>
        <%

            List<memoVO> vo = memoDAO.selectAll();

            for (memoVO v : vo) { %>
        <tr>
            <td><%= v.getIdx() %>
            </td>
            <td class="show_content"><%= v.getContent() %>
            </td>
            <td><%= v.getWriter() %>
            </td>
            <td><%= v.getReg_date() %>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>


<div id="write_win" title="글쓰기">
    <form action="memoList.jsp" method="post" name="f">
        <table>
            <tbody>

            <tr>
                <td><label for="writer">작성자:</label></td>
                <td>
                    <input type="text" id="writer"
                           name="writer"
                           value="<%=mvo.getMem_name()%>" readonly />
                </td>
            </tr>
            <tr>
                <td><label for="content">내용:</label></td>
                <td>
							<textarea cols="40" rows="6"
                                      id="content" name="content"></textarea>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <p class="btn">
                        <a href="javascript:exe()">
                            저장
                        </a>
                    </p>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>


<div id="cmd_win" title="Message">
    <%=msg%>
</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.min.js"></script>


<script>

    // 다이얼로그 지워도됌%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    $(function () {
        let option = {
            modal: true,
            autoOpen: false,
            title: "메모추가",
            width: 450,
            height: 280,
            resizable: false,
        };

        $("#write_win").dialog(option);
        <%
        if(msg!=null){
        %>
        $("#cmd_win").dialog();
        <%
        }
        %>

    });

    // 다이얼로그 지워도됌%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function writeMemo() {
        $("#write_win").dialog("open");
    }


    function exe() {
        let writer = $("#writer").val().trim();
        let content = $("#content").val().trim();
        if (writer.length == 0) {
            alert("이름을 입력하세요")
            $("#writer").val("");
            $("#writer").focus();
            return;
        }
        if (content.length == 0) {
            alert("내용을 입력하세요")
            $("#content").val("");
            $("#content").focus();
            return;
        }


        document.f.submit();
    }


    // $("#writer").
</script>
</body>
</html>









