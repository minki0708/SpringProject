<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<script src="https://kit.fontawesome.com/493cc16663.js" crossorigin="anonymous"></script>
<script>
'use strict';

	$(document).ready(function(){
 		$.ajax({
			type : "post",
			url : "${ctp}/nav",
			contentType : 'application/json; charset=utf-8',
			success : function(vo){
				let name ="";
	 			let category ='<h4 style="margin-bottom:0.5em;padding-top:1em">전체 카테고리</h4><hr>';	
				for(let i=0; i<vo.length; i++){
					category +='<a href="${ctp}/product/categoryProduct?lCategory='+vo[i].largeIdx+'" id="lCategroy'+vo[i].largeIdx+'" class="w3-button" data-name="'+vo[i].name+'" style="display:block;" onmouseenter="mCategory('+vo[i].largeIdx+')">'+vo[i].name+'</a>'; 
				} 							
				category +='<div id="mySidebar2" class="w3-sidebar w3-bar-block w3-border-right" style="display:none; position:relative; left:1.4em; top:5.3em;" onmouseleave="w3_close2(),w3_close3(2)"></div>';
				
				$("#mySidebar").html(category);
	        	/* $("#categroy"+vo[i].largeIdx).attr("data-name", vo[i].name); */
			},
			error : function(){
				alert("전송오류");
			}
		}); 
	}); 
	
 	function w3_open(res) {
			document.getElementById("mySidebar").style.display = "block";	
	} 
 	
	function w3_close() {
	  document.getElementById("mySidebar").style.display = "none";
	}
	function w3_close2() {
	  document.getElementById("mySidebar2").style.display = "none";
	}
	function w3_close3() {
	  document.getElementById("mySidebar3").style.display = "none";
	}


	function mCategory(idx) {
		let name = $("#lCategroy"+idx).data("name");
		let midiumIdx = 0;
		let category = "mCategory";
	
		document.getElementById("mySidebar2").style.display = "block";
		
		$.ajax({
			type : "post",
			url : "${ctp}/product/selectCategory",
			data : {
				largeIdx : idx,
				midiumIdx : midiumIdx,
				category : category
			}, 
			async : false,
			success : function(vo){
			let str = "";
			str = '<h4 style="margin-bottom:0.5em;padding-top:1em">'+name+'</h4><hr>';
					for(let i=0; i<vo.length; i++){
						str +='<a href="${ctp}/product/categoryProduct?mCategory='+vo[i].midiumIdx+'" id="mCategroy'+vo[i].midiumIdx+'" data-name="'+vo[i].name+'" style="display:block;" class="w3-button" onmouseenter="sCategory('+vo[i].midiumIdx+')">'+vo[i].name+'</a>';
					}
					str +='<div id="mySidebar3" class="w3-sidebar w3-bar-block w3-border-right" style="display:none; position:relative; left:26.4em; top:5.3em;" onmouseleave="w3_close3(2)"></div>'; 	
					$("#mySidebar2").html(str); 
			},
			error : function(vo){
				alert("전송오류");
			}
		});
	}
	
	function sCategory(idx) {
		let name = $("#mCategroy"+idx).data("name");
		document.getElementById("mySidebar3").style.display = "block";
		
		let largeIdx = 0;
		let category = "sCategory";
	
		$.ajax({
			type : "post",
			url : "${ctp}/product/selectCategory",
			data : {
				largeIdx : largeIdx,
				midiumIdx : idx,
				category : category
			}, 
			async : false,
			success : function(vo){
					let str = "";
					str = '<h4 style="margin-bottom:0.5em;padding-top:1em">'+name+'</h4><hr>';
					for(let i=0; i<vo.length; i++){
						str +='<a href="${ctp}/product/categoryProduct?sCategory='+vo[i].smallIdx+'" style="display:block;" class="w3-button" onclick="showList('+vo[i].smallIdx+')">'+vo[i].name+'</a>';
					}		
					$("#mySidebar3").html(str);
			},
			error : function(){
				alert("전송오류");
			}
		});
	}
	
	function send() {
		let searchString = document.getElementById("searchString").value;
		let type = "";
		if(searchString == "") return false;
		location.href='${ctp}/product/productSearch?searchString='+searchString
	}
	
</script>
<style>
	input{
		outline: none;		
		border:0 solid black;
		width: 27em;
		margin-top: 0.5em;
	}
	.btn-category{
		display: block;
	}
	#mySidebar2{
		margin-left: 23.5em;
		margin-top: 6.9em;
	}
	#mySidebar3{
		margin-left: 11.8em;
		margin-top: 6.9em;
	}
	/* div {
		border:1px solid black;
	} */
a{
  text-decoration-line: none !important;
}
</style>
<!-- 카테고리, 검색기,로그인 로그아웃,내 상점(마이페이지), 판매하기(업로드)-->
<!-- Navbar -->
<div class="w3-top">
    <div class="w3-white w3-border-bottom " style="height: 3em;border-color: #efefef">   
	    <c:if test="${empty sNickName}">
	    	<a href="${ctp}/user/join" class="w3-bar-item w3-button w3-small w3-right w3-padding-large">회원가입</a>
	    	<a href="${ctp}/user/login" class="w3-bar-item w3-button w3-small w3-right w3-padding-large">로그인</a>
	    </c:if>
	    <c:if test="${not empty sNickName}">
	    	<a href="${ctp}/user/logOut" class="w3-bar-item w3-button w3-small w3-right w3-padding-large">로그아웃</a>
	    	<a href="${ctp}/user/myPage" class="w3-bar-item w3-button w3-small w3-right w3-padding-large">내상점</a>
	    	<a href="${ctp}/user/myOrder" class="w3-bar-item w3-button w3-small w3-right w3-padding-large">내주문</a>
	    	<a href="${ctp}/product/upload" class="w3-bar-item w3-button w3-small w3-right w3-padding-large">판매하기</a>
	    </c:if>
	    <c:if test="${sAuthority == 0}">
	    	<a href="${ctp}/admin/adMenu" class="w3-bar-item w3-small w3-button w3-right w3-padding-large">관리자</a>
		</c:if>
	</div>
	<div class="w3-container w3-white w3-margin-bottom" style="width: 100%;max-height: 8000px;height: 180px">
		<div class="w3-container" style="width: 85%;margin: auto">
	<div class="w3-white " style="height: 7em;border-color: #efefef">
		<div class="w3-sidebar w3-bar-block w3-border-right" style="display:none; position: absolute; text-align:center;margin-top: 9.2em" id="mySidebar" onmouseleave="w3_close(1)">
		</div>
		<div class="w3-container w3-margin-bottom">
			<a class="w3-center" href="${ctp}/" style="margin-left:44%;">
				<img src="${ctp}/images/thunder.png" style="width: 135px;height: 70px;">
			</a>		
		</div>
		<div class="w3-row" style="margin-left:5%;">
		<div class="w3-col m1">
			<div id="menu" class="w3-left" onmouseover="w3_open(1)" >
		  		<span class="w3-xlarge" ><i class="fa fa-bars" aria-hidden="true"></i> </span>
			</div>
		</div>
		<div class="w3-col m11" style="padding-left: 20%">
			<div style="border:2px solid black; height:2.7em; width: 30em;">
		    	<input type="text" name="searchString" id="searchString" placeholder="상품명,지역명 입력"/>		    	
				<a href="javascript:send()"><i class="fa-solid fa-magnifying-glass"></i></a>
			</div>		
		</div>
		</div>
	</div>
	</div>
	</div>
</div>


