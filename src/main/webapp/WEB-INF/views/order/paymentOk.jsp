<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>paymentOk.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
	
	<script>
		
		IMP.init('imp21064327');
		IMP.request_pay({
		    pg : 'inicis', // version 1.1.0부터 지원.		// 변경된 방침에서는 pg : 'html5_inicis' 로 고쳐준다.
		    pay_method : 'card',
		    merchant_uid : '' + new Date().getTime(),
		    name : '${vo.name}',
		    amount : 10, //판매 가격
		    buyer_email : '${vo.email}',
		    buyer_name : '${vo.name}',
		    buyer_tel : '${vo.tel}',
		    buyer_addr : '${vo.address}',
		    buyer_postcode : '${vo.postcode}'
		}, function(rsp) {
			  var paySw = 'no';
		    if ( rsp.success ) {
		        var msg = '결제가 완료되었습니다.';
		        paySw = 'ok';
		    } else {
		        var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		    }
		    alert(msg);
		    if(paySw == 'no') {
			    alert("다시 상품창으로 이동합니다.");
		    	location.href='${ctp}/order/payment?idx=${vo.productIdx}&sIdx=${vo.buyerIdx}';
		    }
		    else {
					location.href='${ctp}/order/paymentResult';
		    }
		});
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br></p>
<div class="container">
  <hr/>
  <h3>현재 결제가 진행중입니다.</h3>
  <hr/>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>