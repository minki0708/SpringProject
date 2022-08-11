<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath }" />
<html>
<head>
<title></title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js" ></script>
<script src="${ctp}/resources/js/address.js"></script>	  
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<style>
/*   .totSubBox {
    background-color:#ddd;
    border : none;
    width : 95px;
    text-align : center;
    font-weight: bold;
    padding : 5 0px;
    color : brown;
  }
  
  td {
    padding : 5px;
  } */
</style>
<script>
    'use strict';    

    function numberWithCommas(x) {
      return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
    
    function deliverySelector() {
    	let ds = document.getElementById("deliverySelector").value;
    	if(ds == "직접입력"){
    		detailRequire.style.display= "block";
    	}
    }
    
    function order() {
    	let inputName = document.getElementById("inputName").value;
    	let inputTel = document.getElementById("inputTel").value;
    	let address = document.getElementById("sample6_postcode").value;
    	
    	if(inputName == ""){
			alert("이름을 입력해주세요");
			document.getElementById("inputName").focus();
			return false;
		}
		else if(inputTel == ""){
			alert("전화번호를 입력해주세요");
			document.getElementById("inputTel").focus();
			return false;
		}
		else if(address == ""){
			alert("주소를 입력해주세요");
			document.getElementById("inputTel").focus();
			return false;
		}
    	address = document.getElementById("sample6_address").value + "/" + document.getElementById("sample6_detailAddress").value + "/" + document.getElementById("sample6_extraAddress").value
		document.getElementById("address").value = address;
    	orderForm.submit();
    }
</script> 
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<div class="w3-container" style="width: 100%;max-height: 7000px;margin-top: 300px">
		<div class="w3-container" style="width: 1400px;margin: auto;margin-bottom: 100px">
		<c:set var="fSNames" value="${fn:split(pVo.FSName,'/')}"/>
		<div style="width: 800px;margin: auto">
			<h5>구매 상품 정보</h5>
			<hr style="border-width: 2px;border-color: black">		
		</div>
		<div class="w3-row w3-border w3-padding" style="width: 800px;margin: auto">
			<div class="w3-col m3">
				<img src="${ctp}/pds/${fSNames[0]}" style="height:10em; width:10em"/>			
			</div>
			<div class="w3-col m6 w3-border-right">
			<h5><b><input type="text" value="${pVo.title}" readonly /></b></h5><br><br><br>
			<span class="w3-small"><font color="gray">상품상태</font> <b>${pVo.state }</b></span><br>
			<span class="w3-small"><font color="gray">교환여부</font> <b>${pVo.exchange }</b></span>
			</div>
			<div class="w3-col m3">
			<h6 style="text-align: center;margin-top: 30%"><b><fmt:formatNumber value="${pVo.price}" pattern="#,###"/>원</b></h6>			
			</div>
		</div>
		<form name="orderForm" method="post" action="${ctp}/order/paymentOk">
		<div class="w3-row" style="width: 800px;margin: auto;margin-top: 30px">
			<div class="w3-col m8" style="padding-right: 15px">
			<h5>배송 정보</h5>
			<hr style="border-width: 2px;border-color: black">
			<div class="w3-row w3-margin-bottom">
				<div class="w3-col m2" style="padding-top: 8px">
					<font color="gray">수령인</font>
				</div>
				<div class="w3-col m10">
            		<input id="inputName" name="name" class="w3-input w3-border w3-round-large" type="text" value="${uVo.name}" style="width: 40%;padding-top: 2px">
				</div>
			</div>
			<div class="w3-row w3-margin-bottom" >
				<div class="w3-col m2" style="padding-top: 8px">
				<font color="gray">연락처</font>
				</div>
				<div class="w3-col m10">
	           		<input id="inputTel"  name="tel" class="w3-input w3-border w3-round-large" type="text" value="${uVo.tel}" maxlength="11" style="width: 40%;padding-top: 2px"/>
				</div>
			</div>
			<div class="w3-row" style="margin-bottom: 50px">
				<div class="w3-col m2" style="padding-top: 8px">
					<font color="gray">이메일</font>
				</div>
				<div class="w3-col m10">
					<input id="email" name="email" class="w3-input w3-border w3-round-large" type="text" value="" style="width: 40%;padding-top: 2px" required/>	
				</div>
			</div>
			<div class="w3-row w3-margin-bottom">
				<div class="w3-col m12" style="padding-top: 8px">
					<font color="gray">배송 주소</font>
					<input type="hidden" name="address" id="address">
				</div>
				<div class="w3-col m6">
					<input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="w3-input w3-border w3-round-large" value="${address[0]}" style="">			
				</div>
				<div class="w3-col m6">
					<a class="w3-button w3-dark-gray w3-ripple w3-round" href="javascript:sample6_execDaumPostcode()" style="margin-top: 9px;margin-left: 5px">우편번호 찾기</a>		
				</div>
				<div class="w3-col m12">
				<input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="w3-input w3-border w3-round-large" value="${address[1]}">				
				</div>
				<div class="w3-col m8">
					<input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="w3-input w3-border w3-round-large" value="${address[2]}" style="width: 95%">
				</div>
				<div class="w3-col m4">
						<input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="w3-input w3-border w3-round-large" value="${address[3]}">
				</div>
			</div>
			<div class="w3-row w3-margin-bottom">
				<div class="w3-col m12" style="padding-top: 8px">
					<font color="gray">배송 요청사항 (선택)</font>
				</div>
				<div class="w3-col m12">
					<select id="detailRequire" name="deliveryRequire" class="w3-select w3-border w3-round-large">
						<option value="">배송 요청사항을 선택해주세요</option>
						<option value="부재시 소화전에 넣어주세요">부재시 소화전에 넣어주세요</option>
						<option value="부재시 경비실에 맡겨주세요">부재시 경비실에 맡겨주세요</option>
						<option value="문앞에 놓아주세요">문앞에 놓아주세요</option>
						<option value="배송전 연락주세요">배송전 연락주세요</option>
					</select>				
				</div>
			</div>
		</div>
		<div class="w3-col m4">
		<h5>결제 정보</h5>
		<hr style="border-width: 2px;border-color: black">
		<h6>거래가격</h6>
        <h1 style="text-align: left"><b><fmt:formatNumber value="${pVo.price}" pattern="#,###"/>원</b></h1>
	  	<a href="javascript:order()" class="w3-button w3-blue w3-hover-blue w3-ripple w3-round-large" style="width: 265px;margin-top: 30px">결제하기</a>	
        <input type="hidden" id="price" name="price"  value="${pVo.price}">
	  	<input type="hidden" name="productIdx" value="${pVo.idx}"/> 	
	  	<input type="hidden" name="buyerIdx" value="${sIdx}"/>
	  	<input type="hidden" name="productName" value="${pVo.title}"/>
		</div>
		</div>
  	</form>
		
		
		</div>
	</div>
	<%-- <a href="${ctp}/product/content?idx=${pVo.idx}">돌아가기</a>
	<h3>배송지</h3>

	<form name="orderForm" method="post" action="${ctp}/order/paymentOk">
		<div class="form-group">
			<div class="input-list" >이름</div>
            <input id="inputName" name="name" class="input-list" type="text" value="${uVo.name}">
			<div class="input-list">연락처</div>
            <input id="inputTel"  name="tel" class="input-list" type="text" value="${uVo.tel}" maxlength="11"/>
			<label for="address">배송주소</label>
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
		<label for="email">이메일</label>
        <input id="email" name="email" class="input-list" type="text" value="" />
		<label>배송 요청사항 (선택)</label>
		<input id="detailRequire" name="deliveryRequire" type="text" placeholder="배송 요청사항을 입력해주세요">
	  	<h3>결제금액</h3>
        <input id="price" name="price" class="input-list" type="text" value="${pVo.price}" readonly/>
	  	<input type="button" class="btn btn-primary" onclick="order()" value="결제하기"/> 	
	  	<input type="hidden" name="productIdx" value="${pVo.idx}"/> 	
	  	<input type="hidden" name="buyerIdx" value="${sIdx}"/> 	
  	</form>
   --%>
</body>
</html>