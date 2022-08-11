<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/resources/js/address.js"></script>
  <script>
  'use strict';
	let check1 = 0;
	let check2 = 0;
	let check3 = 0;
	let check4 = 0;
	let check5 = 0;
	let check6 = 0;
	let check7 = 0;
	let check8 = 0;
	let check9 = 0;
	
	function regexId() {
	    const regEx = /^[a-zA-Z]/g;
	    const regEx1 = /^[a-zA-Z0-9]*$/g;
		let mid = document.getElementById("inputId").value;
	  	    
	 	if(mid == ""){
	    	document.getElementById("outputId").innerHTML="<font color='red'>아이디를 입력해주세요</font>";
	    	check1 = 0;
	    }
	    else if(!regEx.test(mid)){
	        document.getElementById("outputId").innerHTML="<font color='red'>아이디는 첫글자가 영문자로 와야합니다</font>";
	        check1 = 0;
	    }
	    else if(!regEx1.test(mid)){
	        document.getElementById("outputId").innerHTML="<font color='red'>아이디는 영문자와 숫자로만 가능합니다</font>";
	        check1 = 0;
	    }
	    else if(mid.length < 5){
	        document.getElementById("outputId").innerHTML="<font color='red'>아이디가 너무 짧습니다</font>";
	        check1 = 0;
	    }
	    else if(mid.length > 17){
	        document.getElementById("outputId").innerHTML="<font color='red'>아이디가 너무 깁니다</font>";
	        check1 = 0;
	    }
	    else  {
	    	$.ajax({
	    		type  : "post",	
	    		url : "${ctp}/user/duplicationCheckId",
	    		data  : {mid : mid},
	    		success: function(res) {
					if(res != "1"){
		    			 document.getElementById("outputId").innerHTML="<font color='red'>아이디가 중복되었습니다 다른 아이디를 입력해주세요</font>";
		    			 check1 = 0; 
					}
	    			else {
	    				document.getElementById("outputId").innerHTML="멋진아이디 입니다";
	    				check1 = 1;			
	    			}
	    		},
	    		error : function() {
					alert("오류발생");
	    		}
	    	});
	    }	
	     		    	   
	}
	// 비밀번호 : 특수문자, 영문자, 숫자 한개 이상 포함 8글자 이상
	function regexPwd() {
	    const regEx = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,16}$/g;
	    let pwd = document.getElementById("inputPwd").value;
		let pwd2 = document.getElementById("inputPwd2").value;
	    let cnt = 0;
	
	    if(!regEx.test(pwd)){
	        document.getElementById("outputPwd").innerHTML="<font color='red'>비밀번호는 특수문자, 영문자, 숫자 포함 8글자 이상이 되어야합니다</font>";
	        cnt = 0;
	        check2 = 0;
	    } 
	    else {
	        document.getElementById("outputPwd").innerHTML="멋진 비밀번호입니다";
	        cnt = 1;
	        check2 = 1;
	    }
	    if(cnt==1){
	        if(pwd!=pwd2){
	            document.getElementById("outputPwd2").innerHTML="<font color='red'>비밀번호를 똑같이 입력해주세요</font>";
	            check3 = 0;
	        }
	        else {
	            document.getElementById("outputPwd2").innerHTML="비밀번호 확인 완료.";
	            check3 = 1;
	        }
	    }
	}
	
	// 이름 확인 특수문자 못오게
	function regexName() {
	    const regEx =  /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"0-9a-zA-Z]/g;
	    let name = document.getElementById("inputName").value;
	
	    if(name == ""){
	        document.getElementById("outputName").innerHTML="<font color='red'></font>이름을 입력해주세요";
	        check4 = 0;
	    }
	    
	    else if(regEx.test(name)){
	        document.getElementById("outputName").innerHTML="<font color='red'></font>이름을 다시 확인해주세요";
	        check4 = 0;
	    }
	    else{
	        document.getElementById("outputName").innerHTML="멋진 이름이네요!";
	        check4 = 1;
	    }
	}
	
	function regexNicKName() {
	    const regEx =  /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/g;
	    let nickName = document.getElementById("inputNickName").value;
	   
	    if(nickName == ""){
	        document.getElementById("outputNickName").innerHTML="<font color='red'></font>닉네임을 입력해주세요";
	        check5 = 0;
	    }
	    else if(regEx.test(nickName)){
	        document.getElementById("outputNickName").innerHTML="<font color='red'></font>닉네임은 한글,영문,숫자로 사용하실 수 있습니다";
	        check5 = 0;
	    }
	    else if(nickName.length < 3){
					document.getElementById("outputNickName").innerHTML="<font color='red'></font>닉네임은 2글자 이상으로 사용하실 수 있습니다";
					check5 = 0;
		}
	    else{ 	
	    	$.ajax({
	    		type  : "post",	
	    		url   : "${ctp}/user/duplicationCheckNick",
	    		data  : {nickName : nickName},
	    		success: function(res) {
					if(res != "1"){
	    				document.getElementById("outputNickName").innerHTML="<font color='red'></font>닉네임이 중복되었습니다 다른 닉네임을 입력해주세요";    			
					}
	    			else {
	    				document.getElementById("outputNickName").innerHTML="멋진닉네임!";
					    check5 = 1;   
	    			}
	    		},
	    		error : function() {
	    			alert("오류발생");
	    		}
	    	});
	    }
	}
	
	// 전화번호 '3'-'3,4'-'4' 숫자로만
	function regexTel() {
	    const regEx = /^[0-9]*$/g;
	    let tel = document.getElementById("inputTel").value; 
	      
	    if(tel == ""){
	        document.getElementById("outputTel").innerHTML = "<font color='red'>전화번호를 입력해주세요</font>";
	        check6 = 0;
	    }
	    else if(!regEx.test(tel)){
	        document.getElementById("outputTel").innerHTML = "<font color='red'>'-''제외 숫자만 입력해주세요</font>";
	        check6 = 0;
	    }
	    else if(tel.length < 10){
	        document.getElementById("outputTel").innerHTML = "<font color='red'>전화번호를 다시 확인해주세요</font>";
	        check6 = 0;
	    }
		else{
	        document.getElementById("outputTel").innerHTML= "";
	        check6 = 1;
	    }   
	}
	
	function regexEmail() {
		const regEx = /[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]$/i;
		let email = document.getElementById("inputEmail").value; 
		
	
		if(!regEx.test(email)){
			document.getElementById("outputEmail").innerHTML= "<font color='red'>이메일을 다시 확인해주세요</font>";
			check7 = 0;
		}
		else {
			document.getElementById("outputEmail").innerHTML= "";
			check7 = 1;
		}
	}
	
	 function joinChecking() {	
		/* if(check1 != 1){
			alert("아이디를 다시 확인해주세요");
			document.getElementById("inputId").focus();
			return false;
		}
		else if(check2 != 1){
			alert("비밀번호를 다시 확인해주세요");
			document.getElementById("inputPwd").focus();
			return false;
		}
		else if(check3 != 1){
			alert("비밀번호를 다시 확인해주세요");
			document.getElementById("inputPwd2").focus();
			return false;
		}
		else if(check4 != 1){
			alert("이름을 다시 확인해주세요");
			document.getElementById("inputName").focus();
			return false;
		}
		else if(check5 != 1){
			alert("닉네임을 다시 확인해주세요");
			document.getElementById("inputNickName").focus();
			return false;
		}
		else if(check6 != 1){
			alert("전화번호를 다시 확인해주세요");
			document.getElementById("inputTel").focus();
			return false;
		}
		else if(check7 != 1){
			alert("이메일을 다시 확인해주세요");
			document.getElementById("inputEmail").focus();
			return false;
		}
		else if (document.getElementById("address").value == ""){
			alert("주소를 다시 확인해주세요");
			document.getElementById("address"").focus();
			return false;
		}
		else {*/
			let address = document.getElementById("sample6_postcode").value + "/" + document.getElementById("sample6_address").value + "/" + document.getElementById("sample6_detailAddress").value + "/" + document.getElementById("sample6_extraAddress").value
			document.getElementById("address").value = address;
			loginForm.submit();		
	}
  </script>
</head>
<body>
<p><br/></p>
<div class="w3-border w3-round-large center w3-display-middle w3-margin" style="padding: 30px">
<div class="container">
    <header><h1>회원가입</h1></header>
        <form name="loginForm" class="form-login" method="post" action="${ctp}/user/join">
            <div class="input-list">아이디</div>
            <input id="inputId" name="mid" class="w3-input w3-border w3-round-large" type="text" value="" onkeyup="regexId()" />
            <div id="outputId" class="input-list"></div>
            <div class="input-list">비밀번호</div>
            <input id="inputPwd" name="pwd" class="w3-input w3-border w3-round-large" type="password" maxlength="16" value="" onkeyup="regexPwd()" />
            <div id="outputPwd" class="input-list"></div>
            <div class="input-list">비밀번호 확인</div>
            <input id="inputPwd2" class="w3-input w3-border w3-round-large" type="password" maxlength="16" value="" onkeyup="regexPwd()" />
            <div id="outputPwd2" class="input-list" ></div>
            <div class="input-list" >이름</div>
            <input id="inputName" name="name" class="w3-input w3-border w3-round-large" type="text" value="" onkeyup="regexName()">
            <div id="outputName" class="input-list" ></div>
            <div class="input-list" >닉네임</div>
            <input id="inputNickName" name="nickName" class="w3-input w3-border w3-round-large" type="text" value="" onkeyup="regexNicKName()">
            <div id="outputNickName" class="input-list" ></div>
            <div class="input-list">전화번호</div>
            <input id="inputTel"  name="tel" class="w3-input w3-border w3-round-large" type="text" value="" maxlength="11" onkeyup="regexTel()" />
            <div id="outputTel"></div>
          	<div class="input-list">이메일</div> 
            <input id="inputEmail" name="email" class="w3-input w3-border w3-round-large" type="text" onkeyup="regexEmail()" />
            <div id="outputEmail"></div>
            <div class="form-group">
			  	<label for="address">주소</label>
				<input type="hidden" name="address" id="address">
				<div class="input-group mb-1">
					<input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
					<div class="input-group-append">
						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
					</div>
					<input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
					<div class="input-group mb-1">
						<input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
						<div class="input-group-append">
							<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
						</div>
					</div>
	    		</div>
			</div>
            <input class="w3-button w3-round w3-border w3-ripple w3-blue w3-hover-blue" type="button" value="가입하기" onclick="joinChecking()"/>
        </form>
</div>
</div>
<p><br/></p>
</body>
</html>