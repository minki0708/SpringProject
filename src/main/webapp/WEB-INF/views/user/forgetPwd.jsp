<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
    <meta charset="UTF-8">
    <title>forgetId</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<div class="w3-container" style="width: 100%; max-height: 7000px; margin-top: 300px">
		<div class="w3-row w3-round" style="width: 30em;height:5em;margin: auto">
		<h4>비밀번호 찾기</h4>
		<hr>
		
		<form method="post" action="${ctp}/user/forgetPwd">
		
		
    	<label for="mid"><b><small>아이디</small></b></label>   
    	<input type="text" id="mid" class="w3-input w3-border" name="mid" style="width: 20em" placeholder="아이디를 입력해 주세요">
    	
    	<label for="name"><b><small>이름</small></b></label>   
    	<input type="text" id="name" class="w3-input w3-border" name="name" style="width: 20em" placeholder="이름을 입력해 주세요">
    	
    	<label for="tel"><b><small>전화번호</small></b></label>
	    <input type="text" id="tel" class="w3-input w3-border" name="tel" style="width: 20em" placeholder="전화번호를 입력해 주세요">
		
		
		<hr>
		<div class="w3-center">
	      	<input type="submit" class="w3-button w3-round w3-border w3-ripple w3-blue w3-hover-blue" value="찾기"/>
		</div>	
		</form>
		
		</div>
	</div>
</body>
</html>