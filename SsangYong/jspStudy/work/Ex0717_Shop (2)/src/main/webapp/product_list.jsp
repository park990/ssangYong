<%@ page import="mybatis.vo.ProductVO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
  <title></title>
  <link rel="stylesheet" href="./css/style.css">
</head>
<body>
<div id="wrap">
  <header>
    <jsp:include page="./menu.jsp"/>
  </header>

<article>
  <jsp:useBean id="sb" class="shop.bean.ShopBean" scope="session"/>
  <jsp:setProperty name="sb" property="*"/>
  <%-- 위는 sb.setCategory(request.getParameter("category"))와 같다 --%>
  <%
    sb.searchProduct();// ShopBean의 멤버변수인 p_list라는 배열이 채워진다.

    // ShopBean이 가지고 있는 p_list라는 배열을 얻어낸다.
    ProductVO[] ar = sb.getP_list();
  %>
  <table class="table">
    <tr>
      <th >제품번호</th>
      <th >이미지</th>
      <th >제품명</th>
      <th >제품가격</th>
      <th >비고</th>
    </tr>
<%
  if(ar != null){
    for(ProductVO pvo : ar){
%>
    <tr align="center">
      <td><%=pvo.getP_num()%></td>
      <td><img src="images/<%=pvo.getP_image_s()%>" width="100" height="95"></td>
      <td>
        <a href="product_content.jsp?prod_num=<%=pvo.getP_num()%>">
          <%=pvo.getP_name()%>
        </a>
      </td>
      <td>
        할인가 : <%=pvo.getP_saleprice()%>원<br>
        <font color="red">(<%=pvo.getPercent()%>%)</font>
      </td>
      <td>
        시중 가격 : <%=pvo.getP_price()%>원
      </td>
    </tr>
<%
    }//for의 끝
  }else{
%>
    <tr>
      <td colspan="5" class="txt_C">
        검색된 제품이 없습니다.
      </td>
    </tr>
<%
  }//if문의 끝
%>
  </table>

</article>
</div>
</body>
</html>
