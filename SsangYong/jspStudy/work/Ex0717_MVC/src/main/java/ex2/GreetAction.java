package ex2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GreetAction {
    public String execute(HttpServletRequest request,
                         HttpServletResponse response){
        request.setAttribute("msg","MVC를 시작합니다");
        return "/ex2/page2.jsp";
    }
}
