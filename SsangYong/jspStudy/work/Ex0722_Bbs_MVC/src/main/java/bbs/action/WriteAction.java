package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WriteAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        String viewPath =null;

        // list.jsp에 있는 [글쓰기]버튼을 클릭하면 get방식으로
        // 현재 객체를 수행한다. 이때 contenttype을 얻어낸다.
        String enc_type=request.getContentType();
//        System.out.println(enc_type);
        if(enc_type ==null)
            viewPath="write.jsp";
        else if(enc_type.startsWith("multipart")){
            // write.jsp에서 내용을 입력한 후 보내기 버튼을 눌렀을 때 수행

            // 첨부 파일 저장 bbs_upload라는 폴더에 저장

        }
        return viewPath;
    }
}
