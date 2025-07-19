package am;

import emp.action.Action;
import emp.action.IndexAction;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.*;

@WebServlet("/Controller")
public class Controller extends HttpServlet {
    //Properties 파일의 경로를 저장하자.
    private String myparam = "/WEB-INF/action.properties";

    // 위의 myparam이 action.properties의경로를 갖고 있는데
    // 키와 value 값이 있다. value= 클래스의 경로
    // index 라는 문자열로 된 경로를 가져와서 객체로 생성한다.
    // 그 것을 Map구조에 저장할 것.

    private Map<String, Action> actionMap;

    public Controller() {
        actionMap = new HashMap<>();
    }

    public void init() throws ServletException {
        //한 번만 수행
        // myparm을 절대 경로롤 만들자
        // jsp에서는 application이라는 내장 객체가 존재하지만
        // servlet에서는 직접 얻어내야 한다.
        ServletContext application = getServletContext();

        String realPath = application.getRealPath(myparam);

        // 파일의 이름을 스트름을 이용해 읽은 뒤 properties객체에 담자.
        Properties prop = new Properties();

        // prop.setProperty("index","emp.action.IndexAction");
        // 위처럼 저장을 하면 기능 생길때 마다 수정필요 유지보수 안좋음

        //Properties load 함수를 이용해 내용읽기 실행
        FileInputStream fis = null;
        try {
            fis = new FileInputStream(realPath);
            prop.load(fis);
            // index(키)---> emp.action.IndexAction(값)이 저장된다.
            fis.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        // properties객체로 저장된 상태지만 컨트롤러는 몇개인지 어떤 객체인지 알수 없음.
        // 그래서 키를 모두 갖고와 반복자(iterator)로 수행해야 한다.
        Iterator<Object> it = prop.keySet().iterator();

        //키를 모두 얻었으니 키에 연결된 클래스 경로를 하나씪 얻어내 생성후 actionMAp에 저장하자
        while (it.hasNext()) {
            //먼저 키를 하나 얻어내어 문자열로 반환
            String key = (String) it.next();

            //위에서 얻어낸 키와 연결된 값(value:클래스 경로)
            String value = prop.getProperty(key);//"emp.action.IndexAction" 스트림을 옴
            try {
                Object obj = Class.forName(value).newInstance();
                //Class를 통해 클래스의 경로가 있다면 위와 같이 객체 생성 가능

                actionMap.put(key, (Action) obj);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }//while의 끝

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //요청시 한글처리
        request.setCharacterEncoding("utf-8");

        //type이라는 파라미터 받기
        String type = request.getParameter("type");

        //type이 null이면 index로 초기화
        if (type == null)
            type = "index";

        //type으로 받은 값이 actionMap에서 키로 사용되고 있으므로 원하는 객체 얻어내자
        // 📍 1. 지금 현재 상태
        // actionMap = {
        //      "index" : "emp.action.IndexAction",
        //      "add" : "emp.action.AddAction",
        //      "total" : "emp.action.TotalAction",
        //      "dept" : "emp.action.DeptAction",
        //      "all" : "emp.action.AllAction",
        //      "search" : "emp.action.SearchAction",
        // }


        Action action = actionMap.get(type);
        // 📍 2. Map의 get()함수를 사용해서 key를 집어넣어서 원하는 Action을 불러옴
        // 지금 여기서는 "search"를 넣었다고 치면,
        // action 에는 SearchAction이 할당되는 것임

        String viewPath = action.execute(request, response);

        //viewPath가 null이면 현재 컨트롤러를 sendredirect
        if (viewPath == null)
            response.sendRedirect("/Controller");
        else{
            //forward로 이동
            RequestDispatcher disp= request.getRequestDispatcher(viewPath);
            disp.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}