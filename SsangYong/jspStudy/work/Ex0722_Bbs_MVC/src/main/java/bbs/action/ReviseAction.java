package bbs.action;

import bbs.dao.BbsDAO;
import mybatis.vo.BbsVO;
import mybatis.vo.CommVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ReviseAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String idx = request.getParameter("b_idx");
        String cPage = request.getParameter("cPage");
//        String c_b_idx= request.getParameter("c_b_idx");📍

        BbsVO vo = BbsDAO.revise(idx);
        request.setAttribute("vo",vo);

        return "revise.jsp";
    }
}
