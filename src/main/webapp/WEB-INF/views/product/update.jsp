<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js" ></script>
  	<script src="${ctp}/resources/js/address.js"></script>
  	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<script>
	'use strict';
	let largeIdx;
	let midiumIdx;
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
			url : "${ctp}/product/selectCategory",
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
	  function fCheck() {
	    	let maxSize = 1024 * 1024 * 20;
	    	let title = $("#title").val();
	    	let file = $("#file").val();
	    	let category = $("#smallSelector").val();
	    	let address = document.getElementById("sample6_postcode").value + "/" + document.getElementById("sample6_address").value;
	    	let price = $("#price").val();
	    	let content = $("#content").val();
	    	
	    	if(file == "" || file == null) {
	    		alert("업로드할 사진을 선택하세요.");
	    		return false;
	    	}
	    	else if(title.trim() == "") {
	    		alert("제목을 입력하세요.");
	    		document.getElementById("title").focus();
	    		return false;
	    	}
	    	else if(category == ""){
	    		alert("카테고리를 선택해주세요.");
	    		document.getElementById("smallSelector").focus();
	    	}
	    	else if(address == ""){
	    		alert("카테고리를 선택해주세요.");
	    		document.getElementById("addButton").focus();
	    	}
	    	else if(price == ""){
	    		alert("가격을 입력해주세요.");
	    		document.getElementById("price").focus();
	    	}
	    	else if(content == ""){
	    		alert("상세설명을 입력해주세요.");
	    		document.getElementById("content").focus();
	    	}    	
	    	
	    	let fileSize = 0;
	    	let files = document.getElementById("file").files;
	    	for(let i=0; i<files.length; i++) {
	    		file = files[i];
	    		let fName;
	  			
	    		if(file.name != "") {
		  			fName = file.name;
		  			let ext = fName.substring(fName.lastIndexOf(".")+1)		// 확장자추출
			    	let uExt = ext.toUpperCase();
		  			
		  			if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "PDF") {
			    		alert("업로드 가능한 파일은 'JPG/GIF/PNG/PDF' 입니다.")
			    		return false;
			    	}
		  			else {
		  				fileSize += file.size;
		  			}
	    		}
	    	}
	    	if(fileSize > maxSize) {
	    		alert("사진의 최대용량은 20MByte 입니다.")
	    		return false;
	    	}
	    	else {
	    		document.getElementById("address").value = address;
	    		myForm.submit();
	    	}
	    }
	</script>
	<style>
		input::-webkit-outer-spin-button,
		input::-webkit-inner-spin-button {
		  -webkit-appearance: none;
		  margin: 0;
		}
	</style>
</head>
<body>
<div class="container">
	<h2>상품 썸네일</h2>
	<form name="myForm" method="post" enctype="multipart/form-data">
		<input type="file" name="file" id="file" class="form-control-file border" accept=".jpg,.gif,.png,.pdf"/>
	  	<table class="table">
	    <tr>
	      <th>제목</th>
	      <td><input type="text" id="title" name="title" value="${vo.title}"  placeholder="상품 제목을 입력해주세요" class="form-control" autofocus required /></td>
	    </tr>
	    <tr>
	      <th>
		  <select id="largeSelector" name="largeIdx" onchange="categoryChoose(1)">
			      <option value="${vo.largeIdx}" selected>${vo.LName}</option>
			      <c:forEach var="vo" items="${vos}" varStatus="st">
			      	<option value="${vo.largeIdx}" >${vo.name}</option>
			      </c:forEach>
		      </select>
			  <select id="midumSelector" name="midiumIdx" onchange="categoryChoose(2)">
		          <option value="${vo.midiumIdx}" selected>${vo.MName}</option>
		      </select>
			  <select id="smallSelector" name="smallIdx" onchange="categoryChoose(2)">
		          <option value="${vo.smallIdx}" selected>${vo.SName}</option>
		      </select>
	      </th>	      
	    </tr>
	    <tr>
	      	<th>거래지역</th>
	      	<td>
				<input type="hidden" name="address" id="address">
				<div class="input-group mb-1">
					<input type="text" name="postcode" id="sample6_postcode" value="${fn:split(vo.address,'/')[0]}" placeholder="우편번호" class="form-control">
					<input type="text" name="roadAddress" id="sample6_address" size="50" value="${fn:split(vo.address,'/')[1]}" placeholder="주소" class="form-control mb-1">
					<div class="input-group-append">
						<input type="button" onclick="sample6_execDaumPostcode()" id="addButton" value="우편번호 찾기" class="btn btn-secondary">
					</div>
					<div class="input-group mb-1">
						<input type="hidden" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
						<div class="input-group-append">
							<input type="hidden" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
						</div>
					</div>
	    		</div>
			</td>
	    </tr>
	    <tr>
	    	<th>
	    	    <div>
			    	중고상품<input type="radio" name="product" value="oldProduct" checked>		    	
		    	</div>
		    	<div>
					새상품<input type="radio" name="product" value="newProduct">
		    	</div>
	    	</th>
	    </tr>
		<tr>
	    	<th>
	    		<div>
			    	교환불가<input type="radio" name="exchange" value="exchangeUnavailable" checked>
	    		</div>
	    		<div>
					교환가능<input type="radio" name="exchange" value="exchangeAvailable">
	    		</div>
	    	</th>
	    <tr>
	    	<th>
				가격<input type="number" id="price" name="price" value="${vo.price}" placeholder="숫자만 입력해주세요" >원
	    	</th>
	    </tr>	    
	    <tr>
	      <th>상세설명</th>
	      <td><textarea rows="6" name="content" id="CKEDITOR" class="form-control" required>${vo.content}</textarea></td>
	      <script>
	      	CKEDITOR.replace("content",{
	      		height:500,
	      		filebrowserUploadUrl : "${ctp}/product/imageUpload",
	      		uploadUrl : "${ctp}/product/imageUpload" 
	      	});
	      </script>
	    </tr>
	    <tr>
	    	<th>수량</th>
	    	<td>
	    		<input type="number" value="1" />
	    	</td>
	    </tr>
	    <tr>
	      <td colspan="2" class="text-center">
	        <input type="button" value="글올리기" onclick="fCheck()" class="btn btn-secondary"/> &nbsp;
	        <input type="reset" value="다시입력" class="btn btn-secondary"/> &nbsp;
	        <input type="button" value="돌아가기" onclick="location.href='${ctp}/board/boList';" class="btn btn-secondary"/>
	      </td>
	    </tr>
	  </table>
	  <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
	  <input type="hidden" name="nickName" value="${nickName}"/>
	  <input type="hidden" name="nickName" value="${vo.idx}"/>
	  <input type="hidden" id="address" name="address" value=""/>
	  <input type="hidden" name="fileSize"/>
  </form>
</div>	

</body>
</html>