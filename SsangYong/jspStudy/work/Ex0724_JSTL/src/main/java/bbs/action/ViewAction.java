package bbs.action;

import bbs.dao.BbsDAO;
import mybatis.vo.BbsVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

public class ViewAction implements Action {

    public boolean checkBbs(List<BbsVO> list, BbsVO vo) {
        boolean value = true;
        // list에 vo가 있는지 판단하자
        for (BbsVO bvo : list) {
            if (bvo.getB_idx().equals(vo.getB_idx())) {
                // 리스트에 있는경우
                value = false;
                break;
            }
        }// for의끝


        return value;
    }


    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String idx = request.getParameter("b_idx");  // 기본키
        String cPage = request.getParameter("cPage"); // 목록보기

        // 한번이라도 읽은 게시물들은 list에 담아서 httpsession에 저장하자.
        // 먼저 http세션으로부터 list를 얻어내자
        HttpSession session = request.getSession();

        // session에 read_list라는 이름으로 저장된 객체를 얻어내자.
        Object obj = session.getAttribute("read_list");
        ArrayList<BbsVO> list = null;

        if (obj == null) {
            list = new ArrayList<>();
            session.setAttribute("read_list", list);
        } else
            list = (ArrayList<BbsVO>) obj;

        BbsVO vo = BbsDAO.getBbs(idx);

        if (checkBbs(list, vo)) {
            BbsDAO.hit(idx);
            list.add(vo); // list는 이미 httpsession에 저장된 상태
        }


            request.setAttribute("vo", vo);
        request.setAttribute("nowPage", cPage);

        return "view.jsp";
    }
}
