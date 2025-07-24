package bbs.action;

import bbs.dao.BbsDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import mybatis.vo.BbsVO;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

public class ReviseAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response){ // 변수명이 잘려 re까지만 보입니다.
        // // 먼저 요청시 contentType을 얻어낸다.
        String enc_type = request.getContentType();

        String viewPath = null;
        if(enc_type.startsWith("application")){
            // 수정 버튼 클릭 하면 수정 화면으로 이동
            String b_idx=request.getParameter("b_idx");
            BbsVO vo = BbsDAO.getBbs(b_idx);

            request.setAttribute("vo",vo);
            viewPath="revise.jsp"; // 여기서 foward 된다. cPage도 같이 간다.

        }else if(enc_type.startsWith("multipart")){
            // revise.jsp에서(수정화면)에서 수정완료를 클릭한경우

            try {
                ServletContext application = request.getServletContext();
                String realPath = application.getRealPath("/bbs_upload");

                MultipartRequest mr = new MultipartRequest(request, realPath,
                        1024 * 1024 * 5, "utf-8", new DefaultFileRenamePolicy());


                String b_idx = mr.getParameter("b_idx");
                String title = mr.getParameter("title");
                String content = mr.getParameter("content");
                String writer = mr.getParameter("writer");
                String cPage =mr.getParameter("cPage");
                File f = mr.getFile("file");
                String fname = null;
                String oname = null;

                if (f != null) {
                    fname = f.getName();
                    oname = mr.getOriginalFileName("file");
                }

                BbsDAO.udt(b_idx, title, content, writer, fname, oname);

                // 성공 시, cPage 값을 포함하여 상세보기 페이지로 이동
                viewPath = "Controller?type=view&b_idx=" + b_idx + "&cPage=" + cPage;

            } catch (Exception e) {
                e.printStackTrace();
            }


        }
        return viewPath;
    }
}