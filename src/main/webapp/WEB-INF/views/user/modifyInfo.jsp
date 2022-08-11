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
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="${ctp}/resources/js/address.js"></script>
	<script>
	'use strict'
	let check1 = 0;
	let check2 = 0;
	let check3 = 0;
	let check4 = 0;
	let check5 = 0;
	let check6 = 0;
	let check7 = 0;
	let check8 = 0;

	
	// 비밀번호 : 특수문자, 영문자, 숫자 한개 이상 포함 8글자 이상
	function regexPwd() {
	    const regEx = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,16}$/g;
	    let pwd = document.getElementById("inputPwd").value;
		let pwd2 = document.getElementById("inputPwd2").value;
	    let cnt = 0;
		if(check8 == 0){
			let ans = confirm("정말로 수정하시겠습니까?")
			if(ans != 1){
				return false;
			}
			check8 = 1;
			document.getElementById("inputPwd").value = "";
			$('#pwdCover').show();
		}
	    
	    
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
	    let oriNickName = document.getElementById("originalNickName").value;
	  
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
					if(res != "1" && oriNickName != nickName){
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

 	function modifyInfo() {	
    	let oriName = document.getElementById("originalName").value;
	    let oriNickName = document.getElementById("originalNickName").value;
	    let oriTel = document.getElementById("originalTel").value;
	    let oriEmail = document.getElementById("originalEmail").value; 
	    
	    let mid = document.getElementById("inputId").value;
		let pwd = document.getElementById("inputPwd").value;
	    let name = document.getElementById("inputName").value;
	    let nickName = document.getElementById("inputNickName").value;
 		let tel = document.getElementById("inputTel").value; 
 		let email = document.getElementById("inputEmail").value; 
 		let photo = document.getElementById("inputPhoto").value;
		let content = document.getElementById("inputContent").value;
		let address = document.getElementById("sample6_postcode").value + "/" + document.getElementById("sample6_address").value + "/" + document.getElementById("sample6_detailAddress").value + "/" + document.getElementById("sample6_extraAddress").value;
		
		if(pwd == "********"){
			check2 = 1;
			check3 = 1;
		}
		if(name == oriName) check4 = 1;
		if(nickName == oriNickName) check5 = 1;
		if(tel == oriTel) check6 = 1;
		if(email == oriEmail) check7 = 1;
			
		if(check2 != 1){
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
		else if (document.getElementById("sample6_postcode").value == "" || document.getElementById("sample6_address").value == "" || document.getElementById("sample6_detailAddress").value == ""){
			alert("주소를 다시 확인해주세요"); 
			return false;
		}
		else {
			$.ajax({
				type : "post",
				url : "${ctp}/user/modifyInfo",
				data : {
					mid : mid,
					pwd : pwd,
					name : name,
					nickName : nickName,
					tel : tel,
					email : email,
					address : address,
					photo : photo,
					content : content
				},
				success : function(data){
					alert("수정완료");
					location.reload();
				},
				error : function() {
					alert("오류발생");
				}
			});
		}
	}  
 	
	function thumbNailImage(input) {
        if (input.files && input.files[0]) {
           var reader = new FileReader();
           reader.onload = function (e) {
              $('#thumbNailImageShow').attr('src', e.target.result);
           }                
           reader.readAsDataURL(input.files[0]);
        }
     }
	
	function accountModal(){
		$("#id02").css('display','block');
		let data = '<button type="button" onclick="account()">제출</button>';
		$("#m2").html(data);
	}
	
	function closeModal(){
		 $("#id02").css('display','none');			
	}
	
	function account() {
		let accountNumber = document.getElementById("accountNumber").value; 
		let bank = document.getElementById("bank").value; 
		
		$.ajax({
			type : "post",
			url : "${ctp}/user/account",
			data : {
				accountNumber : accountNumber,
				bank : bank			
			},
			success : function(data){
				alert("계좌등록 완료");
				location.reload();
			},
			error : function() {
				alert("오류발생");
			}
		});
	} 
	
	</script>
</head>
<body>
	<form method="post" enctype="multipart/form-data">
		<c:set var="vo" value="${vo}" />
		    <div class="input-list">아이디</div>
   			<input id="inputId" name="" type="text" value="${vo.mid}" readonly>
            <div class="input-list">비밀번호</div>
            <input id="inputPwd" name="pwd" class="input-list" type="password" maxlength="16" value="********" onkeyup="regexPwd()" />
            <div id="outputPwd" class="input-list"></div>
            <div id="pwdCover" style="display:none">
	            <div class="input-list">비밀번호 확인</div>
	            <input id="inputPwd2" class="input-list" type="password" maxlength="16" value="" onkeyup="regexPwd()" />
	            <div id="outputPwd2" class="input-list" ></div>
            </div>
            <div class="input-list" >이름</div>
            <input id="inputName" name="name" class="input-list" type="text" value="${vo.name}" onkeyup="regexName()">
            <div id="outputName" class="input-list" ></div>
            <div class="input-list" >닉네임</div>
            <input id="inputNickName" name="nickName" class="input-list" type="text" value="${vo.nickName}" onkeyup="regexNicKName()">
            <div id="outputNickName" class="input-list" ></div>
            <div class="input-list">전화번호</div>
            <input id="inputTel"  name="tel" class="input-list" type="text" value="${vo.tel}" maxlength="11" onkeyup="regexTel()" />
            <div id="outputTel"></div>
          	<div class="input-list">이메일</div> 
            <input id="inputEmail" name="email" class="input-list" type="text" value="${vo.email}" onkeyup="regexEmail()" />
            <div id="outputEmail"></div>
            <div class="form-group">
			<label for="address">주소</label>
				<input type="hidden" name="address" id="address">
				<div class="input-group mb-1">
					<input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control" value="${address[0]}">
					<div class="input-group-append">
						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
					</div>
					<input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1" value="${address[1]}">
					<div class="input-group mb-1">
						<input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control" value="${address[2]}"> &nbsp;&nbsp;
						<div class="input-group-append">
							<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control" value="${address[3]}">
						</div>
					</div>
	    		</div>
	    	</div>
	    	<div class="input-list">사진</div>	
			<label for=file class="w3-button w3-white w3-border w3-round-xlarge" style="font-size:15;margin:15 auto;width:100%">사진등록</label>
        	<input type="file" id="file" name="file" onchange="thumbNailImage(this)" style="display:none" accept=".jpg,.gif,.png,.jpeg" required/>
        	<div>                 
        		<img id="thumbNailImageShow" style="height:12em;width:12em;border-radius:15px">
        	</div>
			<div class="img-box"><img src="${ctp}/pds/${fSName}" alt=""></div>
			<div class="input-list">자기소개</div>	
<!-- 			<div class="input-list">이메일</div>
			<div class="input-list">은행</div>
			<select id="bank" name="bank">
				<option>은행을 선택해주세요</option>
				<option value="신한">신한</option>
				<option value="농협">농협</option>
				<option value="국민">국민</option>
				<option value="신협">신협</option>
				<option value="기업">기업</option>
			</select>  -->
			<button onclick="accountModal()" class="w3-button w3-black">계좌등록</button>
			<div id="id02" class="w3-modal" style="text-align:center;">
			    	<div class="w3-modal-content" style="height:15em; width:30em;">
			        	<div class="w3-container" >
			            	<span  onclick="closeModal(2)" class="w3-button w3-display-topright">&times;</span>
				           	<h4>계좌등록</h4>
				           	<select id="bank">
				           		<option>은행을 선택해주세요</option>
				           		<option value="신한">신한</option>
				           		<option value="농협">농협</option>
				           		<option value="신협">신협</option>
				           		<option value="국민">국민</option>
				           		<option value="기업은행">기업은행</option>
				           		<option value="카카오">카카오</option>
				           		<option value="토스">토스</option>
				           	</select>				     			           	
				           	<div>계정에 등록된 이름과 같은 이름의 계좌를 <br/> '-'를 제외하고 입력해주세요</div>
				           	<input id="accountNumber" class="w3-border" type="text" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" >
           					<div id="m2"></div>
			        	</div>
			     	</div>
			  	</div> 
			<input id="inputContent" type="text" value="${vo.content}" >
			<input type="hidden" id="originalPwd" value="${vo.pwd}"/>
			<input type="hidden" id="originalName" value="${vo.name}"/>
			<input type="hidden" id="originalNickName" value="${vo.nickName}"/>
			<input type="hidden" id="originalTel" value="${vo.tel}"/>
			<input type="hidden" id="originalEmail" value="${vo.email}"/>
		<input type="button" value="수정하기" onclick="modifyInfo()">
		<input type="button" value="test" onclick="test1()">
	</form>
</body>
</html>