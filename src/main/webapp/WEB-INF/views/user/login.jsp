<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Login.jsp</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
</head>

<body>
<div class="w3-border w3-round-large center w3-display-middle w3-margin" style="padding: 30px">
	<form name="form" method="post" action="${ctp}/user/login" >
			<input class="w3-input w3-border w3-round-large" type="text" name="mid" id="mid" value="${mid}" placeholder="ID">	
			<input class="w3-input w3-border w3-round-large" type="password" name="pwd" id="pwd" placeholder="PassWord">
	    <input class="w3-check" type="checkbox" name="idRemember" value="아이디 기억" checked/>
	    <label>아이디 기억하기</label>
	    <br>
	    <div class="w3-center">
		    <input class="w3-button w3-blue w3-hover-blue w3-ripple" type="submit" value="로그인" />
	    </div>
	    <c:if test="${empty sAuthority}">
		    <div class="m-1">
			    <a href="${ctp}/user/forgetId" >아이디 찾기</a>&nbsp;
		    	<a href="${ctp}/user/forgetPwd" >비밀번호 찾기</a>
	    	</div>
	    </c:if>
  	</form> 
</div>
<p><br/></p>
</body>
</html>