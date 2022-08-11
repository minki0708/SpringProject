<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
</head>
<body>
	<div class="w3-center" style="margin-top:500px;">
	<c:if test="${not empty fmid}">
		찾은아이디:
		<b>${fmid}<b>
	</c:if>
	<c:if test="${empty fmid}">
		임시 비밀번호를 가입하실 때 기입하신 이메일로 발송하였습니다
	</c:if>
	</div>
</body>
</html>