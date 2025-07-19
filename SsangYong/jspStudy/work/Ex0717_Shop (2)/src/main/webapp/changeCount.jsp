<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="cart" class="shop.bean.Cart" scope="session"/>
<%
    String pnum = request.getParameter("p_num");
    String count = request.getParameter("count");
    if (pnum != null && count != null) {
        int q = Integer.parseInt(count);
        if (q < 1)
            cart.delProduct(pnum);//숫자가 0이기 때문에 삭제한다.
        else
            cart.changeCount(pnum, q);
    }

    response.sendRedirect("cartList.jsp");
%>