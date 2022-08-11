<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adContent</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
<style>
.table{
	text-align:center;
}
</style>
</head>
<body>
<p><br/></p>
<div class="container">
  <h3>거래현황</h3>
  <table id="table" class="w3-table">
  <tr class="w3-light-gray w3-border">
	  <th>주문날짜</th>
	  <th>상품 정보</th>
	  <th>판매자 정보</th>
	  <th>구매자 정보</th>
	  <th>배송지</th>
	  <th>배송상태</th>
	  <th>가격</th>
  </tr>
	  <c:forEach var="vo" items="${vos}">
		<tr style="cursor:pointer" onclick="location.href='${ctp}/product/content?idx=${vo.idx}&&mode=admin';">
			<c:set var="dlen" value="${fn:length(vo.orderDate) }"/>
			<c:set var="pre" value="${fn:substring(vo.orderDate,0,10)}"/>
			<c:set var="las" value="${fn:substring(vo.orderDate,11,dlen)}"/>
			<td>${pre}<br>${las }</td>
			<td>
				<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
				<div class="img-box">
					<img src="${ctp}/pds/${fSNames[0]}" style="width: 50px;height: 50px">
				</div>
				${vo.title}
			</td>
			<td>${vo.sellerName}<br>${vo.sellerMid}</td>
			<td>${vo.buyerName}<br>${vo.buyerMid}</td>
			<td>${vo.address}</td>
			<td>${vo.deliveryStatus}</td>
			<td>${vo.price}</td>
		</tr>
	  </c:forEach>
  </table>
</div>
</body>
</html>