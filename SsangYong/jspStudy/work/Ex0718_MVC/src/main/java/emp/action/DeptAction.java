package emp.action;

import mybatis.dao.deptDAO;
import mybatis.vo.deptVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeptAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        deptVO[] ar= deptDAO.deptAll();
        request.setAttribute("ar",ar);
        return "jsp/dept.jsp";
    }
}
