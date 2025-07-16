  <%@ page import="mybatis.vo.ProductVO" %>
<%@ page import="shop.bean.ShopBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="sb" class="shop.bean.ShopBean" scope="session"/>
<jsp:setProperty name="sb" property="p_num" param="prod_num"/>

<%ProductVO vo = sb.getProduct();
  %>
<style>
  body {
    font-family: 'Malgun Gothic', sans-serif;
    padding: 20px;
  }

  .btn-bag {
    background-color: dodgerblue;
    color: white;
    border-color: dodgerblue;
  }
  .product-table input[type="button"] {
    padding: 10px 20px;
    font-weight: bold;
    border: 1px solid #ccc;
    border-radius: 5px;
    cursor: pointer;
    margin: 7px 5px;
  }
  .product-table {
    width: 100%;
    max-width: 700px; /* 테이블 최대 너비 */
    margin: 20px auto; /* 페이지 중앙 정렬 */
    border-collapse: collapse; /* 테두리 한 줄로 합치기 */
    box-shadow: 0 2px 5px rgba(0,0,0,0.1); /* 은은한 그림자 효과 */
    border-radius: 8px; /* 모서리 둥글게 */
    overflow: hidden;
  }
  .btn-bag:hover {
    background-color: #d6dde3;
  }
  .product-table img {
    max-width: 300px; /* 이미지 최대 너비 */
    height: auto; /* 높이 자동 조절 */
    display: block; /* 가운데 정렬을 위해 */
    margin: 10px auto; /* 위아래, 좌우 자동 여백 */
  }
  tbody td{
    padding:10px 0;
  }
  tr td:nth-child(1){
    font-weight: bold;
  }
  tr:nth-child(8) td{
    font-weight: normal;

  }
  td {
    border-bottom: 1px dashed #cccccc; /* 1px 두께의 옅은 회색(#eee) 실선 */
  }
  tr:nth-child(6) td, tr:nth-child(7) td {
    border-bottom: none;
  }


</style>

<table class="product-table">
  <colgroup>
    <col width="40%">
    <col width="60%">
  </colgroup>
  <tbody>
  <tr>
    <td>제품Category</td>
    <td><%=vo.getCategory()%></td>
  </tr>
  <tr>
    <td>제품번호</td>
    <td><%=vo.getP_num()%></td>
  </tr>
  <tr>
    <td>제품이름</td>
    <td><%=vo.getP_name()%></td>
  </tr>
  <tr>
    <td>제품 판매사</td>
    <td><%=vo.getP_company()%></td>
  </tr>
  <tr>
    <td>제품가격</td>
    <td>(할인가: <%=vo.getP_saleprice()%>원)</td>
  </tr>
  <tr>
    <td colspan="2">제품설명</td>
  </tr>
  <tr>
    <td colspan="2" align="center"><img src ="images/<%=vo.getP_image_l()%>" width="100" height="95"></td>
  </tr>
  <tr>
    <td colspan="2"><%=vo.getP_content()%></td>
  </tr>
  <tr>
    <td colspan="2" align="center">
      <input type="button" class="btn-bag" value="장바구니에 담기"
             onclick="javascript:location.href='addProduct.jsp?p_num='"/>
      <input type="button" class="btn-bag" value="장바구니 보기"
             onclick="javascript:location.href='cartList.jsp'"/>
    </td>
  </tr>
  </tbody>
</table>