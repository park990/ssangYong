<%@ page import="mybatis.vo.empVO" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%
    Object obj = request.getAttribute("ar");
    if (obj != null) {
        empVO[] ar = (empVO[]) obj;
        JSONObject jsonList = new JSONObject();
        JSONArray itemList = new JSONArray();
        int i = 0;
        for (empVO vo : ar) {
            //자바 스크립트에서 인식 할 수 있도록 JSON표기법을 구현하자.
            JSONObject json = new JSONObject(); // { } 제이슨 객체 생성
            json.put("empno", vo.getEmpno()); // {empno: '1000'}
            json.put("ename", vo.getEname()); // {empno: '1000',ename:'이도'}
            json.put("job", vo.getJob()); // {empno: '1000',ename:'이도',job:'develop'}
            json.put("sal", vo.getSal());
            json.put("hiredate", vo.getHiredate());
            json.put("deptno", vo.getDeptno());

            itemList.put(json);// [{empno: '1000',ename:'이도',job:'develop'},
                               //   {             다른 사람                  } ]
        }
        jsonList.put("items", itemList);/*  { items:[{  },{  },{  }]  }   */
        out.println(jsonList); // 응답
    }
%>