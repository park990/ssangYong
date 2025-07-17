<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean class="shop.bean.ShopBean" id="sb" scope="session"/>
<jsp:useBean class="shop.bean.Cart" id="cart" scope="session"/>
<%
  String pnum = request.getParameter("p_num");
  cart.addProduct(sb,pnum);

  response.sendRedirect("product_content.jsp?prod_num="+pnum);
%>