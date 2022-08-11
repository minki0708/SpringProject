<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	
	<script>
		'use strict';
		function likeCheck(idx){
			$.ajax({
				type : "post",
				url : "${ctp}/product/like",
				data : {idx : idx},
				async : false,
				success : function(res) {
					if(res == "1") {
						alert("찜하셨습니다");
						location.reload();
					}
					else {
						alert("찜하기를 취소하셨습니다");
						location.reload();
					}
				},
				error : function(){
					alert("로그인후에 이용하실 수 있습니다");
				}
			});
		}
		
	    
	    // 댓글 입력 저장처리(aJax처리)
	    function replyCheck(idx,sIdx) {
		 	if(sIdx == 0) {
		 		alert("로그인 후 이용해주세요");
		 		return false;
		 	}
	    	
	    	let content = $("#content").val();
	    	if(content.trim() == "") {
	    		alert("댓글을 입력하세요!");
	    		$("#content").focus();
	    		return false;
	    	}
	    	let query = {
	    		productIdx : ${vo.idx},
	    		parentIdx : idx,
	    		rOrder : idx,
	    		content  : content,
	    		hostIp   : '${pageContext.request.remoteAddr}'
	    	}
	    	
	    	$.ajax({
	    		type  : "post",
	    		url   : "${ctp}/product/productReplyInput",
	    		data  : query,
	    		async : false,
	    		success:function(data) {
	    			if(data == "1") {
	    				location.reload();
	    			}
	    			else {
	    				alert("댓글 입력실패");
	    			}
	    		},
	    		error : function() {
	    			alert("오류");
	    		}
	    	});
	    } 
	    
	 // 답변글(부모댓글의 댓글)
	    function insertReply(idx, nickName, parentIdx, sIdx) {
		 	if(sIdx == 0) {
		 		alert("로그인 후 이용해주세요");
		 		return false;
		 	}
		 	
	    	$(".replyBoxCloseBtn").hide();	
	    	$(".replyBoxOpenBtn").show();
		 	$(".replyBox").slideUp(500);		 	    		 
			
	    	let insReply = '';
	    	insReply += '<div class="container">';
	    	insReply += '<table class="m-2 p-0" style="width:90%">';
	    	insReply += '<tr>';
	    	insReply += '<td class="p-0 text-left">';
	    	insReply += '<div class="form-group">';
	    	insReply += '답변 댓글 달기: &nbsp;';
	    	insReply += '<input type="text" name="nickName" size="6" value="${sNickName}" readonly class="p-0"/>';
	    	insReply += '</div>';
	    	insReply += '</td>';
	    	insReply += '<td class="p-0 text-right">';
	    	insReply += '<input type="button" value="답글달기" onclick="replyCheck2('+idx+','+parentIdx+')"/>';
	    	insReply += '</td>';
	    	insReply += '</tr>';
	    	insReply += '<tr>';
	    	insReply += '<td colspan="2" class="text-center p-0">';
	    	insReply += '<textarea rows="3" class="form-control p-0" name="content" id="content'+idx+'">';
	    	insReply += '</textarea>';
	    	insReply += '</td>';
	    	insReply += '</tr>';
	    	insReply += '</table>';
	    	insReply += '</div>';
	    	
	    	$("#replyBoxOpenBtn"+idx).hide();
	    	$("#replyBoxCloseBtn"+idx).show();
	    	$("#replyBox"+idx).slideDown(500);
	    	$("#replyBox"+idx).html(insReply);
	    }
	 
	    // 대댓글 입력폼 닫기 처리
	    function closeReply(idx) {
	    	$("#replyBoxOpenBtn"+idx).show();
	    	$("#replyBoxCloseBtn"+idx).hide();
	    	$("#replyBox"+idx).slideUp(500);
	    }
	    
	    // 댓글 저장하기
	    function replyCheck2(idx,parentIdx) {
	    	let productIdx = "${vo.idx}";
	    	let nickName = "${sNickName}";
	    	let content = "content" + idx;
	    	let contentVal = $("#" +content).val();
	    	let hostIp = "${pageContext.request.remoteAddr}";
	    	
	    	if(contentVal == "") {
	    		alert("대댓글(답변글)을 입력하세요?");
	    		$("#" +content).focus();
	    		return false;
	    	}
	    	
	    	let query = {
	    			productIdx  : productIdx,
	    			nickName  : nickName,
	    			content   : contentVal,
	    			hostIp    : hostIp,
	    			parentIdx : parentIdx
	    	}
	    	
	    	$.ajax({
	    		type : "post",
	    		url  : "${ctp}/product/productReplyInput",
	    		data : query,
	    		async : false,
	    		success:function() {
	    			location.reload();
	    		},
	    		error : function() {
	    			alert("오류");
	    		}
	    	});
	    }
	    
	    // 댓글 삭제(ajax처리)
	    function replyDelete(idx,parentIdx) {
	    	let ans = confirm("현재 댓글을 삭제하시겠습니까?");
	    	if(!ans) return false;
	    	
	    	$.ajax({
	    		type  : "post",
	    		url   : "${ctp}/product/replyDelete",
	    		async : false,
	    		data  : {
	    			idx : idx,
	    			parentIdx : parentIdx
	    		},
	    		success:function(data) {
		    		location.reload();
	    		},
	    		error : function() {
	    			alert("오류");
	    		}
	    	});
	    }
	    
	    // 댓글 수정하기
	    function replyUpdate(idx) {
	    	let content = $("#content").val();
	    	let hostIp = '${pageContext.request.remoteAddr}';
	    	let query = {
	    		idx     : idx,
	    		content : content,
	    		hostIp  : hostIp
	    	}
	    	
	    	$.ajax({
	    		type  : "post",
	    		url   : "${ctp}/replyUpdate",
	    		data  : query,
	    		async : false,
	    		success:function(data) {
	    			if(data == "1") {
	    				alert("댓글이 수정되었습니다.");
	    			}
	    			else {
	    				alert("댓글 수정 실패~~");
	    			}
	    		},
	    		error : function() {
	    			alert("오류");
	    		}
	    	});
	    }
	    
	    function buy(idx,sIdx) {
	    	if(sIdx == 0){
	    		alert("로그인 후 이용가능합니다");
	    		return false;
	    	}
	    	else{
	    		location.href='${ctp}/order/payment?idx='+idx+'&sIdx='+sIdx;
	    	}
	    }
	    
	    function replyController(res) {
			if(res == 0){
				document.getElementById("reply").style.display="block";
			}	  	
			else {
				document.getElementById("reply").style.display="none";
			}	  	
	    }
	        
		function replyModal(idx,sIdx,userIdx){
			if(sIdx == 0){
				alert("로그인 후 이용하실수 있습니다");
				return false; 
			} 
			
			$("#reportModal").css('display','block');
			let data = '<input type="button" onclick="reportReply('+idx+','+sIdx+','+userIdx+')" value="제출">';
			$("#report").html(data);
		}
		
		function closeModal(res){
			if(res == 1){
				$("#reportModal2").css('display','none');			
			}
			else {
				$("#reportModal").css('display','none');			
			}
		}
	    
		function reportReply(idx,sIdx,userIdx) {
			let ans = confirm("신고 내용은 번개장터 이용약관 및 정책에 의해서 처리되며, 허위신고 시 번개장터 이용이 제한될 수 있습니다.");
	 		if(ans == 0){
				return false; 
			} 
			else {
			    let reportType = document.getElementById("reportType").value;
				let	reportReason = document.getElementById("reportReason").value;
				
				$.ajax({
					type : "post",
					url : "${ctp}/product/reportReply",
					data : {
						replyIdx : idx,
						reporterIdx : sIdx,
						userIdx : userIdx,
						reportType : reportType,
						detail : reportReason
					},
					async : false,
					success : function(res) {
						alert("신고가 접수되었습니다");	
						location.reload();
					},
					error : function() {
						alert("오류");	
					}
				});
			} 
		}
		
		function productModal(idx,sIdx,userIdx){
			if(sIdx == 0){
				alert("로그인 후 이용하실수 있습니다");
				return false; 
			} 
			$("#reportModal2").css('display','block');
			let data = '<input type="button" onclick="reportProduct('+idx+','+sIdx+','+userIdx+')" value="제출">';
			$("#report2").html(data);
		}
	    
		function reportProduct(idx,sIdx,userIdx) {
			let ans = confirm("신고 내용은 번개장터 이용약관 및 정책에 의해서 처리되며, 허위신고 시 번개장터 이용이 제한될 수 있습니다.");
	 		if(ans == 0){
				return false; 
			} 
			else {
			    let reportType = document.getElementById("reportType2").value;
				let	reportReason = document.getElementById("reportReason2").value; 
				
			$.ajax({
					type : "post",
					url : "${ctp}/product/reportProduct",
					data : {
						productIdx : idx,
						reporterIdx : sIdx,
						userIdx : userIdx,
						reportType : reportType,
						detail : reportReason
					},
					async : false,
					success : function(res) {
						alert("신고가 접수되었습니다");	
						location.reload();
					},
					error : function() {
						alert("오류");	
					}
				}); 
			} 
		}
	</script>
	
</head>
<body>
	<c:if test="${mode == 'user'}">
		<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
		<div style="margin-top:10em"></div>
	</c:if>
	<c:if test="${vo.sell == 0}">
	<table class="w3-table w3-border w3-bordered" style="margin-top:10em" >
	<h3> ${vo.title}</h3>
		<tr>		
			<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
			<c:forEach var="fSName" items="${fSNames}" varStatus="st">
				<c:set var="fSNameLen" value="${fn:length(fSName)}"/>
			  	<c:set var="ext" value="${fn:substring(fSName,fSNameLen-3,fSNameLen)}"/>
			  	<c:set var="extUpper" value="${fn:toUpperCase(ext)}"/>
			  	<c:if test="${extUpper=='JPG' || extUpper=='GIF' || extUpper=='PNG'}">		  	
		           	<div class="img-box" style="height:20em; width:20em;">
		           		<img src="${ctp}/pds/${fSName}" style="height:100%; width:100%"/>
		           	</div>		
		  		</c:if>
	 		</c:forEach> 
		</tr>
	    <tr>
	    	<th>글쓴이</th>
	    	<td>${nickName}</td>
	    	<th>글쓴날짜</th>
	    	<td>${fn:substring(vo.date,0,16)}</td>  <!-- 2022.05.11 10:13:20.5 -->
	    </tr>
	    <tr>
	    	<th>가격</th>
	    	<td>${vo.price}</td>
			
	    	<td></td>
	    </tr>
	    <tr>
	    	<th>주소</th>
	    	<td>${vo.address}</td>
	    	<th>좋아요</th>
	    	<td>
	    		<a id="like" href="javascript:likeCheck('${vo.idx}','${sIdx}')">❤</a>(${likes})
	    	</td>
	    </tr>	
	    <tr>
	    	<th>교환여부</th>
	    	<td>${vo.exchange}</td>
	    	<th>상품상태</th>
	    	<td>${vo.state}</td>
	    </tr>	
	    <tr>
	    	<th>글내용</th>
	    	<td colspan="3" style="height:220px">${fn:replace(vo.content,newLine,"<br/>")}</td>
	    </tr>
	    <tr>
			<button onclick="buy('${vo.idx}','${sIdx}')">바로구매</button>
		</tr>
     	<tr>
	    	<td colspan="4"><a href="${ctp}/product/update?idx=${vo.idx}">수정하기</a></td>
	    </tr>
	    <tr>
		   	<button onclick="productModal('${vo.idx}','${sIdx}','${vo.userIdx}')" class="w3-button w3-black">신고하기</button>			      
		    <div id="reportModal2" class="w3-modal" style="text-align:center;">
		    	<div class="w3-modal-content" style="height:15em; width:30em;">
		        	<div class="w3-container" >
		            	<span  onclick="closeModal(1)" class="w3-button w3-display-topright">&times;</span>
			           	<h4>블럭사유를 입력해주세요</h4>
			           	<select id="reportType2" >
			           		<option value="부적절한 게시글">부적절한 게시글</option>
			           		<option value="도배">언어폭력 (비방,욕설,성희롱)</option>
			           		<option value="광고">거래와 관계 없는 글</option>	
			           		<option value="기타">기타</option>
			           	</select>
						<textarea id="reportReason2" rows="5" cols="40" style="resize: none;" placeholder="상세설명 입력란"></textarea>									
		        			<div id="report2"></div>
		        	</div>
		     	</div>
		  	</div>
	    </tr>
	</table>
	</c:if>
	<c:if test="${vo.sell == 1}">
		<table class="w3-table w3-border w3-bordered" style="margin-top:10em" >
			<h3> ${vo.title}</h3>
			<tr>
				<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
				<c:forEach var="fSName" items="${fSNames}" varStatus="st">
					<c:set var="fSNameLen" value="${fn:length(fSName)}"/>
				  	<c:set var="ext" value="${fn:substring(fSName,fSNameLen-3,fSNameLen)}"/>
				  	<c:set var="extUpper" value="${fn:toUpperCase(ext)}"/>
				  	<c:if test="${extUpper=='JPG' || extUpper=='GIF' || extUpper=='PNG'}">		  	
			           	<div class="img-box">
			           		<img src="${ctp}/pds/${fSName}" style="height:10em; width:10em;" >
			           	</div>		
			  		</c:if>
		 		</c:forEach>
			</tr>
		    <tr>
		    	<th>글쓴이</th>
		    	<td>${nickName}</td>
		    	<th>글쓴날짜</th>
		    	<td>${fn:substring(vo.date,0,16)}</td>  <!-- 2022.05.11 10:13:20.5 -->
		    </tr>
		    <tr>
		    	<th>가격</th>
		    	<td>${vo.price}</td>
	
		    	<td></td>
		    </tr>
		    <tr>
		    	<th>주소</th>
		    	<td>${vo.address}</td>
		    	<th>좋아요</th>
		    	<td>
		    		<a id="like" href="javascript:likeCheck('${vo.idx}','${sIdx}')">❤</a>(${likes})
		    	</td>
		    </tr>	
		    <tr>
		    	<th>교환여부</th>
		    	<td>${vo.exchange}</td>
		    	<th>상품상태</th>
		    	<td>${vo.state}</td>
		    </tr>	
		    <tr>
		    	<th>글내용</th>
		    	<td colspan="3" style="height:220px"><h3>판매완료된 상품입니다</h3></td>
		    </tr>
		</table>
	</c:if>

	<!-- 댓글 처리(출력/입력) -->
	<!-- 댓글 출력 처리 -->
	<div class="container text-center mb-3">
	  <input type="button" value="댓글보이기" id="replyViewBtn" onclick="replyController(0)" class="btn btn-secondary"/>
	  <input type="button" value="댓글가리기" id="replyHiddenBtn" onclick="replyController(1)" class="btn btn-info"/>
	</div>
	<div id="reply">
		<table class="table table-hover text-center">
			<tr>
			  <th>작성자</th>
			  <th>댓글내용</th>
			  <th>작성일자</th>
			  <th>접속IP</th>
			  <th>답글</th>
			</tr>
	        <c:forEach var="replyVo" items="${replyVos}" varStatus="st">
				<c:if test="${replyVo.deleteSwitch != 0}">
					<tr>
						<td class="text-left" colspan="5">삭제된 댓글입니다</td>
					</tr>
				</c:if>		
				<c:if test="${replyVo.parentIdx == 0 and replyVo.deleteSwitch != 1}">		<!-- 부모댓글의 경우는 들여쓰지 하지 않는다. -->
	        		<tr>
					    <td class="text-left">
					    	&nbsp;&nbsp; ${replyVo.nickName}
					        <c:if test="${sIdx == replyVo.userIdx}">
					            <a href="javascript:replyDelete(${replyVo.idx})" title="삭제하기"><span class="glyphicon glyphicon-remove">삭제하기</span></a>
					        </c:if>  
					    </td>
				        <td class="text-left">
				            ${fn:replace(replyVo.content,newLine,"<br/>")}
				        </td>
				        <td>
			          	    ${replyVo.RDate}
				        </td> 
				        <td>${replyVo.hostIp}</td>
			    		<td>
						    <c:if test="${replyVo.parentIdx == 0}">
						        <input type="button" value="답글" onclick="insertReply('${replyVo.idx}','${replyVo.nickName}','${replyVo.idx}','${sIdx}')" id="replyBoxOpenBtn${replyVo.idx}" class="btn btn-secondary btn-sm replyBoxOpenBtn"/>
						        <input type="button" value="닫기" onclick="closeReply('${replyVo.idx}')" id="replyBoxCloseBtn${replyVo.idx}" class="btn btn-info btn-sm replyBoxCloseBtn" style="display:none;"/>
						    </c:if>			      
				            <c:if test="${replyVo.parentIdx != 0}">
						        <input type="button" value="답글" onclick="insertReply('${replyVo.idx}','${replyVo.nickName}','${replyVo.parentIdx}','${sIdx}')" id="replyBoxOpenBtn${replyVo.idx}" class="btn btn-secondary btn-sm replyBoxOpenBtn"/>
						        <input type="button" value="닫기" onclick="closeReply('${replyVo.idx}')" id="replyBoxCloseBtn${replyVo.idx}" class="btn btn-info btn-sm replyBoxCloseBtn" style="display:none;"/>
				            </c:if>			      
	      	    		</td>
			    	</tr>
		            <tr>
		                <td colspan="5" class="m-0 p-0" style="border-top:none;"><div id="replyBox${replyVo.idx}" class="replyBox"></div></td>
		            </tr>
			    </c:if>
	          	<c:set var="idx" value="${replyVo.idx}"/> 
				<c:forEach var="replyVo" items="${replyVos}" varStatus="st">
					<c:if test="${replyVo.parentIdx != 0 and replyVo.parentIdx == idx}">		<!-- 부모댓글의 경우는 들여쓰지 하지 않는다. -->
						<tr>
						    <td class="text-left">
								&nbsp;&nbsp;&nbsp;&nbsp;└ ${replyVo.nickName}
						        <c:if test="${sIdx == replyVo.userIdx}">
						            <a href="javascript:replyDelete('${replyVo.idx}','${replyVo.parentIdx}')" title="삭제하기">삭제하기</a>
						        </c:if>  
						    </td>
					        <td class="text-left">
					            ${fn:replace(replyVo.content,newLine,"<br/>")}
					        </td>
					        <td>
				          	    ${replyVo.RDate}
					        </td> 
			        		<td>${replyVo.hostIp}</td>
					   	    <td>
							    <c:if test="${replyVo.parentIdx == 0}">
							        <input type="button" value="답글" onclick="insertReply('${replyVo.idx}','${replyVo.nickName}','${replyVo.idx}','${sIdx}')" id="replyBoxOpenBtn${replyVo.idx}" class="btn btn-secondary btn-sm replyBoxOpenBtn"/>
							        <input type="button" value="닫기" onclick="closeReply('${replyVo.idx}')" id="replyBoxCloseBtn${replyVo.idx}" class="btn btn-info btn-sm replyBoxCloseBtn" style="display:none;"/>
							    </c:if>			      
					            <c:if test="${replyVo.parentIdx != 0}">
							        <input type="button" value="답글" onclick="insertReply('${replyVo.idx}','${replyVo.nickName}','${replyVo.parentIdx}','${sIdx}')" id="replyBoxOpenBtn${replyVo.idx}" class="btn btn-secondary btn-sm replyBoxOpenBtn"/>
							        <input type="button" value="닫기" onclick="closeReply('${replyVo.idx}')" id="replyBoxCloseBtn${replyVo.idx}" class="btn btn-info btn-sm replyBoxCloseBtn" style="display:none;"/>
					            </c:if>
					            <button onclick="replyModal('${replyVo.idx}','${sIdx}','${replyVo.userIdx}')" class="w3-button w3-black">신고하기</button>			      
							    <div id="reportModal" class="w3-modal" style="text-align:center;">
							    	<div class="w3-modal-content" style="height:15em; width:30em;">
							        	<div class="w3-container" >
							            	<span  onclick="closeModal()" class="w3-button w3-display-topright">&times;</span>
								           	<h4>블럭사유를 입력해주세요</h4>
								           	<select id="reportType" >
								           		<option value="부적절한 게시글">부적절한 게시글</option>
								           		<option value="도배">언어폭력 (비방,욕설,성희롱)</option>
								           		<option value="광고">거래와 관계 없는 글</option>	
								           		<option value="기타">기타</option>
								           	</select>
											<textarea id="reportReason" rows="5" cols="40" style="resize: none;" placeholder="상세설명 입력란"></textarea>									
						         			<div id="report"></div>
							        	</div>
							     	</div>
							  	</div>
			      	    	</td>			      	
			    		</tr>
			            <tr>
			                <td colspan="5" class="m-0 p-0" style="border-top:none;"><div id="replyBox${replyVo.idx}" class="replyBox"></div></td>
			            </tr>
					</c:if>
			    </c:forEach>	
		    </c:forEach>
		</table> 
	</div>
	<!-- 댓글 입력 -->
	<form name="replyForm" method="post" action="productReplyInput">
	<table class="table text-center">
	  <tr>
	    <td style="width:90%" class="text-left">
	      글내용 :
	      <textarea rows="4" name="content" id="content" class="form-control"></textarea>
	    </td>
	    <td style="width:15%">
	    	<br/>
	    	<p>작성자 : ${sNickName}</p>
	    	<p>
	    	  <c:if test="${empty  replyContent}"><input type="button" value="댓글달기" onclick="replyCheck(0,'${sIdx}')" class="btn btn-info btn-sm"/></c:if>
	    	  <c:if test="${!empty replyContent}"><input type="button" value="댓글수정" onclick="boReplyUpdate(${replyIdx})" class="btn btn-info btn-sm"/></c:if>
	    	</p>
	    </td>
	  </tr>
	</table> 
</form>
</body>
</html>