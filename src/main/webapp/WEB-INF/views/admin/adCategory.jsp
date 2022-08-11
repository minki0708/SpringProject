<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script>
	'use strict';
		let largeIdx = 0;
		let midiumIdx = 0;
		let smallIdx = 0;

		//	카테고리 등록
		function category(res) {
			largeIdx = document.getElementById("largeSelector").value;
			midiumIdx = document.getElementById("midumSelector").value;
			let name = "";
			let category = "";
			
			if(res == 1){
				name = document.getElementById("largeCategory").value;
				category = "lCategory";
				largeIdx = 0;
				midiumIdx = 0;
			}
			else if(res == 2){
				if(largeIdx == 0){
					alert("대분류를 먼저 선택해주세요");
					return false;
				}
				name = document.getElementById("midiumCategory").value;
				category = "mCategory";
				midiumIdx = 0;
			}
			else if(res == 3){
				if(largeIdx == 0 || midiumIdx == 0){
					alert("중분류를 먼저 선택해주세요");
					return false;
				}
				name = document.getElementById("smallCategory").value;
				category = "sCategory";
			}
					
			$.ajax({
				type : "post",
				url : "${ctp}/admin/insertCategory",
				data : {
					largeIdx : largeIdx,
					midiumIdx : midiumIdx,
					name : name,
					category : category
				}, 
				success : function(res){
					if(res != "1"){
						alert("등록실패")
					}
					else {
						alert("등록완료")						
						location.reload();
					}
				},
				error : function(){
					alert("전송오류");
				}
			});
		}

		// 카테고리 셀렉터
		function categoryChoose(res){
			largeIdx = document.getElementById("largeSelector").value;
			midiumIdx = document.getElementById("midumSelector").value;
			let category = "";
			if(res == 1){
				category = "mCategory";
				midiumIdx = 0;
			}
			else{
				category = "sCategory";
				largeIdx = 0;
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/selectCategory",
				data : {
					largeIdx : largeIdx,
					midiumIdx : midiumIdx,
					category : category
				}, 
				success : function(vo){
					let str = "";
					if(res == 1){
						str += '<option value="">중분류 선택</option>';
						for(let i=0; i<vo.length; i++){
							str +='<option value="'+vo[i].midiumIdx+'">'+vo[i].name+'</option>';
						}
						$("#midumSelector").html(str);
					}
					else{
						str += '<option value="">소분류 선택</option>';
						for(let i=0; i<vo.length; i++){
							str +='<option value="'+vo[i].smallIdx+'">'+vo[i].name+'</option>';
						}
						$("#smallSelector").html(str);
					}
				},
				error : function(){
					alert("전송오류");
				}
			});
		} 

		//	카테고리 업데이트
		function updateCategory(res) {
			let category ="";
			if(res == 1){
				largeIdx = document.getElementById("largeSelector").value;
				category = document.getElementById("largeCategory").value;
				
				if(largeIdx == "" || category == "") {
					alert("수정하실 대분류를 선택하고 텍스트를 입력해주세요")
					return false;
				}
				
				midiumIdx = 0;
				smallIdx = 0;
			}
			else if(res == 2){
				midiumIdx = document.getElementById("midumSelector").value;				
				category = document.getElementById("midiumCategory").value;		
				
				if(midiumIdx == "" || category == "") {
					alert("수정하실 중분류를 선택하고 텍스트를 입력해주세요")
					return false;
				}
				
				largeIdx = 0;
				smallIdx = 0;
			}
			else if(res == 3){
				smallIdx = document.getElementById("smallSelector").value;
				category = document.getElementById("smallCategory").value;	
				
				if(smallIdx == "" || category == "") {
					alert("수정하실 소분류를 선택하고 텍스트를 입력해주세요")
					return false;
				}
				
				largeIdx = 0;
				midiumIdx = 0;
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/admin/updateCategory",
				data : {
					largeIdx : largeIdx,
					midiumIdx : midiumIdx,
					smallIdx : smallIdx,
					category : category
				}, 
				success : function(res){
					if(res != "1"){
						alert("수정실패")
					}
					else{
						alert("수정완료")		
						location.reload();
					}
				},
				error : function(){
					alert("전송오류")
				}
			});
		}
		
		//	카테고리 삭제
		function deleteCategory(res) {
			largeIdx = document.getElementById("largeSelector").value;
			midiumIdx = document.getElementById("midumSelector").value;
			smallIdx = document.getElementById("smallSelector").value;
			let category;
			
			if(res == 1){
				if(largeIdx == "") {
					alert("삭제하실 대분류를 선택해주세요");
					return false; 
				}
				
				let ans = confirm("대분류를 삭제하시면 포함되는 모든 중,소분류가 삭제됩니다 \n정말로 삭제하시겠습니까?")
				
				if(ans != 1) {
					return false;
				}
				
				category = "lCategory"; 
				midiumIdx = 0;
				smallIdx = 0;
			}
			else if(res == 2){
				if(largeIdx == "") {
					alert("삭제하실 중분류를 선택해주세요");
					return false; 
				}
				
				let ans = confirm("중분류를 삭제하시면 포함되는 모든 소분류가 삭제됩니다 \n정말로 삭제하시겠습니까?")
				
				if(ans != 1) {
					return false;
				}
				
				category = "mCategory";
				smallIdx = 0;
			}
			else if(res == 3){
				if(largeIdx == "") {
					alert("삭제하실 소분류를 선택해주세요");
					return false; 
				}
				
				let ans = confirm("정말로 삭제하시겠습니까?")
				
				if(ans != 1) {
					return false;
				}
				
				category = "sCategory";
			}

			$.ajax({
				type : "post",
				url : "${ctp}/admin/deleteCategory",
				data : {
					largeIdx : largeIdx,
					midiumIdx : midiumIdx,
					smallIdx : smallIdx,
					category : category
				}, 
				success : function(res){
					if(res != "1"){
						alert("삭제실패")
					}
					else{
						alert("삭제완료")		
						location.reload();
					}
				},
				error : function(){
					alert("전송오류")
				}
			});
			
		}
		
	</script>
</head>
<body>
<div class="container">
	<div class="w3-container" style="width: 100%;max-height: 3000px;margin-top: 50px">
		<div class="w3-container" style="width: 1200px;margin: auto">
		<h2>카테고리 관리</h2>
		<hr>
	<form>
		<div>
			대분류<input id="largeCategory" type="text">
			<input class="w3-button w3-round w3-small w3-border w3-border-blue" type="button" onclick="category(1)" value="생성">
			<input class="w3-button w3-round w3-small w3-border w3-border-yellow" type="button" onclick="updateCategory(1)" value="수정">		
			<input class="w3-button w3-round w3-small w3-border w3-border-red" type="button" onclick="deleteCategory(1)" value="삭제">		
		</div>
		<div>
			중분류<input id="midiumCategory" type="text">
			<input class="w3-button w3-round w3-small w3-border w3-border-blue" type="button" onclick="category(2)" value="생성">
			<input class="w3-button w3-round w3-small w3-border w3-border-yellow"type="button" onclick="updateCategory(2)" value="수정">	
			<input class="w3-button w3-round w3-small w3-border w3-border-red" type="button" onclick="deleteCategory(2)" value="삭제">	
		</div>
		<div>
			소분류<input id="smallCategory" type="text">
			<input class="w3-button w3-round w3-small w3-border w3-border-blue" type="button" onclick="category(3)" value="생성">
			<input class="w3-button w3-round w3-small w3-border w3-border-yellow" type="button" onclick="updateCategory(3)" value="수정">	
			<input class="w3-button w3-round w3-small w3-border w3-border-red" type="button" onclick="deleteCategory(3)" value="삭제">	
		</div>
		<select id="largeSelector" onchange="categoryChoose(1)">
	      <option value="">대분류 선택</option>
	      <c:forEach var="vo" items="${vos}" varStatus="st">
	      	<option value="${vo.largeIdx}" >${vo.name}</option>
	      </c:forEach>
	    </select> 
		<select id="midumSelector" onchange="categoryChoose(2)">
	      <option value="">중분류 선택</option>
	    </select>
		<select id="smallSelector">
	      <option value="">소분류 선택</option>
	    </select>
	</form>
	</div></div></div>
</body>
</html>