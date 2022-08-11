<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>My Page</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<script>
	function check(){
		let mid = document.getElementById("mid").value;
		let password = document.getElementById("pwd").value;
		let reason = document.getElementById("reason").value;
		
		if(mid == ""){
			alert("탈퇴할 아이디를 입력해주세요");
			return false;
		}
		else if(password == ""){
			alert("비밀번호를 입력해주세요");
			return false;
		}
		else if(reason == "") {
			alert("탈퇴사유를 입력해주세요");
			return false;
		}
		
		let ans = confirm("탈퇴하시게 되면 한달동안 같은 아이디로 가입하실수 없고 \n 재 로그인시 탈퇴처리가 취소 됩니다 정말로 하시겠습니까?")	
		if(ans == -1){
			return false;
		}
		myForm.submit();
	}
</script>
<style>
</style>	
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<div style="margin-top:20em;">
		<form id="myForm" name="myForm" action="${ctp}/user/userOut" method="post" >
			<div>
				아이디를 다시 입력해주세요<input id="mid" name="mid" type="text">
			</div>
			<div>
				비밀번호를 다시 입력해주세요<input id="pwd" name="pwd" type="password">
			</div>
			<div>
				회원탈퇴 이유를 입력해주세요
				<textarea id="reason" rows="3" cols="50"></textarea>
			</div>
			<input type="button" onclick="check()" value="탈퇴하기">	
		</form>
	</div>
</body>
</html>