package bbs.action;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;

public class SaveImgAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 절대경로 만들기
        ServletContext application = request.getServletContext();
        String realPath = application.getRealPath("/editor_img");

        // 멀티팟 으로 request에 있는 frm을 저장
        try {
            MultipartRequest mr = new MultipartRequest(request, realPath, 1024 * 1024 * 5,
                    "utf-8", new DefaultFileRenamePolicy());

            // write jsp에서 저장한 frm을 upload로 저장했던 파일을 f 에 담고
            File f = mr.getFile("upload");
            String f_name=null;
            // 파일이 비어있지 않으면
            if (f != null) {
                f_name = f.getName();
                // 그리고 request에  파일 이름을 저장한다저장한다.
                request.setAttribute("f_name",f_name);
                System.out.println(f_name);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        return "saveImg.jsp";
    }
}
