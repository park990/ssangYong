package emp.action;

import mybatis.dao.EmpDAO;
import mybatis.vo.empVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;

public class SearchAction2 implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String idx=request.getParameter("searchType");
        String input =request.getParameter("searchValue");
        System.out.println(idx);
        System.out.println(input);

        empVO[] ar = EmpDAO.searchALL(idx,input);

        System.out.println(Arrays.toString(ar));

        request.setAttribute("ar",ar);

        return "jsp/search2.jsp";
    }
}
