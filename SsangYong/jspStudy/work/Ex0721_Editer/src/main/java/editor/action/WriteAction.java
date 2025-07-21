package editor.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class WriteAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String viewPath ="jsp/write.jsp";

        return viewPath;
    }
}
