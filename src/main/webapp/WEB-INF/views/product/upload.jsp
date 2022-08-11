<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<style>
img {
	width: 500px;
	height: 500px;
}
</style>
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
			return false;
		}
		else if(address == ""){
			alert("거래지역을 선택해주세요.");
			document.getElementById("addButton").focus();
			return false;
		}
		else if(price == ""){
			alert("가격을 입력해주세요.");
			document.getElementById("sPrice").focus();
			return false;
		}
		else if(content == ""){
			alert("상세설명을 입력해주세요.");
			document.getElementById("content").focus();
			return false;
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
	
	function setCommas() {  
		let number = document.getElementById('sPrice').value;
		number = number.replace(/,/gi, "");
		document.getElementById('price').value = number;			
		document.getElementById('sPrice').value = number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");	
	} 
	
	function thumbNailImage(input) {
        if (input.files && input.files[0]) {
           var reader = new FileReader();
           reader.onload = function (e) {
              $('#thumbNailImageShow').attr('src', e.target.result);
           }                
           reader.readAsDataURL(input.files[0]);
        }
     }

	</script>
	<style>
		input::-webkit-outer-spin-button,
		input::-webkit-inner-spin-button {
		  -webkit-appearance: none;
		  margin: 0;
		}
		.textb {
			 width : 1000px;
			 height : 1000px;
		}
		.textA{
			width : 1000px;
			 height : 1000px;
		}
		.textc{
			width : 1000px;
			 height : 1000px;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="w3-container" style="width: 100%;max-height: 8000px;margin-top:15em;">
	<div class="w3-container" style="width: 85%;margin: auto;margin-bottom: 15em">
	<h3>상품 등록</h3>
	<hr style="border-color: black;border-width: 2px">
	<form  name="myForm" method="post" enctype="multipart/form-data">
	<div class="w3-half">
		<div class="w3-center ">
			<h6><b>상품 대표 사진</b></h6>                 
        	<img  id="thumbNailImageShow" style="height:20em;width:20em">
        </div>
        <div class="w3-center w3-margin-top">   
			<label for=file class="w3-button w3-white w3-border w3-round-xlarge" style="font-size:15;margin:15 auto;width:20%">사진등록</label>
	        <input type="file" id="file" name="file" onchange="thumbNailImage(this)" multiple style="display:none" accept=".jpg,.gif,.png,.jpeg" required/>        
        </div>
        <h6><b>상품 상세 내용</b></h6> 
		<textarea  rows="12" name="content" id="CKEDITOR" class="form-control" required style="resize: none"></textarea>
		<script>
	      CKEDITOR.replace("content",{
	      //		removePlugins : 'resize',
	      		filebrowserUploadUrl : "${ctp}/product/imageUpload",
	      		uploadUrl : "${ctp}/product/imageUpload"
	      	});
	      </script>
	</div>
	<div class="w3-half w3-padding">
	<div class="w3-container w3-row">
		<h6><b>카테고리선택</b></h6>
		<div class="w3-col m4">
		<label for="largeSelector"><small><b>대분류</b></small></label>
		<select class="w3-select w3-border w3-round" id="largeSelector" name="largeIdx" onchange="categoryChoose(1)" style="width: 95%">
		      <option value="">대분류 선택</option>
		      <c:forEach var="vo" items="${vos}" varStatus="st">
		      	<option value="${vo.largeIdx}" >${vo.name}</option>
		      </c:forEach>
		      </select>
		</div>
		<div class="w3-col m4">
		<label for="midumSelector"><small><b>중분류</b></small></label>
		<select class="w3-select w3-border w3-round" id="midumSelector" name="midiumIdx" onchange="categoryChoose(2)" style="width: 95%">
		        <option value="">중분류 선택</option>
		      </select>
		</div>
		<div class="w3-col m4">
		<label for="smallSelector"><small><b>소분류</b></small></label>
		<select class="w3-select w3-border w3-round" id="smallSelector" name="smallIdx" style="width: 95%">
		        <option value="">소분류 선택</option>
		      </select>
		</div>
		<div class="w3-col m12" style="margin-top: 1em">
			<h6><b>제목</b></h6>
			<input type="text" id="title" name="title" class="w3-input w3-border w3-round" autofocus required placeholder="상품의 제목을 입력해주세요"/>
		</div>
		<div class="w3-col m12" style="margin-top: 1em;margin-bottom: 1em">
			<h6><b>거래 지역</b></h6>
			<label><font color="gray"><small><b>우편번호</b></small></font></label>
			<div class="w3-row">
				<div class="w3-col m6">
				<input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control">
				</div>
				<div class="w3-col m1">&nbsp;</div>
				<div class="w3-col m5">
				<input type="button" onclick="sample6_execDaumPostcode()" id="addButton" value="주소 찾기" class="btn btn-secondary" style="width: 12em">
				</div>
			</div>
			<label><font color="gray"><small><b>주소</b></small></font></label>
			<div class="w3-row">
				<div class="w3-col m12">
				<input type="text" name="roadAddress" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
				</div>
				<input type="hidden" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control">
				<input type="hidden" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
			</div>
		</div>
		<div class="w3-row">
			<h6><b>제품 상태</b></h6>
			<div class="w3-col m6">
			<input class="w3-radio w3-small" type="radio" id="r1" name="state" value="중고상품" checked>
			<label>중고 상품</label>
			</div>
			<div class="w3-col m6">
			<input class="w3-radio w3-small" type="radio" id="r2" name="state" value="새상품">
			<label>새 상품</label>
			</div>
		</div>
		<div class="w3-row" style="margin-top: 1em">
			<h6><b>교환 가능 여부</b></h6>
			<div class="w3-col m6">
			<input class="w3-radio w3-small" type="radio" name="exchange" value="교환불가" checked>
			<label>교환 불가</label>
			</div>
			<div class="w3-col m6">
			<input class="w3-radio w3-small" type="radio" name="exchange" value="교환가능">
			<label>교환 가능</label>
			</div>
		</div>
		<div class="w3-row" style="margin-top: 1em">
			<h6><b>가격</b></h6>
			<div class="w3-col m6"><input class="w3-input" type="text" id="sPrice" name="sPrice" oninput="setCommas()" placeholder="숫자만 입력해주세요" ></div>
			<div class="w3-col m6"><p style="padding-top: 5%">원</p></div>
		</div>
		<div class="w3-row" style="margin-top: 1em">
			<h6><b>수량</b></h6>
			<div class="w3-col m6"><input class="w3-input" type="number" value="1" /></div>
			<div class="w3-col m6"><p style="padding-top: 5%">개</p></div>
		</div>
	</div>
	<div class="w3-center w3-margin-top">
		  <input type="button" value="글올리기" onclick="fCheck()" class="w3-button w3-flat-belize-hole w3-hover-blue w3-ripple w3-round"/>
	  </div>
	</div>
	  <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}"/>
	  <input type="hidden" name="nickName" value="${nickName}"/>
	  <input type="hidden" id="address" name="address" value=""/> 
	  <input type="hidden" id="price" name="price" value=""/> 
	  <input type="hidden" name="fileSize"/>
	  
  </form>
  </div>
</div>    
</body>
</html>