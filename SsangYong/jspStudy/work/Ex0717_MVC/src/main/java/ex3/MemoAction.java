package ex3;

import mybatis.dao.EmpDAO;
import mybatis.dao.MemoDAO;
import mybatis.vo.EmpVO;
import mybatis.vo.MemoVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemoAction implements Action {
    public String execute(HttpServletRequest request,
                          HttpServletResponse response){
        //사원목록 가져오자
        MemoVO[] ar= MemoDAO.getAll();

        //얻어낸 목록 ar을 request에 emp라는 이름으로 저장하자
        request.setAttribute("memo",ar);
        return "ex3/memo.jsp";
    }
}
