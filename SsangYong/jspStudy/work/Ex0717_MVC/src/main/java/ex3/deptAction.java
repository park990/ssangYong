package ex3;

import mybatis.dao.deptDAO;
import mybatis.vo.deptVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class deptAction implements Action {
    @Override
    public String execute(HttpServletRequest request,
                          HttpServletResponse response){

        //dept 목록을 가져오자 배열로 받자
        deptVO[] ar = deptDAO.getAll();
        request.setAttribute("dept",ar);
        return"ex4/dept.jsp";
    }
}
