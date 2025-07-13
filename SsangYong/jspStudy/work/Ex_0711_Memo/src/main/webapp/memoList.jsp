<%@ page import="mybatis.dao.memoDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="mybatis.vo.memoVO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    // 1. 인코딩 설정을 가장 먼저 실행
    request.setCharacterEncoding("utf-8");

    // 2. 그 다음에 파라미터를 받음
    String writer = request.getParameter("writer");
    String content = request.getParameter("content");

    if (writer != null && !writer.isEmpty()) {
        int cnt = memoDAO.addMemo(writer, content);
        response.sendRedirect("memoList.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>

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

        #write_win {
            display: none;
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

        #show_C {
            display: none;
        }
    </style>
</head>
<body>

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
                    />
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
                        <a href="javascript:exe(this.form)">
                            저장
                        </a>
                    </p>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
<div id="show_C" title="메모보기">

</div>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<script src="https://code.jquery.com/ui/1.13.3/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">


<script>

    // 다이얼로그 지워도됌%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    $(function () {
        $("#show_C").dialog({
            autoOpen: false, // 자동으로 열리지 않게
            modal: true,     // 모달 창으로
            width: 450,
            buttons: {
                "닫기": function () {
                    $(this).dialog("close");
                }
            }
        });

        $("#list_table tbody").on("click", ".show_content", function () {

            // 'parent()'나 'next()' 대신 가장 확실한 'closest()'와 'find()' 조합을 사용합니다.
            const row = $(this).closest("tr");

            // row를 찾았는지 확인하는 안전장치
            if (row.length === 0) {
                alert("오류: 클릭된 항목의 행(tr)을 찾을 수 없습니다.");
                return; // 함수를 여기서 중단
            }

            // 값을 가져옵니다.
            const content = $(this).html(); // this는 클릭된 td이므로 .html() 사용 가능
            const writer = row.find("td").eq(2).text();
            const reg_Date = row.find("td").eq(3).text();

            // 다이얼로그 내용 생성
            const dialogContent = `
                <p><strong>작성자:</strong> ${writer}</p>
                <p><strong>작성일:</strong> ${reg_Date}</p>
                <hr>
                <div style="white-space: pre-wrap; word-break: break-all;">${content}</div>
            `;

            // 다이얼로그 열기
            $("#show_C").html(dialogContent).dialog("open");
        });

    });

    // 다이얼로그 지워도됌%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    function writeMemo() {
        $("#write_win").css("display", "block");
    }


    function exe(frm) {
        document.f.submit();
    }


    // $("#writer").
</script>
</body>
</html>









