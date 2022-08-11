<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adContent</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
<style>
body,
ul,
li {
    list-style: none;
    padding: 0;
    margin: 0.2em;
}
a {
    text-decoration: none;
    color: inherit;
}
/*라이브러리*/
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
/*커스텀*/
html,
body {
    overflow-x: hidden;
}
.con {
    max-width: 1200px;
}
.logo-bar {
    text-align: center;
    margin-bottom: 20px;
    margin-top: 20px;
}

.bn-box {
    margin-bottom: 20px;
    margin-top: 20px;
}
@media ( max-width:800px ) {
    .top-bn-box-1 {
        overflow-x:hidden;
    }

/*     .top-bn-box-1 > .img-box {
        margin-left:-50%;
    } */
}

.menu-box {
    margin-bottom: 20px;
    margin-top: 20px;
}
.menu-box > ul > li {
    width: calc(100% / 7);
}
@media (max-width: 900px) {
    .menu-box {
        display: none;
    }
}

.menu-box > ul > li > a {
    display: block;
    text-align: center;
    font-weight: bold;
    position: relative;
}
.menu-box > ul > li:hover > a {
    color: red;
    text-decoration: underline;
}
.menu-box > ul > li > a::before,
.menu-box > ul > li > a::after {
    content: "";
    width: 1px;
    height: 13px;
    background-color: black;
    position: absolute;
    top: 50%;
    transform: translatey(-50%);
    left: 0;
}
.menu-box > ul > li > a::after {
    left: auto;
    right: 0;
}
.menu-box > ul > li:first-child > a::before,
.menu-box > ul > li:last-child > a::after {
    width: 2px;
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

.list > ul > li > .product-name {
    text-align: Center;
    font-weight: bold;
}
.list > ul > li:hover > .product-name {
    text-decoration: underline;
}
.list > ul > li > .product-price {
    text-align: center;
    font-weight: bold;
    font-size: 1.5rem;
}
.list > ul > li > .product-price::after {
    content: "원";
    font-size: 1rem;
    font-weight:normal;
}


@media (max-width: 800px) {
    .list > ul > li {
        width: calc(100% / 5);
    }
}

@media (max-width: 650px) {
    .list > ul > li {
        width: calc(100% / 4);
    }
}

@media (max-width: 500px) {
    .list > ul > li {
        width: calc(100% / 3);
    }
}

@media (max-width: 400px) {
    .list > ul > li {
        width: calc(100% / 2);
    }
}

@media (max-width: 300px) {
    .list > ul > li {
        width: calc(100% / 1);
    }
}

.product-price{
	display : flex;
}

.product {
	display : flex;
}

h2 {
	text-align: center;
}
</style>
<script>
	'use strict';
	function delectCheck(idx) {
		let ans = confirm("삭제하시게되면 다시 복구하실 수 없습니다 \n정말로 삭제하겠습니까?");

		if(ans == -1){
			return false;
		}
		else {
			$.ajax({
				type : "post",
				url : "${ctp}/admin/productDelete",
				data : {
					idx : idx,
				},
				async : false,
				success : function(res) {
					alert("삭제 완료");
					location.reload();
				},
				error : function() {
					alert("삭제실패");	
				}
			});
		}
	};
	
	function returnProduct(idx){
		let ans = confirm("정말로 되돌리시겠습니까?");

		if(ans == -1){
			return false;
		}
		else {
			$.ajax({
				type : "post",
				url : "${ctp}/admin/productReturn",
				data : {
					idx : idx,
				},
				async : false,
				success : function(res) {
					location.reload();
				},
				error : function() {
					alert("삭제실패");	
				}
			});
		}
	}
</script>

</head>
<body>
<div class="container">
	<div class="w3-container" style="width: 100%;max-height: 3000px;margin-top: 50px">
		<div class="w3-container" style="width: 1200px;margin: auto">
			<h2>블럭처리된 상품</h2>
			<hr>
			<div class="list con">
		    	<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
				<c:forEach var="vo" items="${vos}">
					<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
						<ul style="padding-left:4.5em">
<%-- 				       페이지네이션 <a href="${ctp}/product/content?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}"> 
--%>					    <c:forEach var="fSName" items="${fSNames}" varStatus="st">
							<li class="cell w3-border w3-margin-right">
								<div class="w3-border-bottom w3-center-align">
					            <c:set var="bdate" value="${fn:substring(vo.BDate,0,10)}"/>
					             ${bdate}
								</div>					             
							    <div style="cursor:pointer" onclick="location.href='${ctp}/product/content?idx=${vo.idx}';">
							    <c:set var="fSNameLen" value="${fn:length(fSName)}"/>
							  	<c:set var="ext" value="${fn:substring(fSName,fSNameLen-3,fSNameLen)}"/>
							  	<c:set var="extUpper" value="${fn:toUpperCase(ext)}"/>
							  	<c:if test="${extUpper=='JPG' || extUpper=='GIF' || extUpper=='PNG'}">
					            	<div class="img-box" style="padding-top: 10px"><img src="${ctp}/pds/${fSName}" alt=""></div>
							  	</c:if>
					            <div class="product-name">제목 : ${vo.title}</div>
					            <div class="product-price"><fmt:formatNumber value="${vo.price}" pattern="#,###"/>원</div>
					            <div class="product">블럭사유 : ${vo.BContent}</div>
							    </div>
					            <c:if test="${sAuthority == 0}">
					            <div class="w3-col m6">
					            <a href="javasciprt:delectCheck(${vo.idx})" class="w3-button w3-round w3-small w3-border w3-border-red">삭제하기</a>
					            </div>
					            <div class="w3-col m6">
					            <a href="javasciprt:returnProduct(${vo.idx})" class="w3-button w3-round w3-small w3-border w3-border-blue">되돌리기</a>
					            </div>
					            </c:if>
				        	</li>
					        </c:forEach>		    
		            	</ul>
			    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
				</c:forEach>
  			</div>
		</div>
	</div>
	</div>
</body>
</html>