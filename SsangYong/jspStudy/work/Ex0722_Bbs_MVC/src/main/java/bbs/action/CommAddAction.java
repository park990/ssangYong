package bbs.action;

import bbs.dao.CommDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CommAddAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String cPage =request.getParameter("cPage");
        String writer =request.getParameter("writer");
        String content =request.getParameter("content");
        String pwd =request.getParameter("pwd");
        String b_idx =request.getParameter("b_idx");
        String ip =request.getRemoteAddr();

        CommDAO.add(writer,content,pwd,ip,b_idx);

        return "Controller?type=view&b_idx="+b_idx+"&cPage="+cPage;
    }
}
