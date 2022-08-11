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
	$(document).ready(function(){
		$(".nav-tabs a").click(function(){
	    	$(this).tab('show');
	    });
		$('.nav-tabs a').on('shown.bs.tab', function(event){
		    var x = $(event.target).text();         // active tab
		    var y = $(event.relatedTarget).text();  // previous tab
		});
	});

	'use strict';
	function deleteContent() {
		let ans = confirm("정말로 삭제하시겠습니까")
		if(ans = -1) return false;
		$.ajax(){
			url : "${ctp}/user/deleteContent",
			type : "post",
			data : {idx : idx},
			async : false,
			success : function(res) {
				if(res == "1"){
					alert("삭제 되었습니다");
				}
			},
			error : function(){
					alert("오류 발생 ");					
			}
			
		}
	}
	
</script>
<style>
	.con {
    margin-left: auto;
    margin-right: auto;
	}
	
	.cell {
		float: left;
	    box-sizing: border-box;
	    margin-bottom: 20px;
	}
	.row::after {
	    content: "";
	    display: block;
	    clear: both;
	}
	.img-box > img {
	    display: block;
	    width: 11em;
	    height: 11em;
	}
	.list > ul > li {
    	width: calc(100% / 6);
	}
	
	.list > ul > li {
	    padding: 0 10px;
	}
	.list > ul {
	    margin: 0 -10px;
	}
</style>	
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<a href="${ctp}/user/myLikes">찜한상품</a>
	<a href="${ctp}/user/modifyInfo">계정설정</a>
	<div class="w3-container w3-border" style="width: 100%;max-height: 3000px;margin-top: 300px">
		<div class="w3-container w3-border" style="width: 1200px;margin: auto">
			<h2>내가올린 상품</h2>
			<hr>
			<div class="list con">
		    	<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
				<c:forEach var="vo" items="${vos}">
					<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
						<ul style="padding-left:4.5em">
					    <c:forEach var="fSName" items="${fSNames}" varStatus="st">
							<li class="cell w3-border w3-margin-right w3-padding-top" style="cursor:pointer" onclick="location.href='${ctp}/product/content?idx=${vo.idx}';">
							    <c:set var="fSNameLen" value="${fn:length(fSName)}"/>
							  	<c:set var="ext" value="${fn:substring(fSName,fSNameLen-3,fSNameLen)}"/>
							  	<c:set var="extUpper" value="${fn:toUpperCase(ext)}"/>
							  	<c:if test="${extUpper=='JPG' || extUpper=='GIF' || extUpper=='PNG'}">
					            	<div class="img-box"><img src="${ctp}/pds/${fSName}" alt=""></div>
							  	</c:if>
					            <div class="product-name">${vo.title}</div>
					            <div class="product-price">${vo.price}</div>
					            <div class="product">${vo.date}</div>
				        	</li>
					        </c:forEach>		    
		            	</ul>
			    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
				</c:forEach>
  			</div>
		</div>
	</div>
	<!-- Nav tabs -->
	<ul class="nav nav-tabs" role="tablist">
		<li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#card">카드결재</a></li>
	   	<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#bank">은행결재</a></li>
	   	<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#telCheck">상담사연결</a></li>
	</ul>
	
	 <!-- Tab panes -->
	<div class="tab-content">
		<div id="card" class="container tab-pane active"><br>
	    <h3>카드결재</h3>
	    <p>
	    	<select name="paymentCard" id="paymentCard">
		        <option value="">카드선택</option>
		        <option value="국민">국민</option>
		        <option value="현대">현대</option>
		        <option value="신한">신한</option>
		        <option value="농협">농협</option>
		        <option value="BC">BC</option>
		        <option value="롯데">롯데</option>
		        <option value="삼성">삼성</option>
		        <option value="LG">LG</option>
	      	</select>
	    </p>
		<p>카드번호 : <input type="text" name="payMethodCard" id="payMethodCard"/></p>
		</div>
		<div id="bank" class="container tab-pane fade"><br>
			<h3>은행결재</h3>
		    <p>
		        <select name="paymentBank" id="paymentBank">
			        <option value="">은행선택</option>
			        <option value="국민">국민(111-111-111)</option>
			        <option value="신한">신한(222-222-222)</option>
			        <option value="우리">우리(333-333-333)</option>
			        <option value="농협">농협(444-444-444)</option>
			        <option value="신협">신협(555-555-555)</option>
		      	</select>
		    </p>
			<p>입금자명 : <input type="text" name="payMethodBank" id="payMethodBank"/></p>
		</div>
		<div id="telCheck" class="container tab-pane fade"><br>
		    <h3>전화상담</h3>
		    <p>콜센터(☎) : 02-1234-1234</p>
		</div>
	</div>
</body>
</html>