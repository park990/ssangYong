package ex3;

import mybatis.dao.EmpDAO;
import mybatis.vo.EmpVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EmpAction implements Action {
    public String execute(HttpServletRequest request,
                          HttpServletResponse response){
        //사원목록 가져오자
        EmpVO[] ar= EmpDAO.getAll();

        //얻어낸 목록 ar을 request에 emp라는 이름으로 저장하자
        request.setAttribute("emp",ar);
        return "ex3/emp.jsp";
    }
}
