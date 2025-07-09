package com.example.ex_0709;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

// 1. 클래스 이름을 파일명과 동일하게 "Servlet1"으로 변경
// 2. @WebServlet의 이름(name)과 URL 경로(value)를 "Servlet1"으로 명확하게 지정
@WebServlet("/ms1") //요청경로
public class Servlet1 extends HttpServlet {

    public Servlet1() {
        System.out.println("생성자!");
    }

    @Override
    public void destroy() {
        System.out.println("destroy!");
    }

    @Override
    public void init(ServletConfig config) throws ServletException {
        System.out.println("init!");
    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("service!");

        // 요청된 방식이 get이면 doGet 호출
        if(req.getMethod().equalsIgnoreCase("get")) {
            doGet(req, resp);
        } else {
            doPost(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("doGet!");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("doPost!");
    }
}