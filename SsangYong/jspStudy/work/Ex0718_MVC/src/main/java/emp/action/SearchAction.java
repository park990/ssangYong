package emp.action;

import mybatis.dao.EmpDAO;
import mybatis.vo.empVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SearchAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String idx=request.getParameter("searchType");
        String input =request.getParameter("searchValue");
        System.out.println(idx);
        System.out.println(input);

        empVO[] ar = EmpDAO.searchALL(idx,input);
        request.setAttribute("ar",ar);

        return "jsp/search.jsp";
    }
}
