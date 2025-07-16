<%@ page import="mybatis.vo.MemVO" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    public int useSize(File f) {
        // 이 폴더의 하위요소들의 File용량을 모두 더해야 한다. 우선 하위요소들을 모두 얻어내어
        File[] list = f.listFiles();
        int size = 0;
        //파일일 경우 용량을 사이즈에 누적시키자 폴더일경우 현재함수를 다시 호출(재귀호출)
        for (File sf : list) {
            if (sf.isFile())
                size += sf.length();
            else
                size += useSize(sf);
        }
        return size;
    }
%>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">

    <style>

        table {
            width: 600px;
            border-collapse: collapse;
        }

        table th, table td {
            border: 1px solid #27a;
            padding: 5px;
        }

        table th {
            background-color: #bcbcbc;
        }

        .title {
            background-color: #bcbcbc;
            width: 25%;
        }

        .btn {
            width: 70px;
            height: 20px;
            text-align: center;
            padding: 0px;
            display: inline-block;
            margin-right: 20px;

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

        #s_id, #s_pw {
            width: 80px;
            border: 1px solid #27a;
            border-radius: 3px;
            padding: 4px;
        }

        div#log_fail, div#log_suc {
            width: 170px;
            border: 1px solid #27a;
            border-radius: 3px;
        }

        div#box {
            display: inline-block;
            width: 65px;
            height: 20px;
            padding: 0;
            margin: 0;
            margin-left: 3px;
        }

        .success {
            color: #00f;
            font-weight: bold;
            font-size: 11px;
        }

        .fail {
            color: #f00;
            font-weight: bold;
            font-size: 11px;
        }

        div#my_alert, #upload_win, #folder_win {
            display: none;
        }

        .w50 {
            width: 50px;
        }

        .w80 {
            width: 50px;
        }

    </style>
</head>
<body>
<%
    int totalSize = 1024 * 1024 * 10; //10MByte
    int useSize = 0;
    // 로그인을 수행한 상태들만 허용하는 페이지이므로 로그인 검증하자
    Object obj = session.getAttribute("mvo");
    if (obj != null) {
        MemVO mvo = (MemVO) obj;
        //현재페이지로 올 때 파라미터 하나 받는다. 그것은 바로 cpath  파라미터 없으면 null을받는다
        String dir = request.getParameter("cPath"); //위치값
        String fname = request.getParameter("f_name");

        if (dir == null)
            dir = mvo.getM_id();
        else {
            //이미 myDisk에 들어왔다가 다른 작업을 클릭하여 요청한 경우
            if (fname != null && fname.trim().length() > 0) {
                dir = dir + "/" + fname;
            }
        }
        //dir이 구해진 후 나중에 파일 올리기를 할 때 upload.jsp에서 필요하므로 세션에 미리 저장하자
        session.setAttribute("dir", dir);

        String r_path = application.getRealPath("/members/" + mvo.getM_id());
        useSize = useSize(new File(r_path));

%>

<h1>My Disk Service</h1>
<hr/>
<%=mvo.getM_name()%>(<span class="m_id"><%=mvo.getM_id()%>)</span>님의 디스크
&nbsp;[<a href="javascript:home()">Home</a>]
<hr/>

<table>
    <caption>디스크사용량 테이블</caption>
    <tbody>
    <tr>
        <th class="title">전체용량</th>
        <td><%=totalSize / 1024%><%="KB"%>
        </td>
    </tr>
    <tr>
        <th class="title">사용량</th>
        <td><%=useSize / 1024%><%="KB"%>
        </td>
    </tr>
    <tr>
        <th class="title">남은용량</th>
        <td><%=(totalSize - useSize) / 1024%><%="KB"%>
        </td>
    </tr>
    </tbody>
</table>
<hr/>
<div id="btn_area">
    <p class="btn">
        <a href="javascript:selectFile()">파일올리기</a>
    </p>
    <p class="btn">
        <a href="javascript:dialogFolder()">폴더생성</a>
    </p>
    <p class="btn">
        <a href="javascript:exe()">파일생성</a>
    </p>
</div>
<hr/>
<label for="dir">현재위치:</label>
<span id="dir"><%=dir%></span>


<table>
    <caption>위치 폴더 안에 내용을 표현</caption>
    <thead>
    <tr>
        <th class="w50">구분</th>
        <th>폴더 및 파일명</th>
        <th class="w80">삭제여부</th>
    </tr>
    </thead>
    <tbody>
    <%if (!dir.equalsIgnoreCase(mvo.getM_id())) {%>
    <tr>
        <td></td>
        <td><a href="javascript:back()" id="up">상위로</a></td>
        <td></td>
    </tr>
    <% }%>


    <%

        // [상위로] 기능구현.

        //현재위치값dir을 가지고 file객체를 만들기위해 절대경로가 필요하다.
        String realPath = application.getRealPath("/members/" + dir);

        //절대경로를 만든이유는 file객체를 생성하여 하위에있는 파일 또는 폴더들을 얻기위함
        File s_file = new File(realPath);

        //위에서 만든 file객체 안에 있는 하위요소(파일 및 폴더들)얻기
        File[] sub_list = s_file.listFiles();
        for (File f : sub_list) {
    %>

    <tr>
        <td><%if (f.isFile()) out.print("파일");%></td>
        <td>

            <% if (f.isDirectory()) { //디렉토리일 경우는 들어갈 수 있어야 한다. %>
            <a href="javascript:gogo('<%=f.getName()%>')">
                <%=f.getName()%>
            </a>
            <% } else { %>
            <a href="javascript:down('<%=f.getName()%>')">
            <%=f.getName()%>
            </a>
            <% } %>
        </td>
        <td></td>
    </tr>

    <%

        }//for의 끝
    %>

    </tbody>
</table>
<form name="ff" method="post">
    <input type="hidden" name="f_name"/>
    <input type="hidden" name="cPath" value="<%=dir%>"/> <%--1111/123--%>
</form>

<%--파일첨부가 되는 폼은 반드시 enctype이 multipart/form/data로 지정이되어야 한다.
폼에 파일을 첨부하게 되면 무조건 enctype이 지정되어야 한다.--%>
<div id="upload_win" title="파일올리기">
    <form action="upload.jsp" method="post" name="frm2" enctype="multipart/form-data"><%--파일첨부가 되는 애들은 전부 multipart--%>
        <label for="selectFile">첨부파일:</label>

        <%--cPath는 전해줄 필요가 없다.--%>
        <%--        <input type="hidden" name="cPath" value="<%=dir%>"/>--%>

        <%--파일선택기--%>
        <input type="file" id="selectFile" name="upload"/><br/>
        <p class="btn"><a href="javascript:upload()">보내기</a></p>
        <p class="btn"><a href="javascript:closeUpload()">닫기</a></p>
    </form>
</div>

<div id="folder_win" title="폴더만들기">
    <form action="makeFolder.jsp" method="post" name="frm3">
        <%--cPath는 전해줄 필요가 없다.--%>
        <input type="hidden" name="cPage" value="<%=dir%>"/>

        <label for="f_name">폴더명:</label>

        <%--파일선택기--%>
        <input type="text" id="f_name" name="f_name"/><br/>
        <p class="btn"><a href="javascript:makeFolder()">만들기</a></p>
        <p class="btn"><a href="javascript:closeFolder()">닫기</a></p>
    </form>
</div>

<%
    } else
        response.sendRedirect("../index.jsp");
%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
<script>
    function home() {
        location.href = "myDisk.jsp"
    }

    function gogo(folder_name) {
        //폴더를 클릭했을 때 해당 폴더명을 인자로 전달하여 수행하는 함수
        // alert(folder_name)

        //현재문서(document)에서 이름이 ff인 폼객체를 찾아 그안에 이름이
        //f_name인 요소의 값(value)으로 인자로 받은 folder_name을 지정한다.
        document.ff.f_name.value = folder_name;
        document.ff.action = "myDisk.jsp"
        document.ff.submit();
    }

    function back() {
        if (document.ff.cPath.value.indexOf("/") !== -1) { // ==> cPath = 1111/123
            let slashIndex = document.ff.cPath.value.lastIndexOf("/");
            let expectedDir = document.ff.cPath.value.substring(0, slashIndex); // ==> expectedDir = 1111
            document.ff.cPath.value = expectedDir; // ==> cPath = 1111
            document.ff.f_name.value = "";
            document.ff.action = "myDisk.jsp"
            document.ff.submit();
        }
    }

    function selectFile() {
        $("#upload_win").dialog({});
    }

    function closeUpload() {
        $("#upload_win").dialog("close");
    }

    function upload() {
        document.frm2.submit();
    }

    function dialogFolder() {
        $("#folder_win").dialog();
    }

    function makeFolder() {
        document.frm3.submit();
    }

    function closeFolder() {
        $("#folder_win").dialog("close");

    }

    function down(fname) {
        //인자로 받은 파일명을 현재문서 안에있는 ff라는 이름의 폼객체안에
        //이름이 f_name이라는 input type="hidden"요소의 값(value)로
        //지정한다.
        document.ff.f_name.value=fname;

        document.ff.action="download.jsp"
        document.ff.submit();// 서버로 전달

        document.ff.f_name.value="";
    }

</script>
</body>
</html>
