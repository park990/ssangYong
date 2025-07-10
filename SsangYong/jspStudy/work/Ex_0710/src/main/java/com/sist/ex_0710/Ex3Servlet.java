package com.sist.ex_0710;

import mybatis.vo.EmpVO;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Reader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/Ex3")
public class Ex3Servlet extends HttpServlet {
    SqlSessionFactory factory;

    @Override
    public void init(ServletConfig config) throws ServletException {
        try{
            Reader r= Resources.getResourceAsReader("mybatis/config/conf.xml");
            factory=new SqlSessionFactoryBuilder().build(r);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        String searchType=request.getParameter("searchType");
        String searchValue=request.getParameter("searchValue");

        //emp.search라는 sql문을 호출하기 위해 파라미터들을 map구조에 담아야한다.
        Map<String, String> m= new HashMap<>();
        m.put("searchType",searchType);
        m.put("searchValue",searchValue);

        //emp.search라는 sql문을 호출하기 위해 sqlsession을 얻어낸다.
        SqlSession ss =factory.openSession();
        List<EmpVO> list = ss.selectList("emp.search1",m);

        /*==========================여기까지 중요================================*/

        //한번에 쓰기 위해 스트링버퍼로
        StringBuffer sb= new StringBuffer("<ol>");
        for(EmpVO vo:list){
            sb.append("<li>");
            sb.append(vo.getEmpno());
            sb.append(",");
            sb.append(vo.getEname());
            sb.append(",");
            sb.append(vo.getJob());
            sb.append(",");
            sb.append(vo.getDeptno());
            sb.append("</li>");
        }
        sb.append("</ol>");

        //응답을 위한 스트림 생성
        PrintWriter out=response.getWriter();
        out.println("<h2>검색결과</h2>");
        out.println("<hr/>");
        out.println(sb.toString());
        out.close();
        ss.close();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request,response);
    }
}
