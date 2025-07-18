package emp.action;

import mybatis.dao.EmpDAO;
import mybatis.vo.empVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TotalAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        empVO[] ar = EmpDAO.getALL();

        //jsp에서 표현하기 위해 request에 저장한다.
        request.setAttribute("ar",ar);
        return "jsp/total.jsp";
    }
}
