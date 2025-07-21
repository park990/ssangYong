<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
  <link rel ="stylesheet" href="../css/summernote-lite.css"/>
  <style>
    article .table{
      width:600px;
    }
  </style>
</head>
<body>
  <div id ="wrap">
    <header><h1>썸머노트 웹에디터 연습</h1></header>
    <article>
      <form>
        <table id="table">
          <tbody>
            <tr>
              <th class="w100">제목:</th>
              <td><input type="text" id="title"/></td>
            </tr>
            <tr>
              <th class="w100">제목:</th>
              <td><textarea rows="12" cols="50" id="content"></textarea></td>
            </tr>
          </tbody>
          <tfoot>
        <tr>
          <td colspan="2"><button type="button" id="send_btn">보내기</button></td>
        </tr>
        </tfoot>
        </table>
      </form>
    </article>
  </div>
  <script
          src="https://code.jquery.com/jquery-3.7.1.min.js"
          integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
          crossorigin="anonymous"></script>
  <script src="../js/summernote-lite.js"></script>
  <script src="../js/lang/summernote-ko-KR.js"></script>
<script>
  $(function (){
    $('#content').summernote({
      lang:"ko-KR",
      height:300,
      minHeight:200,
      maxHeight:400,
      width:750,

      callbacks:{
        onImageUpload:function (files, editor){
          // 사용자가 이미지를 여러개 넣을 수 있기 때문에 files 라는 배열로 인식된다.
          // 이것을 서버로 비동기식 통신을 수행하여 서버에게 업로드 시키도록 하자.
          // console.log(files.length)
          for(let i =0; i<files.length;i++){
            // 이미지를 첨부파일로 서버로 전달하는 함수 호출
            sendImage(files[i],editor);
          }// for 의 끝
        }
      }
    });
    $("#content").summernote("lineHeight",0.5)
  });


  function sendImage(file,editor){
   // console.log(file.name+":sendImage");
  // 서버로 이미지 파일을 보내기 위해 반드시 폼 객체 준비
    let frm = new FormData(); //<form enctype="multipart/form-data"></form>

    //보내고자 하는 자원을 폼에 파라미터 값으로 등록
    frm.append("upload",file); // 폼 객체 안에 "upload" 라는 이름으로 파일이 등록된 상태.

    //비동기식
    $.ajax({
      url:"Controller?type=saveImg",
      data:frm,
      type:"post",
      dataType: "json", //서버에서 전달하는 자원의 자료형
      contentType:false,// 파일을 전송할 때는 multipart 로 가야한다.
      processData:false, // 이것을 지정해야 일반적인 데이터 전송이 아님을 증명한다.

    }).done(function (json){
      // 서버에 이미지를 성공적으로 업로드 시켰을 때 수행.
      $("#content").summernote("editor.insertImage",json.img_url);
      //insertImage가 <img src...>라는 태그를 에디터에 넣는 명령어
    });

  }
</script>

</body>
</html>
