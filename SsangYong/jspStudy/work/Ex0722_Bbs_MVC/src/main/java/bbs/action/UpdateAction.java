package bbs.action;

import bbs.dao.BbsDAO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

public class UpdateAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String viewPath = null;
        String b_idx = null;
        String cPage = null; // cPage도 밖에서 선언

        try {
            ServletContext application = request.getServletContext();
            String realPath = application.getRealPath("/bbs_upload");

            MultipartRequest mr = new MultipartRequest(request, realPath,
                    1024 * 1024 * 5, "utf-8", new DefaultFileRenamePolicy());

            // ❗ 모든 파라미터는 mr 객체로부터 가져와야 합니다.
            b_idx = mr.getParameter("b_idx");
            cPage = mr.getParameter("cPage");

            if (b_idx == null || b_idx.trim().isEmpty()) {
                // b_idx가 없으면 cPage와 함께 목록으로 보낸다.
                return "Controller?type=list&cPage=" + cPage;
            }

            String title = mr.getParameter("title");
            String content = mr.getParameter("content");
            String writer = mr.getParameter("writer");

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
            // 예외 발생 시에도 cPage와 함께 목록 페이지로 이동
            viewPath = "Controller?type=list&cPage=" + cPage;
        }

        // 최종적으로 결정된 경로를 반환
        return viewPath;
    }
}
