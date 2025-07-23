package bbs.action;

import bbs.dao.BbsDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

public class WriteAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String viewPath = null;

        // list.jsp에 있는 [글쓰기]버튼을 클릭하면 get방식으로
        // 현재 객체를 수행한다. 이때 contenttype을 얻어낸다.
        String enc_type = request.getContentType();
//        System.out.println(enc_type);
        if (enc_type == null)
            viewPath = "write.jsp";
        else if (enc_type.startsWith("multipart")) {
            // write.jsp에서 내용을 입력한 후 보내기 버튼을 눌렀을 때 수행

            // 첨부 파일 저장 bbs_upload라는 폴더에 저장
            try {
                ServletContext application = request.getServletContext();
                String realPath = application.getRealPath("/bbs_upload");

                MultipartRequest mr = new MultipartRequest(request, realPath,
                        1024 * 1024 * 5, "utf-8", new DefaultFileRenamePolicy());
                // 첨부파일 있다면 realPath경로에 자동으로 저장이 된다.

                // 나머지 파라미터들 얻기(title/ writer, content)
                String title= mr.getParameter("title");
                String writer = mr.getParameter("writer");
                String content = mr.getParameter("content");
                String bname = mr.getParameter("bname");

                File f = mr.getFile("file");
                String fname =null;
                String oname=null;
                if(f!=null){
                    fname=f.getName();
                    oname=mr.getOriginalFileName("file"); // 원래 파일명
                }
                String ip = request.getRemoteAddr(); // 요청자의 IP

                // DB에 저장
                BbsDAO.add(title,writer,content,fname,oname,ip,bname);


            } catch (Exception e) {
                e.printStackTrace();
            }

        }
        return viewPath;
    }
}
