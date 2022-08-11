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
</head>
<body>
<p><br/></p>
<div class="container">
  <h3>유저 관리</h3>
  <hr style="border-color: black;border-width: 2px">
  <table class="w3-table">
  <tr>
	  <th>아이디</th>
	  <th>이름</th>
	  <th>닉네임</th>
	  <th>연락처</th>
	  <th>이메일</th>
	  <th>주소</th>
	  <th>가입일자</th>
  </tr>
  <c:forEach var="vo" items="${vos}">
	<tr>
		<td>${vo.mid}</td>
		<td>${vo.name}</td>
		<td>${vo.nickName}</td>
		<td>${vo.tel}</td>
		<td>${vo.email}</td>
		<td>${vo.address}</td>
		<td>${vo.joinday}</td>
	</tr>
  </c:forEach>
  </table>
</div>
</body>
</html>