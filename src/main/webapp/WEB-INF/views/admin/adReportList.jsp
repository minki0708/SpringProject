<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adContent</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
<style>
	img {
		width : 10em;
		height : 10em;
`	}
</style>
<script>
	function submit(idx,count){
		let status = document.getElementById('reportStatus').value;
		if(status =='확인전'){
			alert("신고사항을 확인후 선택해주세요");
			return false;
		};
		
		$.ajax({
			url : "${ctp}/admin/reportProduct",
			type : "post",
			data : {
				idx : idx,
				status : status
			},
			async : false,
			success : function(res) {	
				location.reload();
			},
			error : function(){
				alert("오류 발생 ");					
			}	
		});
	}
	
	function submit2(idx,count){
		let status = document.getElementById('reportStatus2'+count).value;
		if(status =='확인전'){
			alert("신고사항을 확인후 선택해주세요");
			return false;
		};
		
		$.ajax({
			url : "${ctp}/admin/reportReply",
			type : "post",
			data : {
				idx : idx,
				status : status
			},
			async : false,
			success : function(res) {	
				location.reload();
			},
			error : function(){
				alert("오류 발생 ");					
			}	
		});
	} 
	
	
</script>
</head>
<body>
<p><br/></p>
	<h3>신고 관리</h3>
	<a href="${ctp}/admin/adReportList?type=상품">상품신고내역</a>
	<a href="${ctp}/admin/adReportList?type=댓글">댓글신고내역</a>

<c:if test="${type == '상품'}">
  	<table class="w3-table">
		<tr class="w3-light-gray w3-border">
			  <th>상품</th>
			  <th>상품명</th>
			  <th>신고자</th>
			  <th>신고받은 아이디</th>
			  <th>신고유형</th>
			  <th>신고내용</th>
			  <th>신고일자</th>
			  <th>상태</th>
	  	</tr>
	  		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td>
					<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
		 			<c:forEach var="fSName" items="${fSNames}" varStatus="st">
					    <div style="cursor:pointer" onclick="location.href='${ctp}/product/content?idx=${vo.productIdx}&&mode=admin';">
					    <c:set var="fSNameLen" value="${fn:length(fSName)}"/>
					  	<c:set var="ext" value="${fn:substring(fSName,fSNameLen-3,fSNameLen)}"/>
					  	<c:set var="extUpper" value="${fn:toUpperCase(ext)}"/>
						  	<c:if test="${extUpper=='JPG' || extUpper=='GIF' || extUpper=='PNG'}">		 
				            	<div class="img-box">
				            		<img src="${ctp}/pds/${fSName}" >
				            	</div>
						  	</c:if>
					  	</div>
				  	</c:forEach>
				</td>
				<td>
					<div style="cursor:pointer" onclick="location.href='${ctp}/product/content?idx=${vo.productIdx}&&mode=admin';">${vo.title}</div>
				</td>
				<td>${vo.reporterMid}</td>
				<td>${vo.reportedMid}</td>
				<td>${vo.reportType}</td>
				<td>${vo.detail}</td>
				<td>${vo.RDate}</td>
				<td>
					<select id="reportStatus${st.count}">
						<option value="확인전" selected>확인전</option>
						<option value="문제없음">문제없음</option>
						<option value="삭제">삭제</option>
					</select>
				</td>
				<td>
					<input type="hidden" value="${st.count}" id='${st.count}'>
					<button type="button" onclick="submit(${vo.productIdx},${st.count})">제출</button>
				</td>
			</tr>
		  </c:forEach>
	</table>
</c:if>
<c:if test="${type == '댓글'}">
  	<table class="w3-table" >
		<tr class="w3-light-gray w3-border">
			  <th>상품</th>
			  <th>상품명</th>
			  <th>신고받은 댓글 내용</th>
			  <th>신고받은 아이디</th>
			  <th>신고자</th>
			  <th>신고유형</th>
			  <th>신고내용</th>
			  <th>신고일자</th>
			  <th>상태</th>
	  	</tr>
	  		<c:forEach var="vo" items="${vos}" varStatus="st">
			<tr>
				<td>
					<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
		 			<c:forEach var="fSName" items="${fSNames}" varStatus="st">
					    <div style="cursor:pointer" onclick="location.href='${ctp}/product/content?idx=${vo.productIdx}&&mode=admin';">
					    <c:set var="fSNameLen" value="${fn:length(fSName)}"/>
					  	<c:set var="ext" value="${fn:substring(fSName,fSNameLen-3,fSNameLen)}"/>
					  	<c:set var="extUpper" value="${fn:toUpperCase(ext)}"/>
						  	<c:if test="${extUpper=='JPG' || extUpper=='GIF' || extUpper=='PNG'}">		 
				            	<div class="img-box">
				            		<img src="${ctp}/pds/${fSName}" >
				            	</div>
						  	</c:if>
					  	</div>
				  	</c:forEach>
				</td>
				<td>
					<div style="cursor:pointer" onclick="location.href='${ctp}/product/content?idx=${vo.productIdx}&&mode=admin';">${vo.title}</div>
				</td>
				<td>
					${vo.content}
				</td>
				<td>
					<div style="cursor:pointer" onclick="location.href='${ctp}/product/content?idx=${vo.productIdx}&&mode=admin';">${vo.title}</div>
				</td>
				<td>${vo.reporterMid}</td>
				<td>${vo.reportedMid}</td>
				<td>${vo.reportType}</td>
				<td>${vo.detail}</td>
				<td>${vo.RDate}</td>
				<td>
					<select id="reportStatus2${st.index}">
						<option value="확인전" selected>확인전</option>
						<option value="문제없음">문제없음</option>
						<option value="삭제">삭제</option>
					</select>
				</td>
				<td>
					<button type="button" onclick="submit2(${vo.replyIdx},${st.index})">제출</button>
				</td>
			</tr>
		  </c:forEach>
	</table>
</c:if>
</body>
</html>