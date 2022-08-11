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
</body>
</html>