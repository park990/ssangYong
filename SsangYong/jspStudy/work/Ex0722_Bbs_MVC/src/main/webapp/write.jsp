<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="../css/summernote-lite.css"/>
    <style type="text/css">
        #bbs table {
            width: 580px;
            margin-left: 10px;
            border: 1px solid black;
            border-collapse: collapse;
            font-size: 14px;

        }

        #bbs table caption {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        #bbs table th {
            text-align: center;
            border: 1px solid black;
            padding: 4px 10px;
        }

        #bbs table td {
            text-align: left;
            border: 1px solid black;
            padding: 4px 10px;
        }

        .no {
            width: 15%
        }

        .subject {
            width: 30%
        }

        .writer {
            width: 20%
        }

        .reg {
            width: 20%
        }

        .hit {
            width: 15%
        }

        .title {
            background: lightsteelblue
        }

        .odd {
            background: silver
        }


    </style>
    <script type="text/javascript">
        function sendData() {
            for (var i = 0; i < document.forms[0].elements.length; i++) {
                if (document.forms[0].elements[i].value == "") {
                    alert(document.forms[0].elements[i].name +
                        "를 입력하세요");
                    document.forms[0].elements[i].focus();
                    return;//수행 중단
                }
            }

//		document.forms[0].action = "test.jsp";
            document.forms[0].submit();
        }
    </script>
</head>
<body>
<div id="bbs">
    <form action="Controller?type=write" method="post"
          encType="multipart/form-data">
        <table summary="게시판 글쓰기">
            <caption>게시판 글쓰기</caption>
            <tbody>
            <tr>
                <th>제목:</th>
                <td><input type="text" name="title" id="title" size="45"/></td>
            </tr>
            <tr>
                <th>이름:</th>
                <td><input type="text" name="writer" id="writer" size="12"/></td>
            </tr>
            <tr>
                <th>내용:</th>
                <td><textarea name="content" cols="50"
                        id="content"  rows="8"></textarea></td>
            </tr>
            <tr>
                <th>첨부파일:</th>
                <td><input type="file" name="file" id="file"/></td>
            </tr>
            <!--
                            <tr>
                                <th>비밀번호:</th>
                                <td><input type="password" name="pwd" size="12"/></td>
                            </tr>
            -->
            <tr>
                <td colspan="2">
                    <input type="button" value="보내기"
                           onclick="sendData()"/>
                    <input type="button" value="다시"/>
                    <input type="button" value="목록"/>
                </td>
            </tr>
            </tbody>
        </table>
    </form>
</div>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

<script src="./js/summernote-lite.js"></script>

<script src="./js/lang/summernote-ko-KR.js"></script>
<script>
    $(function () {
        $("#content").summernote({
            lang:"ko-KR",
            height:300,
            callbacks:{
                onImageUpload:function(files,editor){
                    // 에디터에 이미지가 추가될 때 수행
                    for(let i=0; i<files.length;i++)
                        sendImg(files[i],editor)
                }
            }
        });
    });

function sendImg(file, editor){
    // 서버로 비동기식 통신을 수행하기 위해 준비
    // 이미지를 서버로 보내기 위해 폼객체 생성
    let frm = new FormData();

    // 서버로 보낼 이미지 파일을 폼객체에 파라미터로 지정
    frm.append("upload",file);

    $.ajax({
        url:"Controller?type=saveImg",
        data:frm,
        type:"post",
        dataType: "json",
        contentType:false,
        processData:false,
    }).done(function (json){
       // 성공시 수행
        $("#content").summernote("editor.insertImage",json.img_url);
    });
}
</script>
</body>
</html>












