<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>main</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
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
</style>
</head>
<body>
	<div class="w3-left" >	
	</div>
	<div class="w3-container w3-border" style="width: 100%;max-height: 3000px;margin-top: 300px">
		<div class="w3-container w3-border" style="width: 1200px;margin: auto">
			<h2>오늘의 상품</h2>
			<hr>
			<div class="list con">
		    	<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
				<c:forEach var="vo" items="${vos}">
					<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
						<ul style="padding-left:4.5em">
<%-- 				       페이지네이션 <a href="${ctp}/product/content?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}"> 
--%>					    <c:forEach var="fSName" items="${fSNames}" varStatus="st">
							<li class="cell w3-border w3-margin-right w3-padding-top" style="cursor:pointer" onclick="location.href='${ctp}/product/content?idx=${vo.idx}';">
							    <c:set var="fSNameLen" value="${fn:length(fSName)}"/>
							  	<c:set var="ext" value="${fn:substring(fSName,fSNameLen-3,fSNameLen)}"/>
							  	<c:set var="extUpper" value="${fn:toUpperCase(ext)}"/>
							  	<c:if test="${extUpper=='JPG' || extUpper=='GIF' || extUpper=='PNG'}">
					            	<div class="img-box"><img src="${ctp}/pds/${fSName}" alt=""></div>
							  	</c:if>
					            <div class="product-name">${vo.title}</div>
					            <div class="product-price"><fmt:formatNumber value="${vo.price}" pattern="#,###"/></div>
					            <div class="product">${vo.date}</div>
				        	</li>
					        </c:forEach>		    
		            	</ul>
			    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
				</c:forEach>
  			</div>
		</div>
	</div>
<%-- 	<table class="table table-hover table-striped text-center">
		<div class="list con">
    	<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
		<c:forEach var="vo" items="${vos}">
			<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
				<ul>
		       페이지네이션 <a href="${ctp}/product/content?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}"> 
			        <c:forEach var="fSName" items="${fSNames}" varStatus="st">
						<li class="cell" style="cursor:pointer" onclick="location.href='${ctp}/product/content?idx=${vo.idx}';">
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
	</table>
<div class="text-center">
  <ul class="pagination justify-content-center">
	  <c:if test="${pageVO.pag > 1}">
	    <li class="page-item"><a href="${ctp}/main?pag=1&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◁◁</a></li>
	  </c:if>
	  <c:if test="${pageVO.curBlock > 0}">
	    <li class="page-item"><a href="${ctp}/main?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">◀</a></li>
	  </c:if>
	  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
	    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}">
	      <li class="page-item active"><a href="${ctp}/main?pag=${i}&pageSize=${pageVO.pageSize}" class="page-link text-light bg-secondary border-secondary">${i}</a></li>
	    </c:if>
	    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}">
	      <li class="page-item"><a href='${ctp}/main?pag=${i}&pageSize=${pageVO.pageSize}' class="page-link text-secondary">${i}</a></li>
	    </c:if>
	  </c:forEach>
	  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
	    <li class="page-item"><a href="${ctp}/main?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▶</a></li>
	  </c:if>
	  <c:if test="${pageVO.pag != pageVO.totPage}">
	    <li class="page-item"><a href="main?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}" class="page-link text-secondary">▷▷</a></li>
	  </c:if>
  </ul>
</div>
<p><br/></p> --%>
</body>
</html>