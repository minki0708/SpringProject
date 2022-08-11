<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<frameset cols="120px, *">
    	<frame src="${ctp}/admin/adList" name="adList" frameborder="0"/>
    	<frame src="${ctp}/admin/adContent" name="adContent"  frameborder="0"/>
  	</frameset>
</head>
<body>
	<table>
		<tr></tr>
		<tr></tr>
		<tr></tr>
		<tr></tr>
	</table>
</body>
</html>