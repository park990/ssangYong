package bbs.action;

import bbs.dao.BbsDAO;
import mybatis.service.FactoryService;
import mybatis.vo.BbsVO;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ViewAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String idx= request.getParameter("b_idx");  // 기본키
        String cPage=request.getParameter("cPage"); // 목록보기

        BbsVO vo = BbsDAO.getBbs(idx);
        BbsDAO.hit(idx);
        request.setAttribute("vo",vo);
        request.setAttribute("nowPage",cPage);

        return "view.jsp";
    }
}
