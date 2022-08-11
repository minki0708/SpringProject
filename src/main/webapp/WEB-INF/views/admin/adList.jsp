<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>adLeft.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script>
    function logoutCheck() {
    	parent.location.href = "${ctp}/member/memLogout";
    }
  </script>
  <style>
    body {background-color: #ddd}
  </style>
</head>
<body>
<br/>
<div class="container text-center" style="font-size:12px;">
  <h6><a href="${ctp}/admin/adContent" target="adContent">관리자 홈</a></h6>
  <hr/>
  <p><a href="${ctp}/admin/adUserManage" target="adContent">공지사항</a></p>
  <hr/>
  <p><a href="${ctp}/admin/adUserManage" target="adContent">회원관리</a></p>
  <hr/>
  <p><a href="${ctp}/admin/adBlockedProductList" target="adContent">상품관리</a></p>
  <hr/>
  <p><a href="${ctp}/admin/adOrderManage" target="adContent">주문관리</a></p>
  <hr/>
  <p><a href="${ctp}/admin/adCategory" target="adContent">카테고리 관리</a></p>
  <hr/>
  <p><a href="${ctp}/admin/adStatistics" target="adContent">통계자료</a></p>
  <hr/>
  <p><a href="${ctp}/admin/adReportList" target="adContent">신고내역</a></p>
  <hr/>
  <p><a href="${ctp}/admin/adFileDelete" target="adContent">저장파일 관리</a></p>
  <hr/>
  <p><a href="${ctp}/" target="_top">홈으로</a></p>
  <p><a href="javascript:logoutCheck()">로그아웃</a></p>
</div>
</body>
</html>