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
		$.ajax({
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
			
		})
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
	ul{
  	 	list-style:none;
   	}
</style>	
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<div class="w3-container" style="width: 100%; max-height: 3000px; margin-top: 220px">
		<div class="w3-row w3-round-large w3-light-gray w3-center" style="width: 80em;height:20em;margin: auto;padding-top: 2em">
			<img src="${ctp}/images/shop.svg" style="width: 10em">
			<h4 class="w3-margin-top"><span class="w3-block">${uVo.nickName }</span></h4>
			<div class="w3-row w3-margin-top">
				<div class="w3-col m4"> <font color="gray">상점오픈일</font> <b>${uVo.joinday}</b></div>
				<div class="w3-col m4"> <font color="gray">상품판매</font> <b>0</b> 회</div>
				<div class="w3-col m4"> <font color="gray">상점방문수</font> <b>0</b> 회</div>
			</div>
			<div class="w3-right" style="padding-right: 0.5em">
			<a class="w3-tiny" href="${ctp}/user/modifyInfo">계정설정</a>
			<a class="w3-tiny" href="${ctp}/user/userOut"><font color="red">회원탈퇴</font></a>
			</div>
		</div>
	</div>
	<div class="w3-container" style="width: 100%; max-height: 3000px; margin-top: 50px">
		<div class="w3-row w3-round-large w3-center" style="width: 80em;height:5em;margin: auto;padding: 1em">
		<ul class="nav nav-tabs" role="tablist">
			<li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#myProduct">내 상품</a></li>
		   	<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#myLikes">찜한 상품</a></li>
		   	<li class="nav-item"><a class="nav-link" data-toggle="tab" href="#following">팔로잉</a></li>
		</ul>
		</div>
		<div class="tab-content" style="width: 73em;margin: auto">
		<div id="myProduct" class="container tab-pane active"><br>
			<div class="w3-container">
				<h2>내가올린 상품</h2>
				<hr>
				<div class="list con">
			    	<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
					<c:forEach var="vo" items="${vos}">
						<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
							<ul style="padding-left:4.5em">
						    	<c:forEach var="fSName" items="${fSNames}" varStatus="st">
									<li class="cell w3-margin-right w3-padding-top" style="cursor:pointer" onclick="location.href='${ctp}/product/content?idx=${vo.idx}';">
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
		<div id="myLikes" class="container tab-pane fade"><br>
			<div class="w3-container">
				<h2>찜한 상품</h2>
				<hr>
				<div class="list con">
			    	<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
					<c:forEach var="vo" items="${vos2}">
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
		<div id="follower" class="container tab-pane fade"><br>  
		</div>
		<div id="follower" class="container tab-pane fade"><br>  
		</div>
	</div>
	</div>
	 <!-- Tab panes -->
	
</body>
</html>