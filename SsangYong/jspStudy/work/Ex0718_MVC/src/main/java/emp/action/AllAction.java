package emp.action;

import mybatis.dao.EmpDAO;
import mybatis.vo.empVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AllAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        empVO[] ar = EmpDAO.getALL();
        request.setAttribute("ar",ar);
        return "jsp/all.jsp";
    }
}
