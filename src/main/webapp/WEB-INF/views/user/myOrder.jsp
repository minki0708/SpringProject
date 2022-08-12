<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>My order</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
	'use strict';
/* 	window.onload = function() {  
		let number = document.getElementById('priceShown').value;
		number = number.replace(/,/gi, "");		
		document.getElementById('priceShown').value = number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");	
	}  */

	function bringProduct(part) {
		location.href = "${ctp}/user/myOrder?part="+part;
		if(part == "total"){
			document.getElementById("h2").innerHTML = "전체";	
		}
		else if(part == "buy"){
			document.getElementById("h2").innerHTML = "구매상품";	
		}
		else{
			document.getElementById("h2").innerHTML = "판매상품";			
		}
	}
	
	function orderSelector() {
		let orderSelector = document.getElementById('orderSelector').value;
		let idx = document.getElementById('idx').value;
		
		$.ajax({
			url : "${ctp}/order/updateDeliveryStatus",
			type : "post",
			data : {
				idx : idx,
				deliveryStatus : orderSelector
			},
			async : false,
			success : function(res) {
					alert("배송상태 변경완료");
					location.reload();
			},
			error : function(){
					alert("오류 발생 ");					
			}	
		});
	}
	
	function cancleModal(res){
		let idx = res;
		$("#id01").css('display','block');
		let data = '<button type="button" onclick="orderCancel('+idx+')">제출</button>';
		$("#m1").html(data);
	}
	
	function refundModal(res){
		let idx = res;
		$("#id02").css('display','block');
		let data = '<button type="button" onclick="orderCancel('+idx+')">제출</button>';
		$("#m2").html(data);
	}
	
	function closeModal(res){
		if(res == 1){
			$("#id01").css('display','none');			
		} 
		else{
		 	$("#id02").css('display','none');			
		}
	}
	
	function orderCancel(idx) {
		let reason = document.getElementById("blockText").value;	
		$.ajax({
			url : "${ctp}/order/orderCancel",
			type : "post",
			data : {
				idx : idx,
				reason : reason
			},
			async : false,
			success : function(res) {
				if(res != "1"){
					alert("주문취소는 배송 전, \n 주문 후 7일이내로만 가능합니다");
					return false;
				}
				else if(res != "2"){
					alert("이미 주문취소된 상품입니다");
					return false;
				}
				else{
					alert("주문이 취소되었습니다");
					location.reload();
				}
			},
			error : function(){
				alert("오류 발생 ");					
			}
		});
	}
	
	function orderRefund() {
		
	}
	
</script>
<style>
/* 	.con {
    margin-left: auto;
    margin-right: auto;
	}
	.row::after {
	    content: "";
	    display: block;
	    clear: both;
	}
	.list > ul > li {
    	width: calc(100% / 6);
	    padding: 0 10px;
	}
	.list > ul {
	    margin: 0 -10px;
	} */
	.img-box > img {
	    display: block;
	    width: 11em;
	    height: 11em;
	}
	.inner {
		display: flex;
		justify-content: evenly;
	}
	#list {
		display:flex;
	}
	#list2 {
		display:flex;
	}
	.display_flex {
		display:flex;
	}
</style>	
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<div class="w3-container" style="width: 100%; max-height: 7000px; margin-top: 300px">
		<div class="w3-row w3-round w3-flat-belize-hole" style="width: 80em;height:5em;margin: auto">
			<div class="w3-col m3" style="padding-left: 10%;margin-top: 2%">전체 ${totalOrderCnt}</div>
			<div class="w3-col m3" style="padding-left: 10%;margin-top: 2%">주문확인중 ${checkOrderCnt}</div>
			<div class="w3-col m3" style="padding-left: 10%;margin-top: 2%">배송중 ${deliveryCnt}</div>
			<div class="w3-col m3" style="padding-left: 10%;margin-top: 2%">배송완료 ${deliveryComplCnt}</div>
		</div>
		<div class="w3-margin-top" style="width: 80em;margin: auto;height:3em">
			<a class="w3-button w3-border w3-round w3-ripple w3-hover-white w3-white" href="javascript:bringProduct('total')">전체</a>
			<a class="w3-button w3-border w3-round w3-ripple w3-hover-white w3-white" href="javascript:bringProduct('buy')">나의 구매상품</a>
			<a class="w3-button w3-border w3-round w3-ripple w3-hover-white w3-white" href="javascript:bringProduct('sell')">나의 판매상품</a>
		</div>
	</div>
	 <!-- Tab panes -->
			<div class="w3-container w3-border" style="width: 80em;margin: auto;margin-bottom: 100px">
				<div style="padding-top: 1em">
				<c:if test="${part == 'total'}">
					<h2>전체 내역</h2>
				</c:if>
				<c:if test="${part == 'buy'}">
					<h2>구매 상품</h2>
				</c:if>
				<c:if test="${part == 'sell'}">
					<h2>판매 상품</h2>
				</c:if>
				
				<hr style="border-width: 2px;border-color: black">
				</div>
				<div class="list con" >
			    	<c:set var="curScrStartNo" value="${pageVo.curScrStartNo}"/>
					<c:forEach var="vo" items="${vos}">
						<c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
						
						<!-- 	<ul style="padding-left:4.5em"> -->
										<%-- <div>
											<c:if test="${idx == vo.sellerIdx}">
												<h3>판매상품</h3>
											</c:if>	
											<c:if test="${idx != vo.sellerIdx}">
												<h3>구매상품</h3>
											</c:if>	
										</div> --%>
										<div class="w3-row w3-border-bottom" style="padding-bottom: 0.5em;padding-top: 0.5em">
											<div class="w3-col m1">
												<c:if test="${idx == vo.sellerIdx}">
													<h6><font color="red"> 판매상품 </font></h6><br>
												</c:if>	
												<c:if test="${idx != vo.sellerIdx}">
													<h6><font color="blue">구매상품</font> </h6><br>
												</c:if>
												<c:set var="orderDateLen" value="${fn:length(vo.orderDate)}"/>
								           		<c:set var="orderDate" value="${fn:substring(vo.orderDate,0,10)}"/>
								           		<div class="w3-center-align" style="text-align: center">
									           		<c:if test="${idx == vo.sellerIdx}">
														<font color="gary"><small>구매 날짜</small></font><br>
														[ ${orderDate} ]<br><br>
														<small>[구매자 : ${vo.buyerName}]</small>
													</c:if>	
													<c:if test="${idx != vo.sellerIdx}">
														<font color="gary"><small>판매 날짜</small></font><br>
														[ ${orderDate} ]<br><br>
														<small>[판매자 : ${vo.sellerName}]</small><br><br>
													</c:if>
								           		</div>												
											</div>
											<div class="w3-col m2 w3-padding">
								            	<div class="img-box"><img src="${ctp}/pds/${fSNames[0]}" alt=""></div>
											</div>
											<div class="w3-col m6 w3-padding-left">
												<div class="w3-row">
													<div class="w3-col m12">상품명 : ${vo.title}</div>						         							     
										            <div>주소지 :(${vo.postcode}) ${vo.address}</div>
										            <div>요청사항 : ${vo.deliveryRequire}</div>
													<div>가격 : <input id="priceShown" type="text" value="${vo.priceShown}원" readonly></div>								            	
												</div>
											</div>
											<div class="w3-col m3">
													<c:if test="${idx == vo.sellerIdx}">
														<c:if test="${vo.deliveryStatus != '배송완료' && vo.deliveryStatus != '환불신청'}">
														<select class="w3-select" id="orderSelector" onchange="orderSelector()">												
															<option value="">주문상황 변경</option>
															<option value="주문확인중">주문확인중</option>
															<option value="배송중">배송중</option>
															<option value="배송완료">배송완료</option>
															<option value="배송완료">주문확정</option>
														</select> 
								            			</c:if>
													</c:if>	
													<br>
													주문현황 : [ ${vo.deliveryStatus} ]	
											</div>
											<div>
												<c:if test="${idx != vo.sellerIdx}">
					            				<button onclick="cancleModal(${vo.idx})" class="w3-button w3-tiny w3-black">주문취소신청</button>							            		
					            				<button onclick="refundModal(${vo.idx})" class="w3-button w3-tiny w3-black">환불신청</button>							            								            									        
							            	</c:if>
											</div>
										</div>
										
									<%-- <li id="list" class="cell w3-border w3-margin-right w3-padding-top" >
									    <div id="list2" style="cursor:pointer" onclick="location.href='${ctp}/product/content?idx=${vo.productIdx}';">
										    
								            <div class="product-name" style="width:50em;">
								            	<div>상품명 : ${vo.title}</div>
								            	<div>가격 : <input id="priceShown" type="text" value="${vo.priceShown}원" readonly></div>
								            	<c:set var="orderDateLen" value="${fn:length(vo.orderDate)}"/>
								           		<c:set var="orderDate" value="${fn:substring(vo.orderDate,0,10)}"/>							        					           	
								            	<div>거래 날짜 ${orderDate}</div>
									            <div>보내는 사람 : ${vo.sellerName}</div>							         							     
									            <div>받는 사람 : ${vo.buyerName}</div>							         							     
									            <div>요구사항 : ${vo.deliveryRequire}</div>
								            </div>							        
									    </div>
									    <div class="display_flex" style="width:10em;">
							            	<c:if test="${idx == vo.sellerIdx}">
							            	<div>
							            		주문현황 : ${vo.deliveryStatus}							            		
							            	</div>
							            		<c:if test="${vo.deliveryStatus != '배송완료' && vo.deliveryStatus != '환불신청'}">
													<select id="orderSelector" onchange="orderSelector()">												
														<option value="">주문상황 변경</option>
														<option value="주문확인중">주문확인중</option>
														<option value="배송중">배송중</option>
														<option value="배송완료">배송완료</option>
														<option value="배송완료">주문확정</option>
													</select> 
							            		</c:if>
							            		<c:if test="${vo.deliveryStatus == '배송완료'}">
							            			<div>
							            				<c:set var="deliveryDate" value="${fn:substring(vo.deliveryDate,0,10)}"/>						            			
							            				배송날짜 : ${deliveryDate}
							            			</div> 
							            		</c:if>
							            	</c:if>
							            	
									    </div>
						        	</li>
						        </c:forEach>		    
			            	</ul> --%>
				    	<c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
				    	<input id="idx" type="hidden" value="${vo.idx}">
					</c:forEach>
				<div id="id01" class="w3-modal" style="text-align:center;">
			    	<div class="w3-modal-content" style="height:15em; width:30em;">
			        	<div class="w3-container" >
			            	<span  onclick="closeModal(1)" class="w3-button w3-display-topright">&times;</span>
				           	<h4>주문취소사유를 입력해주세요</h4>
							<textarea id="blockText" rows="5" cols="40" style="resize: none;" placeholder="상세설명 입력란"></textarea>									
           					<div id="m1"></div>
			        	</div>
			     	</div>
  				</div>
				<div id="id02" class="w3-modal" style="text-align:center;">
			    	<div class="w3-modal-content" style="height:20em; width:30em;">
			        	<div class="w3-container" >
			            	<span  onclick="closeModal(2)" class="w3-button w3-display-topright">&times;</span>
				           	<h4>환불사유를 입력해주세요</h4>			     			           	
				           	<div>환불은 내상점 계정설정에 지정된 계좌로 진행됩니다</div>
							<textarea id="blockText" rows="5" cols="40" style="resize: none;" placeholder="상세설명 입력란"></textarea>									
           					<div id="m2"></div>
			        	</div>
			     	</div>
			  	</div>
			</div>
		</div>
</body>
</html>